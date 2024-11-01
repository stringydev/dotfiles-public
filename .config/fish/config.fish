# Basic settings
set fish_greeting ""  # Disable the default fish greeting

# Theme configuration
fish_config theme choose "TokyoNight Night"
set -g fish_prompt_pwd_dir_length 1  # Set the length of the current directory in prompt
set -g theme_display_user yes  # Display the user in the prompt
set -g theme_hide_hostname no  # Always show hostname in the prompt
set -g theme_hostname always  # Show hostname in prompt

# Aliases
alias g git  # Shorten git command
command -qv nvim && alias vim nvim  # Use nvim as vim if available

if type -q eza
    alias ll "eza -l -g --icons"  # Use eza for detailed listing
    alias lla "ll -a"  # Show all files with eza
end

starship init fish | source

# Set the default editor
set -gx EDITOR nvim  # Use nvim as the default editor

# Keybindings
bind \cx reload_fish  # Reload the fish configuration with Ctrl + x

# Fzf configuration
set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"  # Open selected file in editor

# Pyenv configuration
set -Ux PYENV_ROOT "$HOME/Developer/.pyenv"  # Set Pyenv root path
pyenv init - | source  # Initialize Pyenv

# Poetry configuration
if status is-login
    contains ~/.local/bin $PATH
    or set PATH ~/.local/bin $PATH
end

set -Ux POETRY_CONFIG_DIR $HOME/.config/pypoetry/  # Set the Poetry config file path

# tmux sessionizer
set PATH "$PATH":"$HOME/.scripts/"
bind \cf "tmux-sessionizer"
#!/usr/bin/env fish
# set session_name (tmux list-session |sed 's/:.*//g'| fzf)
# tmux switch-client -t "$session_name"
