pragma Singleton

// Importing the Quickshell core module, which provides the Singleton base, the environment accessor, and iconPath
import Quickshell
// Importing the Quickshell IO module, which provides Process and StdioCollector
import Quickshell.Io

// Gathering system information from several sources, exposing parsed properties to any view that imports it
Singleton {
  id: root

  // --- Distribution identity, from the freedesktop os-release standard, which every distribution provides ---
  property string prettyName: "Linux"
  property string distroName: ""
  property string distroVersion: ""
  property string distroVersionId: ""
  property string distroCodename: ""
  property string distroId: ""
  property string osReleaseLogo: ""

  // Composing the version line as the capitalised codename followed by the numeric version, degrading where a codename is absent
  readonly property string versionDisplay:
  {
    if (root.distroCodename.length > 0)
    {
      const capitalised = root.distroCodename.charAt(0).toUpperCase() + root.distroCodename.substring(1)
      return root.distroVersionId.length > 0 ? capitalised + " " + root.distroVersionId : capitalised
    }

    return root.distroVersionId.length > 0 ? root.distroVersionId : root.distroVersion
  }

  // --- The machine serial number, read only on demand through a privileged prompt, since the DMI serial is root-only ---
  property string serial: ""
  property bool serialPending: false

  // Requesting the serial through pkexec, which raises the polkit agent's password dialog
  function revealSerial()
  {
    root.serialPending = true
    serialProc.running = true
  }

  // --- Kernel, from uname ---
  property string kernelRelease: ""
  property string kernelArch: ""

  // --- The raw fastfetch payload, captured for inspection before its fields are parsed ---
  property string rawFastfetch: ""
  property bool fastfetchAvailable: false

  // --- The home directory, read once, so user-supplied paths may use ~ or $HOME without hard-coding the real home ---
  readonly property string homeDir: Quickshell.env("HOME") || ""

  // Allowing a custom logo, set by path or icon name from the fallback config, taking precedence over theme resolution
  property string logoOverride: ""

  // Expanding a leading ~ or $HOME in a user-supplied path to the real home directory, so paths stay portable and private
  function expandPath(path)
  {
    if (path === undefined || path === null || path.length === 0)
    {
      return ""
    }

    if (path.indexOf("~/") === 0)
    {
      return root.homeDir + path.substring(1)
    }

    if (path === "~")
    {
      return root.homeDir
    }

    if (path.indexOf("$HOME") === 0)
    {
      return root.homeDir + path.substring(5)
    }

    return path
  }

  // Resolving the logo to a usable source: preferring the override, then the os-release LOGO key, then a per-distribution guess, then a generic icon
  readonly property string logoSource:
  {
    // Preferring an explicit override, expanded and treated as a file path when absolute, otherwise as an icon-theme name
    if (root.logoOverride.length > 0)
    {
      const expanded = root.expandPath(root.logoOverride)
      return expanded.indexOf("/") === 0 ? "file://" + expanded : Quickshell.iconPath(expanded, "computer")
    }

    // Honouring the os-release LOGO key where the distribution provides one
    if (root.osReleaseLogo.length > 0)
    {
      return Quickshell.iconPath(root.osReleaseLogo, "computer")
    }

    // Guessing from the distribution id, since some distributions, Debian among them, omit the LOGO key
    return Quickshell.iconPath(root.logoForId(root.distroId), "computer")
  }

  // Mapping a distribution id to a likely icon-theme name
  function logoForId(id)
  {
    switch (id)
    {
      case "debian":
        return "debian"
      case "ubuntu":
        return "ubuntu"
      case "arch":
        return "archlinux"
      case "fedora":
        return "fedora"
      case "linuxmint":
        return "linuxmint"
      case "opensuse":
      case "opensuse-tumbleweed":
      case "opensuse-leap":
        return "opensuse"
      default:
        return "linux"
    }
  }

  // Parsing the os-release KEY=value lines, stripping a single pair of surrounding quotes, into the identity properties
  function parseOsRelease(text)
  {
    const map = ({})
    const lines = text.split("\n")

    for (let i = 0; i < lines.length; i++)
    {
      const line = lines[i].trim()

      if (line.length === 0 || line.indexOf("#") === 0)
      {
        continue
      }

      const eq = line.indexOf("=")

      if (eq === -1)
      {
        continue
      }

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

  // Reading os-release through cat, collecting the whole file as one string
  Process {
    command: ["cat", "/etc/os-release"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.parseOsRelease(this.text)
    }
  }

  // Reading the kernel release and architecture from uname
  Process {
    command: ["uname", "-r"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.kernelRelease = this.text.trim()
    }
  }

  Process {
    command: ["uname", "-m"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.kernelArch = this.text.trim()
    }
  }

  // Capturing the fastfetch JSON payload whole, for inspection before its fields are parsed into properties
  Process {
    command: ["fastfetch", "--format", "json"]
    running: true
    stdout: StdioCollector {
      onStreamFinished:
      {
        root.rawFastfetch = this.text
        root.fastfetchAvailable = this.text.trim().length > 0
      }
    }
  }

  // Reading the DMI serial through pkexec on demand, which prompts the polkit agent; cat is given by full path since pkexec restricts its search
  Process {
    id: serialProc
    command: ["pkexec", "/usr/bin/cat", "/sys/class/dmi/id/product_serial"]
    running: false
    stdout: StdioCollector {
      onStreamFinished: root.serial = this.text.trim()
    }
    onExited: (code, status) =>
    {
      // Clearing the pending flag whether the prompt succeeded or was dismissed, so the window may resume dismissing on focus loss
      root.serialPending = false
    }
  }
}
