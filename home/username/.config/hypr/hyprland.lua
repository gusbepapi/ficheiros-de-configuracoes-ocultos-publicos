hl.on("hyprland.start", function () 
  -- Importing the session variables and starting the systemd user session, so the units in ~/.config/systemd/user run
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
  hl.exec_cmd("systemctl --user start hyprland-session.target")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("xhost +si:localuser:root")
  hl.exec_cmd("/usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1")
end)

------------------
---- MONITORS ----
------------------

-- Defining our two monitor configurations
hl.monitor({
	output = "DP-3",
	mode = "1920x1080@60",
	position = "0x0",
	scale = "1",
})

-- hl.monitor({
-- 	output = "HDMI-A-1",
-- 	mode = "1920x1080@60",
-- 	position = "0x0",
-- 	scale = "1",
-- })

-- hl.monitor({
-- 	output = "HDMI-A-1",
-- 	mode = "2560x1440@60",
-- 	position = "0x0",
-- 	scale = "1",
-- })

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "kitty"
local fileManager = "dolphin"
local browser = "firefox"
local menu = "hyprlauncher"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("XDG_MENU_PREFIX", "plasma-")
-- hl.env("XDG_CURRENT_DESKTOP", "KDE")
-- hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("AQ_NO_MODIFIERS", "1")
hl.env("GDK_SCALE", "2")
-- hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
-- hl.env("LIBVA_DRIVER_NAME", "radeonsi")
hl.env("XCURSOR_SIZE", "32")
-- hl.env("VDPAU_DRIVER", "radeonsi")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Referencing official configuration variables
-- https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({

  debug = {
    disable_logs = false,
    gl_debugging = true,
    -- Forcing full redraw every frame to bypass partial damage logic
    damage_tracking = 0,
    -- Tinting each reported damage region so misreports become visible
    damage_blink = false,
  },
	
  general = {
    gaps_in  = 5,
    gaps_out = 20,

    border_size = 2,

    col = {
      active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },

    -- Enabling window resizing by clicking and dragging on borders and gaps
    resize_on_border = true,

    -- Disabling tearing
    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing = false,

    layout = "dwindle",
  },

  decoration = {
    rounding = 0,
    blur = {
      enabled = false,
    },
  },

  animations = {
    enabled = true,
  },

  misc = {
    background_color = "#486e21",
    force_default_wallpaper = 0,
  },
  
  cursor = {
    no_hardware_cursors = true,
  },
  
  opengl = {
    nvidia_anti_flicker = 0,
  },

  xwayland = {
    enabled = true,
    force_zero_scaling = true,
  },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Defining default spring parameters
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Configuring layout options
-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    preserve_split = true,
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

----------------
----  MISC  ----
----------------

hl.config({
  misc = {
    force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
  },
})

---------------
---- INPUT ----
---------------

hl.config({
  input = {
    -- kb_layout  = "us",
    -- kb_variant = "mac", 
    kb_file = os.getenv("HOME") .. "/.config/xkb/abcext.xkb",
    kb_layout  = "abcext",
    kb_variant = "",
    kb_model   = "apple",
    kb_options = "compose:rctrl",
    kb_rules   = "",

    follow_mouse = 1,

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
      natural_scroll = false,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Binding application shortcuts
hl.bind("CTRL + SHIFT + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E",  hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B",  hl.dsp.exec_cmd(browser))

-- Switching to the launcher submap
hl.bind("ALT + SPACE", hl.dsp.submap("launcher"))

-- Defining the launcher submap
hl.define_submap("launcher", "reset", function()

  -- Launching Hyprlauncher
  hl.bind("H", hl.dsp.exec_cmd("hyprlauncher"))

  -- Launching Anyrun
  hl.bind("SPACE", hl.dsp.exec_cmd("$HOME/.cargo/bin/anyrun"))

  -- Returning to the default submap
  hl.bind("ESCAPE", hl.dsp.submap("reset"))

end)

-- Binding window management controls
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))

-- Binding directional window movement
hl.bind(mainMod .. " + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.window.move({ direction = "down" }))

-- Binding layout manipulation controls
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.layout("swapsplit"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.layout("rotatesplit"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.layout("movetoroot"))

-- Toggling floating state and centering window
hl.bind(mainMod .. " + C", hl.dsp.window.float({ action = "toggle" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Binding special scratchpad workspace
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scrolling through workspaces using mouse wheel with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Binding mouse dragging and resizing
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Executing screenshot utilities without slurp borders
hl.bind("Print",         hl.dsp.exec_cmd("env SLURP_ARGS='-w 0 -b 00000088' grimblast copy area"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("env SLURP_ARGS='-w 0 -b 00000088' grimblast save area"))
hl.bind("CTRL + Print",  hl.dsp.exec_cmd("grimblast copy screen"))

-- Triggering colour picker
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprpicker -a"))

-- Toggling idle management daemon
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("pgrep -x hypridle >/dev/null && { pkill -x hypridle; notify-send 'Caffeine mode' 'Idle management disabled'; } || { hypridle & disown; notify-send 'Caffeine mode' 'Idle management enabled'; }"))

-- Defining window rules
hl.window_rule({
  name  = "noblur",
  match = {
    class = "^(microsoft-edge-dev)$",
  },
})