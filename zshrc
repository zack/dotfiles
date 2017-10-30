### PATH MODIFICATION
export PATH="$PATH:/usr/local/bin/"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$MAVEN_HOME/bin"

### Use RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

### ALWAYS IN TMUX
if [ "$TMUX" = "" ]; then tmux -2; fi

### MISC EXPORTS
export ZSH=$HOME/.oh-my-zsh # using oh-my-zsh
export KEYTIMEOUT=1 # disable wait when switching modes
export EDITOR=vim
export LESS='-iRS#3NM~g'

### OH-MY-ZSH
ZSH_THEME="robbyrussel-zack"
plugins=(git)
source $ZSH/oh-my-zsh.sh # use oh-my-zsh

# USE VI MODE
set -o vi

### BINDKEYS
bindkey '^R' history-incremental-search-backward

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### GENERAL CONFIGURATION
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE=true

### ALIASES
# general aliases
alias ack='echo "no more ack"'
alias ag='ag -p ~/.agignore'
alias cm='cmatrix'
alias ff='vim $(fzf-tmux)'
alias gs='git status'
alias killswp='rm **/.*.swp; rm **/.*.swo'
alias ld='ls -d */'
alias tmux='tmux -2'
alias installdeb='sudo dpkg -i'
alias vvim='vim -u NONE' # vanilla vim

# git aliases
alias gs='git st'
alias vgit='vim -p `git status --porcelain | cut -c5-`' # Open dirty files

# rails aliases
alias rc='rails c'
alias rs='rails s 2>&1 | grep -v content-length'
alias tc='bundle exec rake tmp:clear'

# work aliases
alias alleyoop='ssh zack@alleyooplabs.com'
alias bombsync='rsync -ahvz --delete --exclude-from=/home/zack/bombsync_exclusions.txt\
  --progress -e ssh ~/dev/bombfell/ zack@alleyooplabs.com:~/dev/bombfell/'
alias bombsync2='rsync -ahvz --delete --exclude-from=/home/zack/bombsync_exclusions.txt\
  --progress -e ssh ~/dev/bombfell2/ zack@alleyooplabs.com:~/dev/bombfell/'

### FUNCTIONS
# colorize man pages
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\x1b[38;2;255;200;200m") \
    LESS_TERMCAP_md=$(printf "\x1b[38;2;255;100;200m") \
    LESS_TERMCAP_me=$(printf "\x1b[0m") \
    LESS_TERMCAP_so=$(printf "\x1b[38;2;60;90;90;48;2;40;40;40m") \
    LESS_TERMCAP_se=$(printf "\x1b[0m") \
    LESS_TERMCAP_us=$(printf "\x1b[38;2;150;100;200m") \
    LESS_TERMCAP_ue=$(printf "\x1b[0m") \
    man "$@"
}

# speeds up git autocomplete
zstyle ':completion::complete:git-checkout:argument-rest:remote-branch-refs-noprefix' command "echo"

# For travis-ci plugin
[ -f /Users/zack/.travis/travis.sh ] && source /Users/zack/.travis/travis.sh

# Use rg (https://github.com/BurntSushi/ripgrep) instead of the default find
# command for listing path candidates.
# - The first argument to the function is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
# - rg only lists files, so we use with-dir script to augment the output
_fzf_compgen_path() {
  rg --files "$1" | with-dir "$1"
}

# Use rg to generate the list for directory completion
_fzf_compgen_dir() {
  rg --files "$1" | only-dir "$1"
}

fgb() {
  local branches branch
  branches=$(git branch -vv) &&
    branch=$(echo "$branches" | fzf-tmux +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
