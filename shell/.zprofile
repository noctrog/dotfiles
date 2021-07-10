export PATH="${PATH}:/home/ramon/.local/bin"

export MOZ_ENABLE_WAYLAND=1

[ -f ~/.profile ] && source ~/.profile

XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME

export GTK_THEME=Materia:dark

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    dunst&
    emacs --daemon&
    exec sway --my-next-gpu-wont-be-nvidia
fi
