
# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# pushd
alias di='dirs -v'
alias pu='pushd'
# set completions for pu to directory names only
complete -d pu
alias po='popd'
