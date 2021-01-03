function pack -a cmd -d "Vim package installer"
    set og_path (pwd)
    if test -f init.lua
	    cd ~/.config/nvim
    else
	    cd ~/.vim
    end
    switch "$cmd"
        case dry-add
            # Echos adding existing submodule
            for x in (fd . pack/ -t d -d 3)
                if test -d $x/.git
                    cd $x
                    set git_origin (git config --get remote.origin.url)
                    cd - >/dev/null
                    echo git submodule add $git_origin $x
                end
            end
        case add
            # Actually adds existing submodules
            for x in (find . -mindepth 1 -type d)
                if test -d $x/.git
                    cd $x
                    set git_origin (git config --get remote.origin.url)
                    cd - >/dev/null
                    git submodule add $git_origin $x
                end
            end
        case update
            # Updates all submodules
            git submodule foreach git pull
        case install
            # Install a plugin
            set install_url $argv[2]
            if contains -- -s $argv[3]; or contains -- -o $argv[3]
                switch $argv[3]
                    case -o
                        echo "Installing as optional 🌚🌚🌚"
                        cd pack/main/opt/
                        git submodule add https://github.com/$install_url
                        cd -
                    case -s
                        echo "Installing as start 🌝🌝🌝🏼"
                        cd pack/main/start/
                        git submodule add https://github.com/$install_url
                        cd -
                end
            else
                echo "Big brain time 🧠 No flag provided"
                echo "-s - start directory"
                echo "-o - option directory"
            end
        case remove
            # Remove a plugin
            set del_plugin $argv[2]
            set pack_path (fd "$del_plugin" pack/ -t d -d 3)
            if test -z $pack_path
                echo "pack: Plugin not found 🤔"
            else
                echo "pack: Removing \"$del_plugin\" 🗑️"
                git submodule deinit -f -- $pack_path
                rm -rf (fd "$del_plugin" .git/modules/ -t d)
                git rm -f $pack_path
            end
        case list
	    # List all plugins
	    fd . pack/main/start -t d -d 1
	    fd . pack/main/opt -t d -d 1
	case count
	    # Count the number of plugins
	    echo Number of plugins:
	    pack list | wc -l
        case help
	    # Display help
            _pack_help
        case \*
	    # Unknown command
            echo "pack: unknown flag or command \"$cmd\" ⁉️"
            _pack_help
    end
    cd $og_path
end

function _pack_help
    echo "usage: pack install <user/plugin...>  Install plugins"
    echo "       pack remove <plugin...>        remove plugins"
    echo "       pack update                    Update all plugins"
    echo "       pack list                      List all plugins"
    echo "       pack dry-add                   Dry run to add all submodules that have not been added"
    echo "       pack add                       Add all submodules that have not been added"
    echo "examples:"
    echo "       pack install dag/vim-fish -s"
    echo "       pack remove vim-fish"
end
