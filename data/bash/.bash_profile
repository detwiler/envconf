# source the user profile
if [[ -r "$HOME/.profile" ]]; then
    source "$HOME/.profile"
fi

# source the user bashrc in interactive shells
case "$-" in
    *i*)
        if [[ -r "$HOME/.bashrc" ]]; then
            source "$HOME/.bashrc"
        fi
esac
