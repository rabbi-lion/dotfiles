-- Made by rabbi-lion
-- License: GNU GPLv3

local mp = require "mp"

local key_bindings = {}
local file_to_delete = ""
local confirm_key = "y"

local function file_exists(name)
    if not name or name == "" then
        return false
    end

    local f = io.open(name, "rb")
    if f then
        f:close()
        return true
    end

    return false
end

local function is_protocol(path)
    return type(path) == "string"
        and path:match("^%a[%a%d_+-]*://") ~= nil
end

local function have_cmd(cmd)
    local res = mp.command_native({
        name = "subprocess",
        playback_only = false,
        args = {
            "sh",
            "-c",
            "command -v " .. cmd .. " >/dev/null 2>&1"
        },
    })

    return res and res.status == 0
end

local function run_cmd(argv)
    local res = mp.command_native({
        name = "subprocess",
        playback_only = false,
        args = argv,
    })

    return res and res.status == 0
end

local function show(msg, ms)
    mp.commandv(
        "show-text",
        msg or "",
        tostring(ms or 3000)
    )
end

local function delete_file(path)
    if is_protocol(path) or not file_exists(path) then
        return true
    end

    if have_cmd("kioclient6") then
        if run_cmd({
            "kioclient6",
            "move",
            path,
            "trash:/"
        }) then
            return true
        end

    elseif have_cmd("kioclient5") then
        if run_cmd({
            "kioclient5",
            "move",
            path,
            "trash:/"
        }) then
            return true
        end
    end

    if have_cmd("gio") then
        if run_cmd({
            "gio",
            "trash",
            path
        }) then
            return true
        end
    end

    if have_cmd("trash-put") then
        if run_cmd({
            "trash-put",
            path
        }) then
            return true
        end
    end

    show(
        "No trash tool found (kioclient/gio/trash-put).",
        5000
    )

    return false
end

local function remove_current_file_from_playlist()
    local count = mp.get_property_number(
        "playlist-count",
        0
    )

    local pos = mp.get_property_number(
        "playlist-pos",
        -1
    )

    if count <= 0 or pos < 0 then
        return
    end

    if count == 1 then
        mp.commandv(
            "playlist-remove",
            tostring(pos)
        )

        mp.commandv("stop")
        return
    end

    local new_pos

    if pos >= count - 1 then
        new_pos = pos - 1
    else
        new_pos = pos + 1
    end

    mp.set_property_number(
        "playlist-pos",
        new_pos
    )

    mp.commandv(
        "playlist-remove",
        tostring(pos)
    )
end

local function remove_bindings()
    if #key_bindings == 0 then
        return
    end

    for _, name in ipairs(key_bindings) do
        mp.remove_key_binding(name)
    end

    key_bindings = {}
end

local function cleanup()
    remove_bindings()
    file_to_delete = ""
    show("", 0)
end

local function handle_confirm_key()
    local path = mp.get_property("path")

    if file_to_delete ~= ""
        and file_to_delete == path
    then
        show("", 0)

        if delete_file(file_to_delete) then
            remove_current_file_from_playlist()
        end

        cleanup()
    end
end

local function add_bindings()
    if #key_bindings > 0 then
        return
    end

    local name =
        mp.get_script_name()
        .. "_confirm_delete"

    key_bindings[1] = name

    mp.add_forced_key_binding(
        confirm_key,
        name,
        handle_confirm_key
    )
end

local function client_message(event)
    if not event
        or not event.args
        or #event.args < 1
    then
        return
    end

    local path = mp.get_property("path")

    if event.args[1] == "delete-file"
        and #event.args == 1
    then
        if delete_file(path) then
            remove_current_file_from_playlist()
        end

        return
    end

    if event.args[1] == "delete-file-confirm"
        and #event.args >= 3
        and #key_bindings == 0
    then
        confirm_key = event.args[2]
        file_to_delete = path

        add_bindings()

        mp.add_timeout(
            10,
            cleanup
        )

        show(
            event.args[3],
            10000
        )

        return
    end
end

mp.register_event(
    "client-message",
    client_message
)
