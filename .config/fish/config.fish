set fish_greeting ""  

# Aliases
alias g git  
command -qv nvim && alias vim nvim  

# Replace ll withg eza
if type -q eza
    alias ll "eza -l -g --icons"  
    alias lla "ll -a"  
end

# Default editor
set -gx EDITOR nvim  

# Keybindings
bind \cx reload_fish

# Starship
starship init fish | source

# Fzf
set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"  

# Pyenv 
set -Ux PYENV_ROOT "$HOME/Developer/.pyenv"  
pyenv init - | source  

# Poetry 
if status is-login
    contains ~/.local/bin $PATH
    or set PATH ~/.local/bin $PATH
end

set -Ux POETRY_CONFIG_DIR $HOME/.config/pypoetry/  

# Tmux sessionizer
set PATH "$PATH":"$HOME/.scripts/"
bind \cf "tmux-sessionizer"
