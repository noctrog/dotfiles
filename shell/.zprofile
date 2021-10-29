[ -f ~/.profile ] && source ~/.profile

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    emacs --daemon&
    gnome-shell --wayland
    # startx
    # exec sway --my-next-gpu-wont-be-nvidia
fi
