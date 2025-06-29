if [[ -r /etc/bashrc ]]; then
    source /etc/bashrc
fi

if [[ -r "$XDG_CONFIG_HOME/bash/bashrc" ]]; then
    source "$XDG_CONFIG_HOME/bash/bashrc"
fi
