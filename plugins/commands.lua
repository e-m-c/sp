do

function run(msg, matches)
    local text = "#mute [username/reply]\n\n#unmute [username/reply]\n\n#kick [username/reply]\n\n#kickme\n\n#ban [username/reply]\n\n#set mod [username\reply]\n\n#set member [username/reply]\n\n#set admin [username/reply]\n\n#muteall\n\n#unmuteall\n\n"
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
