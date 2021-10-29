export PATH="${PATH}:$HOME/.local/bin"

XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME

export MOZ_ENABLE_WAYLAND=1
export MOZ_DISABLE_RDD_SANDBOX=1

export GTK_THEME=Materia:dark

# MATLAB needs the following env variable in order to show its window properly
export _JAVA_AWT_WM_NONREPARENTING=1
