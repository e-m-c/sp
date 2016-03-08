local function run(msg, matches)
    if permissions(msg.from.id, msg.to.id, "export_gban") then
        if matches[1] == 'gbans' then
            local receiver = get_receiver(msg)
            if matches[2] == 'installer' then
                local text = 'local function run(msg)\nif permissions(msg.from.id, msg.to.id, "gban_installer") then\n'
                local count = 0
                for v,user in pairs(_gbans.gbans_users) do
                    text = text..'gban_id('..user..')\n'
                    count = count + 1
                end

local text = text..[[
    if msg.to.type == 'chat' then
        send_msg('chat#id'..msg.to.id, ']]..count..' '..lang_text(msg.to.id, 'accountsGban')..[[ ☠', ok_cb, false)
    elseif msg.to.type == 'channel' then
        send_msg('channel#id'..msg.to.id, ']]..count..' '..lang_text(msg.to.id, 'accountsGban')..[[ ☠', ok_cb, false)
    end
    else
        return '#'..lang_text(msg.to.id, 'you are not sudo/admin/mod')
    end
end

    return {
        description = 'Add gbans into your bot. A gbanlist command.',
        usage = {},
        patterns = {
            "^#(install) (gbans)$"
        },
        run = run
    }
]]

                local file = io.open("./plugins/gban_installer.lua", "w")
                file:write(text)
                file:close()

                send_document(receiver, './plugins/gban_installer.lua', ok_cb, false)
            elseif matches[2] == 'list' then
                send_document(receiver, './data/gbans.lua', ok_cb, false)
            end
        end
    else
         return '#'..lang_text(msg.to.id, 'you are not sudo/admin/mod')
    end
end

return {
  patterns = {
    "^#(gbans) (.*)$"
  },
  run = run
}
