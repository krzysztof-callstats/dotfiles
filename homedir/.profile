# Aliases
alias vi='nvim'
alias vim='nvim'

# cd extensions
source ~/.dotfiles/lib_sh/cd_extensions.sh

# Hook direnv
eval "$(direnv hook bash)"

# go
export GOROOT=/usr/local/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# git + fzf
alias faddm="git add $(git ls-files -m | fzf -m)"
alias faddu="git add $(git ls-files --exclude-standard --others | fzf -m)"
alias fadd="git add $(git ls-files | fzf -m)"
