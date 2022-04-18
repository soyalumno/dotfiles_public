export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
# nodeのモジュール用にPathを通す
export PATH=$PATH:`npm bin -g`
export PATH="$PATH:$HOME/.nodenv/bin"
eval "$(pyenv init -)"
eval "$(nodenv init -)"
alias ll='ls -laFG'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# docker
alias d='docker'
alias dc='docker-compose'
alias dcur='docker ls -f status=running -l -q'
alias dexec='docker exec -it $(dcur)'
alias dbuild='docker build'
alias dimg='docker images'
alias drun='docker run --rm -d'
alias drunit='docker run --rm -it'
alias dstop='docker stop $(dcur)'

alias dps='docker ps --all'

# git
alias g='git'
alias gg='git la'
alias gsee='gh browse'

# lazygit
alias lg='lazygit'

# history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

# ctags
alias ctags="`brew --prefix`/bin/ctags"

# brew じゃない
fpath=(~/.zsh/completion $fpath)

# 補完機能有効にする
autoload -U compinit
compinit -u

# 補完候補に色つける
autoload -U colors
colors
zstyle ':completion:*' list-colors "${LS_COLORS}"

# 単語の入力途中でもTab補完を有効化
setopt complete_in_word
# 補完候補をハイライト
zstyle ':completion:*:default' menu select=1
# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true
# 大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完リストの表示間隔を狭くする
setopt list_packed

# コマンドの打ち間違いを指摘してくれる
setopt correct
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [Yes/No/Abort/Edit] => "

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# starship
eval "$(starship init zsh)"

