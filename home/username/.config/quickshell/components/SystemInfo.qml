pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  // --- Distribution identity ---
  property string prettyName: "Linux"
  property string distroName: ""
  property string distroVersion: ""
  property string distroVersionId: ""
  property string distroCodename: ""
  property string distroId: ""
  property string osReleaseLogo: ""

  readonly property string versionDisplay:
  {
    if (root.distroCodename.length > 0)
    {
      const capitalised = root.distroCodename.charAt(0).toUpperCase() + root.distroCodename.substring(1)
      return root.distroVersionId.length > 0 ? capitalised + " " + root.distroVersionId : capitalised
    }
    return root.distroVersionId.length > 0 ? root.distroVersionId : root.distroVersion
  }

  // --- Serial: single pkexec invocation reads all three files at once, so one password prompt suffices ---
  property string serial: ""
  property bool serialPending: false

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
    serialProc.running = true
  }

  // --- Kernel ---
  property string kernelRelease: ""
  property string kernelArch: ""

  // Stripping the distro suffix from the kernel release, returning only the upstream version number
  function kernelVersion(release)
  {
    // Keeping only characters up to the first '+', '-', or whitespace
    const m = release.match(/^([0-9]+\.[0-9]+\.[0-9]+)/)
    return m ? m[1] : release
  }

  readonly property string kernelDisplay:
  {
    const v = root.kernelVersion(root.kernelRelease)
    return root.kernelArch.length > 0 ? v + "  (" + root.kernelArch + ")" : v
  }

  // --- fastfetch-parsed hardware properties ---
  property bool fastfetchAvailable: false

  // Overview
  property string chip: ""
  property string motherboardVendorRaw: ""
  property string motherboardName: ""

  // Exposing only the first word of the motherboard vendor, since OEMs pad with «Group», «Technology», etc.
  readonly property string motherboardVendor:
  {
    if (root.motherboardVendorRaw.length === 0) { return "" }
    return root.motherboardVendorRaw.split(" ")[0]
  }

  property string processorSummary: ""
  property string memorySummary: ""
  property string gpuName: ""

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

  // Locale, with the encoding suffix stripped
  property string localeRaw: ""
  readonly property string locale:
  {
    const dot = root.localeRaw.indexOf(".")
    return dot === -1 ? root.localeRaw : root.localeRaw.substring(0, dot)
  }

  // Displays — raw fastfetch array, augmented by a name-override map
  property var displays: []
  property var displayNameMap: ({})

  // Returning the human-friendly monitor name, preferring the custom map over the EDID identifier
  function displayName(edidName)
  {
    return root.displayNameMap[edidName] || edidName
  }

  // Storage — from lsblk (model names) and fastfetch Disk (usage data), merged by device path
  property var lsblkDisks: []
  property var fastfetchDisks: []

  // Building the merged disk list: one entry per physical disk with model name and usage from mounted partitions
  readonly property var mergedDisks:
  {
    const out = []
    for (let i = 0; i < root.lsblkDisks.length; i++)
    {
      const disk = root.lsblkDisks[i]
      if (disk.type !== "disk") { continue }

      // Finding the matching fastfetch partition for usage data — matches any fastfetch disk whose mountFrom starts with /dev/diskName
      let totalBytes = 0
      let usedBytes = 0
      let freeBytes = 0
      let hasUsage = false
      let mountFrom = "/dev/" + disk.name
      let fstype = ""

      for (let j = 0; j < root.fastfetchDisks.length; j++)
      {
        const fd = root.fastfetchDisks[j]
        if (fd.mountFrom && fd.mountFrom.startsWith("/dev/" + disk.name))
        {
          if (fd.bytes)
          {
            usedBytes += fd.bytes.used || 0
            freeBytes += fd.bytes.available || 0
            hasUsage = true
          }
          if (!fstype && fd.filesystem) { fstype = fd.filesystem }
          if (fd.mountFrom) { mountFrom = fd.mountFrom }
        }
      }

      // Using lsblk's raw size as the authoritative capacity — it is correct for all drives whether mounted or not
      const rawBytes = disk.size ? Number(disk.size) : 0

      out.push({
        name: disk.name,
        model: (disk.model || "").trim(),
        size: disk.size || "",
        totalBytes: rawBytes,
        usedBytes: hasUsage ? usedBytes : 0,
        freeBytes: hasUsage ? freeBytes : 0,
        hasUsage: hasUsage,
        fstype: fstype,
        mountFrom: mountFrom
      })
    }
    return out
  }

  // Favourite tools — sourced from the YAML fallback config, with fastfetch shell as a seed
  property string shellName: ""
  property string shellVersion: ""
  property string terminalName: ""
  property string terminalVersion: ""
  property string textEditorName: ""
  property string textEditorVersion: ""
  property string guiEditorName: ""
  property string guiEditorVersion: ""
  property string ideName: ""
  property string ideVersion: ""
  property string browserName: ""
  property string browserVersion: ""

  // --- Logo and path utilities ---
  readonly property string homeDir: Quickshell.env("HOME") || ""
  property string logoOverride: ""
  property string configPath: "~/.config/quickshell/about-config.yaml"

  function expandPath(path)
  {
    if (!path || path.length === 0) { return "" }
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

  function bytesToHuman(bytes)
  {
    if (!bytes || bytes <= 0) { return "" }
    const gib = bytes / (1024 * 1024 * 1024)
    if (gib >= 1) { return Math.round(gib) + " GB" }
    return Math.round(bytes / (1024 * 1024)) + " MB"
  }

  function mhzToGhz(mhz)
  {
    if (!mhz || mhz <= 0) { return "" }
    return (mhz / 1000).toFixed(1) + " GHz"
  }

  function mmToInches(widthMm, heightMm)
  {
    if (!widthMm || !heightMm) { return "" }
    const diag = Math.sqrt(widthMm * widthMm + heightMm * heightMm)
    return (diag / 25.4).toFixed(1) + "\""
  }

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

    const map = ({})
    for (let i = 0; i < arr.length; i++)
    {
      const entry = arr[i]
      if (entry && entry.type && !entry.error) { map[entry.type] = entry.result }
    }

    const host = map["Host"]
    if (host)
    {
      root.motherboardVendorRaw = host.vendor || ""
      root.motherboardName = host.name || ""
    }

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

    const gpu = map["GPU"]
    if (Array.isArray(gpu) && gpu.length > 0) { root.gpuName = gpu[0].name || "" }

    const mem = map["Memory"]
    if (mem) { root.memorySummary = root.bytesToHuman(mem.total) }

    const wm = map["WM"]
    if (wm)
    {
      root.wmName = wm.prettyName || wm.processName || ""
      root.wmVersion = wm.version || ""
      root.graphicsPlatform = wm.protocolName || ""
    }

    const theme = map["Theme"]
    if (theme)
    {
      root.qtTheme = root.stripTag(theme.theme1)
      root.gtkTheme = root.stripTag(theme.theme2)
    }

    const icons = map["Icons"]
    if (icons)
    {
      root.qtIcons = root.stripTag(icons.icons1)
      root.gtkIcons = root.stripTag(icons.icons2)
    }

    const font = map["Font"]
    if (font && Array.isArray(font.fonts))
    {
      root.qtFont = font.fonts[0] || ""
      root.gtk2Font = font.fonts[1] || ""
      root.gtk4Font = font.fonts[3] || ""
    }

    const cursor = map["Cursor"]
    if (cursor)
    {
      root.cursorTheme = cursor.theme || ""
      root.cursorSize = cursor.size || ""
    }

    const display = map["Display"]
    if (Array.isArray(display)) { root.displays = display }

    const disk = map["Disk"]
    if (Array.isArray(disk)) { root.fastfetchDisks = disk }

    const locale = map["Locale"]
    if (typeof locale === "string") { root.localeRaw = locale }

    const shell = map["Shell"]
    if (shell && root.shellName.length === 0)
    {
      root.shellName = shell.prettyName || shell.exeName || ""
      root.shellVersion = shell.version || ""
    }
  }

  // --- lsblk JSON parser — provides disk model names ---
  function parseLsblk(text)
  {
    let parsed
    try { parsed = JSON.parse(text) }
    catch (e) { return }
    if (!parsed || !Array.isArray(parsed.blockdevices)) { return }
    // Keeping only physical disks; the tree already has type=disk at the top level
    root.lsblkDisks = parsed.blockdevices.filter(function(d) { return d.type === "disk" })
  }

  // --- YAML config parser — loads favourite tools and display name overrides ---
  function parseConfig(jsonText)
  {
    let cfg
    try { cfg = JSON.parse(jsonText) }
    catch (e) { return }
    if (!cfg) { return }

    const tools = cfg.tools
    if (tools)
    {
      if (tools.shell)
      {
        root.shellName = tools.shell.name || root.shellName
        root.shellVersion = tools.shell.version || root.shellVersion
      }
      if (tools.terminal)
      {
        root.terminalName = tools.terminal.name || ""
        root.terminalVersion = tools.terminal.version || ""
      }
      if (tools.browser)
      {
        root.browserName = tools.browser.name || ""
        root.browserVersion = tools.browser.version || ""
      }
      if (tools.editor)
      {
        // Handling both the array form (list of single-key objects) and the map form
        if (Array.isArray(tools.editor))
        {
          for (let i = 0; i < tools.editor.length; i++)
          {
            const item = tools.editor[i]
            if (item.cli !== undefined)  { root.textEditorName = item.cli || ""; root.textEditorVersion = item.version || "" }
            if (item.gui !== undefined)  { root.guiEditorName = item.gui || ""; root.guiEditorVersion = item.version || "" }
            if (item.ide !== undefined)  { root.ideName = item.ide || ""; root.ideVersion = item.version || "" }
          }
        }
        else
        {
          root.textEditorName = tools.editor.cli || ""
          root.textEditorVersion = tools.editor.version || ""
          root.guiEditorName = tools.editor.gui || ""
          root.ideName = tools.editor.ide || ""
        }
      }
    }

    const displays = cfg.displays
    if (displays && typeof displays === "object")
    {
      root.displayNameMap = displays
    }

    const logo = cfg.logo
    if (logo && logo.length > 0) { root.logoOverride = logo }
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

  Process {
    command: ["fastfetch", "--format", "json"]
    running: true
    stdout: StdioCollector { onStreamFinished: root.parseFastfetch(this.text) }
  }

  // Listing only physical disks (-d) with model names and raw byte counts (-b)
  Process {
    command: ["lsblk", "--json", "-b", "-d", "-o", "NAME,MODEL,SIZE,TYPE,MOUNTPOINT"]
    running: true
    stdout: StdioCollector { onStreamFinished: root.parseLsblk(this.text) }
  }

  // Loading the YAML config via yq, converting to JSON in one step for native parsing
  Process {
    command: ["sh", "-c", "yq -o=json '.' " + root.expandPath(root.configPath) + " 2>/dev/null || echo '{}'"]
    running: true
    stdout: StdioCollector { onStreamFinished: root.parseConfig(this.text) }
  }

  // --- Single pkexec invocation for serial, reading all three files at once to avoid triple prompts ---
  Process {
    id: serialProc
    // Reading all three DMI serial fields in one shell, separating them with a unique delimiter for safe parsing
    command: [
      "pkexec", "/bin/sh", "-c",
      "cat /sys/devices/virtual/dmi/id/product_serial; echo '---NEXT---'; cat /sys/devices/virtual/dmi/id/board_serial; echo '---NEXT---'; cat /sys/devices/virtual/dmi/id/product_uuid"
    ]
    running: false
    stdout: StdioCollector {
      onStreamFinished:
      {
        const parts = this.text.split("---NEXT---")
        const candidates = parts.map(function(p) { return p.trim() })
        let found = ""
        for (let i = 0; i < candidates.length; i++)
        {
          if (root.isUsableSerial(candidates[i]))
          {
            found = candidates[i]
            break
          }
        }
        root.serial = found.length > 0 ? found : "Não disponível"
        root.serialPending = false
      }
    }
    onExited: (code, status) =>
    {
      // Ensuring the pending flag clears if pkexec was dismissed without producing output
      if (root.serialPending) { root.serialPending = false }
    }
  }
}
