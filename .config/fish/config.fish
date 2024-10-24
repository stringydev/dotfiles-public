# Check if the shell is interactive
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Basic settings
set fish_greeting ""  # Disable the default fish greeting
set -gx TERM xterm-256color  # Set terminal type for color support

# Theme configuration
# Choose a theme for the shell prompt
fish_config theme choose "Rosé Pine"
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

# Set the default editor
set -gx EDITOR nvim  # Use nvim as the default editor

# Keybindings
bind \cx reload_fish  # Reload the fish configuration with Ctrl + x

# Fzf configuration
fzf_configure_bindings --directory=\cf  # Set fzf to change directories with Ctrl + f
set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"  # Open selected file in editor
bind \cn fzf_change_directory  # Change directory using fzf with Ctrl + n

# Pyenv configuration
set -Ux PYENV_ROOT "$HOME/Developer/.pyenv"  # Set Pyenv root path
pyenv init - | source  # Initialize Pyenv

# Poetry configuration
set -Ux POETRY_CONFIG_DIR $HOME/.config/pypoetry/  # Set the Poetry config file path
