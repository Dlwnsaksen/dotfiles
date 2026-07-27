if status is-interactive

    # Starship prompt
    starship init fish | source

    # Better ls
    alias ls='eza --icons --group-directories-first -1'

    # Aliases
    abbr lg 'lazygit'

    # Git abbreviations
    abbr gd  'git diff'
    abbr ga  'git add .'
    abbr gc  'git commit -am'
    abbr gl  'git log'
    abbr gs  'git status'
    abbr gst 'git stash'
    abbr gsp 'git stash pop'
    abbr gp  'git push'
    abbr gpl 'git pull'
    abbr gsw 'git switch'
    abbr gsm 'git switch main'
    abbr gb  'git branch'
    abbr gbd 'git branch -d'
    abbr gco 'git checkout'
    abbr gsh 'git show'

    # ls abbreviations
    abbr l   'ls'
    abbr ll  'ls -l'
    abbr la  'ls -a'
    abbr lla 'ls -la'

    # Jump between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end

end
alias telegram="$HOME/Applications/Telegram/Telegram/Telegram"
fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
