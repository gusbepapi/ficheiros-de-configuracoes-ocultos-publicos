-- 🇬🇧 Toggling Redshift when viewing videos with MPV
-- 🇵🇹 Alternar Redshift quando visualizar vídeos com MPV
-- 🇪🇸 Alternar Redshift cuando vea videos con MPV

if os.execute("pgrep -x redshift >/dev/null") ~= 0 then
    return
end

-- 🇬🇧 Considering that Redshift is enabled when starting
-- 🇵🇹 Considerando que Redshift está ativado ao iniciar
-- 🇪🇸 Considerando que Redshift está activado al iniciar
rs_enabled = true

function rs_toggle()
    os.execute("pkill -x -USR1 redshift")
end

function rs_disable()
    if rs_enabled then
        rs_toggle()
        rs_enabled = false
        mp.msg.log("info", "Disabling redshift")
    end
end

function rs_enable()
    if not rs_enabled then
        rs_toggle()
        rs_enabled = true
        mp.msg.log("info", "Reenabling redshift")
    end
end

function rs_handler()
    if mp.get_property("video") ~= "no" then
        rs_disable()
    else
        rs_enable()
    end
end

mp.register_event("file-loaded", rs_handler)
mp.register_event("shutdown", rs_enable)
