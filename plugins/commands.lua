do
    local function run(msg, matches)
        text = '# '..lang_text(msg.to.id, 'helpT')..':\n'
        local space = '\n'
        if matches[1] == 'help' and not matches[2] then
            if permissions(msg.from.id, msg.to.id, "mod_commands") then
                local langHash = 'langset:'..msg.to.id
                local lang = redis:get(langHash)
                for v,plugin in pairs(_config.enabled_plugins) do
                    local textHash = 'lang:'..lang..':'..plugin..':0'
                    if redis:get(textHash) then
                        for i=1, tonumber(lang_text(msg.to.id, plugin..':0')), 1 do
                            text = text..lang_text(msg.to.id, plugin..':'..i)..'\n'
                        end
                        text = text..space
                    end
                end
            elseif matches[1] == 'help' and matches[2] then
            if permissions(msg.from.id, msg.to.id, "mod_commands") then
                local langHash = 'langset:'..msg.to.id
                local lang = redis:get(langHash)
                for v,plugin in pairs(_config.enabled_plugins) do
                    if plugin == matches[2] then
                        local textHash = 'lang:'..lang..':'..plugin..':0'
                        if redis:get(textHash) then
                            for i=1, tonumber(lang_text(msg.to.id, plugin..':0')), 1 do
                                text = text..lang_text(msg.to.id, plugin..':'..i)..'\n'
                            end
                        end
                        return text
                    end
                end
                return '# '..lang_text(msg.to.id, 'error...')
            else
             return '#'..lang_text(msg.to.id, 'you are not sudo/admin/mod')
            end
        end
        return text
    end

    return {
        patterns = {
            "^#(help)$",
            "^#(help) (.+)"
        }, 
        run = run 
    }
end

for v,user in pairs(_gbans.gbans_users) do
    if tonumber(user) == tonumber(user_id) then
        return true
    end
  end
