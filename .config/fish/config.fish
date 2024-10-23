if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""
set -gx TERM tmux-256color

# theme
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias g git
command -qv nvim && alias vim nvim
if type -q eza
    alias ll "eza -l -g --icons"
    alias lla "ll -a"
end

bind \cx reload_fish


###  Fzf
fzf_configure_bindings --directory=\cf

set -gx EDITOR nvim
set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
bind \cn fzf_change_directory

# pyenv
pyenv init - | source

