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
