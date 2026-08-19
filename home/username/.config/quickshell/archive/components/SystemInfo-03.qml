pragma Singleton

// Importing the Quickshell core module, which provides the Singleton base, the environment accessor, and iconPath
import Quickshell
// Importing the Quickshell IO module, which provides Process and StdioCollector
import Quickshell.Io

// Gathering system information from several sources, exposing parsed properties to any view that imports it
Singleton {
  id: root

  // --- Distribution identity, from the freedesktop os-release standard ---
  property string prettyName: "Linux"
  property string distroName: ""
  property string distroVersion: ""
  property string distroVersionId: ""
  property string distroCodename: ""
  property string distroId: ""
  property string osReleaseLogo: ""

  // Composing the version line as the capitalised codename followed by the numeric version
  readonly property string versionDisplay:
  {
    if (root.distroCodename.length > 0)
    {
      const capitalised = root.distroCodename.charAt(0).toUpperCase() + root.distroCodename.substring(1)
      return root.distroVersionId.length > 0 ? capitalised + " " + root.distroVersionId : capitalised
    }
    return root.distroVersionId.length > 0 ? root.distroVersionId : root.distroVersion
  }

  // --- Serial number, resolved through a three-step privileged fallback chain via pkexec ---
  property string serial: ""
  property bool serialPending: false
  property int serialStep: 0

  function isUsableSerial(value)
  {
    const v = value.trim()
    if (v.length === 0) { return false }
    const placeholders = ["none", "n/a", "default string", "unknown", "not specified", "to be filled by o.e.m."]
    return placeholders.indexOf(v.toLowerCase()) === -1
  }

  function revealSerial()
  {
    root.serialPending = true
    root.serialStep = 1
    serialProc1.running = true
  }

  // --- Kernel ---
  property string kernelRelease: ""
  property string kernelArch: ""

  // --- fastfetch-parsed hardware properties ---
  property bool fastfetchAvailable: false

  // Overview
  property string chip: ""
  property string motherboardVendor: ""
  property string motherboardName: ""
  property string processorSummary: ""
  property string memorySummary: ""
  property string gpuName: ""
  property string gpuVendor: ""
  property string gpuDriver: ""
  property string locale: ""

  // Appearance
  property string graphicsPlatform: ""
  property string wmName: ""
  property string wmVersion: ""
  property string qtTheme: ""
  property string gtkTheme: ""
  property string qtIcons: ""
  property string gtkIcons: ""
  property string qtFont: ""
  property string gtk2Font: ""
  property string gtk4Font: ""
  property string cursorTheme: ""
  property string cursorSize: ""

  // Displays — the raw array, so the Displays tab can build rows from it
  property var displays: []

  // Disks — the raw array, so the Storage tab can build rows from it
  property var disks: []

  // Favourite tools — sourced from the YAML fallback since fastfetch cannot determine them reliably
  property string shellName: ""
  property string shellVersion: ""
  property string terminalName: ""
  property string terminalVersion: ""
  property string textEditorName: ""
  property string guiEditorName: ""
  property string ideName: ""
  property string browserName: ""

  // --- Logo and path utilities ---
  readonly property string homeDir: Quickshell.env("HOME") || ""
  property string logoOverride: ""

  function expandPath(path)
  {
    if (path === undefined || path === null || path.length === 0) { return "" }
    if (path.indexOf("~/") === 0) { return root.homeDir + path.substring(1) }
    if (path === "~") { return root.homeDir }
    if (path.indexOf("$HOME") === 0) { return root.homeDir + path.substring(5) }
    return path
  }

  readonly property string logoSource:
  {
    if (root.logoOverride.length > 0)
    {
      const expanded = root.expandPath(root.logoOverride)
      return expanded.indexOf("/") === 0 ? "file://" + expanded : Quickshell.iconPath(expanded, "computer")
    }
    if (root.osReleaseLogo.length > 0) { return Quickshell.iconPath(root.osReleaseLogo, "computer") }
    return Quickshell.iconPath(root.logoForId(root.distroId), "computer")
  }

  function logoForId(id)
  {
    switch (id)
    {
      case "debian": return "debian"
      case "ubuntu": return "ubuntu"
      case "arch": return "archlinux"
      case "fedora": return "fedora"
      case "linuxmint": return "linuxmint"
      case "opensuse":
      case "opensuse-tumbleweed":
      case "opensuse-leap": return "opensuse"
      default: return "linux"
    }
  }

  // --- Formatting helpers ---

  // Converting bytes to a human-readable GiB or MiB string
  function bytesToHuman(bytes)
  {
    if (!bytes || bytes <= 0) { return "" }
    const gib = bytes / (1024 * 1024 * 1024)
    if (gib >= 1)
    {
      return Math.round(gib) + " GB"
    }
    return Math.round(bytes / (1024 * 1024)) + " MB"
  }

  // Converting MHz to a GHz string with one decimal place
  function mhzToGhz(mhz)
  {
    if (!mhz || mhz <= 0) { return "" }
    return (mhz / 1000).toFixed(1) + " GHz"
  }

  // Deriving the approximate diagonal size in inches from physical mm dimensions
  function mmToInches(widthMm, heightMm)
  {
    if (!widthMm || !heightMm) { return "" }
    const diag = Math.sqrt(widthMm * widthMm + heightMm * heightMm)
    return (diag / 25.4).toFixed(1) + "\""
  }

  // Stripping the [Qt] / [GTK2/3/4] suffix fastfetch appends to theme and icon names
  function stripTag(value)
  {
    if (!value) { return "" }
    return value.replace(/\s*\[.*?\]\s*$/, "").trim()
  }

  // --- os-release parser ---
  function parseOsRelease(text)
  {
    const map = ({})
    const lines = text.split("\n")
    for (let i = 0; i < lines.length; i++)
    {
      const line = lines[i].trim()
      if (line.length === 0 || line.indexOf("#") === 0) { continue }
      const eq = line.indexOf("=")
      if (eq === -1) { continue }
      const key = line.substring(0, eq)
      let value = line.substring(eq + 1)
      if (value.length >= 2 && (value.charAt(0) === '"' || value.charAt(0) === "'") && value.charAt(value.length - 1) === value.charAt(0))
      {
        value = value.substring(1, value.length - 1)
      }
      map[key] = value
    }
    root.prettyName = map["PRETTY_NAME"] || map["NAME"] || "Linux"
    root.distroName = map["NAME"] || ""
    root.distroVersion = map["VERSION"] || map["VERSION_ID"] || ""
    root.distroVersionId = map["VERSION_ID"] || ""
    root.distroCodename = map["VERSION_CODENAME"] || ""
    root.distroId = map["ID"] || ""
    root.osReleaseLogo = map["LOGO"] || ""
  }

  // --- fastfetch JSON parser ---
  function parseFastfetch(text)
  {
    let arr
    try { arr = JSON.parse(text) }
    catch (e) { return }

    if (!Array.isArray(arr)) { return }

    root.fastfetchAvailable = true

    // Building a type-keyed map so each section is found in one pass
    const map = ({})
    for (let i = 0; i < arr.length; i++)
    {
      const entry = arr[i]
      if (entry && entry.type && !entry.error)
      {
        map[entry.type] = entry.result
      }
    }

    // --- Host (motherboard) ---
    const host = map["Host"]
    if (host)
    {
      root.motherboardVendor = host.vendor || ""
      root.motherboardName = host.name || ""
    }

    // --- CPU ---
    const cpu = map["CPU"]
    if (cpu)
    {
      root.chip = cpu.cpu || ""
      const physical = (cpu.cores && cpu.cores.physical) ? cpu.cores.physical : 0
      const logical = (cpu.cores && cpu.cores.logical) ? cpu.cores.logical : 0
      const maxMhz = (cpu.frequency && cpu.frequency.max) ? cpu.frequency.max : 0
      let parts = [cpu.cpu || ""]
      if (physical > 0 && logical > 0) { parts.push(physical + "c/" + logical + "t") }
      if (maxMhz > 0) { parts.push(root.mhzToGhz(maxMhz)) }
      root.processorSummary = parts.join("  ·  ")
    }

    // --- GPU ---
    const gpu = map["GPU"]
    if (Array.isArray(gpu) && gpu.length > 0)
    {
      const g = gpu[0]
      root.gpuName = g.name || ""
      root.gpuVendor = g.vendor || ""
      root.gpuDriver = g.driver || ""
    }

    // --- Memory ---
    const mem = map["Memory"]
    if (mem)
    {
      root.memorySummary = root.bytesToHuman(mem.total)
    }

    // --- WM / graphics platform ---
    const wm = map["WM"]
    if (wm)
    {
      root.wmName = wm.prettyName || wm.processName || ""
      root.wmVersion = wm.version || ""
      root.graphicsPlatform = wm.protocolName || ""
    }

    // --- Theme ---
    const theme = map["Theme"]
    if (theme)
    {
      root.qtTheme = root.stripTag(theme.theme1)
      root.gtkTheme = root.stripTag(theme.theme2)
    }

    // --- Icons ---
    const icons = map["Icons"]
    if (icons)
    {
      root.qtIcons = root.stripTag(icons.icons1)
      root.gtkIcons = root.stripTag(icons.icons2)
    }

    // --- Fonts: fonts[0]=Qt, fonts[1]=GTK2, fonts[2]=GTK3, fonts[3]=GTK4 ---
    const font = map["Font"]
    if (font && Array.isArray(font.fonts))
    {
      root.qtFont = font.fonts[0] || ""
      root.gtk2Font = font.fonts[1] || ""
      root.gtk4Font = font.fonts[3] || ""
    }

    // --- Cursor ---
    const cursor = map["Cursor"]
    if (cursor)
    {
      root.cursorTheme = cursor.theme || ""
      root.cursorSize = cursor.size || ""
    }

    // --- Displays ---
    const display = map["Display"]
    if (Array.isArray(display)) { root.displays = display }

    // --- Disks ---
    const disk = map["Disk"]
    if (Array.isArray(disk)) { root.disks = disk }

    // --- Locale ---
    const locale = map["Locale"]
    if (typeof locale === "string") { root.locale = locale }

    // --- Shell: only used as a favourite-tools seed; the YAML fallback may override ---
    const shell = map["Shell"]
    if (shell && root.shellName.length === 0)
    {
      root.shellName = shell.prettyName || shell.exeName || ""
      root.shellVersion = shell.version || ""
    }
  }

  // --- Processes ---

  Process {
    command: ["cat", "/etc/os-release"]
    running: true
    stdout: StdioCollector { onStreamFinished: root.parseOsRelease(this.text) }
  }

  Process {
    command: ["uname", "-r"]
    running: true
    stdout: StdioCollector { onStreamFinished: root.kernelRelease = this.text.trim() }
  }

  Process {
    command: ["uname", "-m"]
    running: true
    stdout: StdioCollector { onStreamFinished: root.kernelArch = this.text.trim() }
  }

  // Running fastfetch and parsing the payload once it completes
  Process {
    command: ["fastfetch", "--format", "json"]
    running: true
    stdout: StdioCollector { onStreamFinished: root.parseFastfetch(this.text) }
  }

  // Step 1 — reading the system product serial via pkexec
  Process {
    id: serialProc1
    command: ["pkexec", "/usr/bin/cat", "/sys/devices/virtual/dmi/id/product_serial"]
    running: false
    stdout: StdioCollector {
      onStreamFinished:
      {
        const value = this.text.trim()
        if (root.isUsableSerial(value))
        {
          root.serial = value
          root.serialPending = false
        }
        else
        {
          root.serialStep = 2
          serialProc2.running = true
        }
      }
    }
    onExited: (code, status) =>
    {
      if (root.serialStep === 1 && root.serial.length === 0 && !root.serialPending)
      {
        root.serialPending = false
      }
    }
  }

  // Step 2 — reading the baseboard serial via pkexec
  Process {
    id: serialProc2
    command: ["pkexec", "/usr/bin/cat", "/sys/devices/virtual/dmi/id/board_serial"]
    running: false
    stdout: StdioCollector {
      onStreamFinished:
      {
        const value = this.text.trim()
        if (root.isUsableSerial(value))
        {
          root.serial = value
          root.serialPending = false
        }
        else
        {
          root.serialStep = 3
          serialProc3.running = true
        }
      }
    }
  }

  // Step 3 — reading the system UUID via pkexec
  Process {
    id: serialProc3
    command: ["pkexec", "/usr/bin/cat", "/sys/devices/virtual/dmi/id/product_uuid"]
    running: false
    stdout: StdioCollector {
      onStreamFinished:
      {
        const value = this.text.trim()
        root.serial = root.isUsableSerial(value) ? value : "Não disponível"
        root.serialPending = false
      }
    }
    onExited: (code, status) =>
    {
      if (root.serialPending) { root.serialPending = false }
    }
  }
}
