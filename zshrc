### PATH MODIFICATION
export PATH="$PATH:~/bins"
export PATH="$PATH:/usr/local/bin/"
export PATH="$PATH:$HOME/etsy_bins"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$MAVEN_HOME/bin"

### ALWAYS IN TMUX
# if [ "$TMUX" = "" ]; then tmux -2; fi

### MISC EXPORTS
export ZSH=$HOME/.oh-my-zsh # using oh-my-zsh
export KEYTIMEOUT=1 # disable wait when switching modes
export EDITOR=nvim
#export LESS='-iRS#3NM~g'
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export BAT_CONFIG_PATH=$HOME/.batrc

### SOURCE SECRETS
if [ -s ~/.secrets/secrets.config ];
then
  source ~/.secrets/secrets.config;
fi

### OH-MY-ZSH
ZSH_THEME="robbyrussel-zack"
plugins=(git)
source $ZSH/oh-my-zsh.sh # use oh-my-zsh

# ZSH SYNTAX HIGHLIGHTING
source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# USE VI MODE
set -o vi

### BINDKEYS
bindkey '^R' history-incremental-search-backward

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files'

### GENERAL CONFIGURATION
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE=true

### ALIASES
# general aliases
alias ag='ag -p ~/.agignore'
alias cat='bat'
alias cm='cmatrix'
alias cr='cargo run'
alias ff='nvim $(fzf-tmux -m)'
alias installdeb='sudo dpkg -i'
alias killswp='rm **/.*.swp; rm **/.*.swo'
alias l1='ls -1'
alias ld='ls -d */'
alias wtr='curl http://wttr.in/11217'
# alias pipes='pipes.sh -f35 -r0'
alias rg='rg -S --type-add "jsx:*.jsx"'
alias view='vim -R'
alias vview='vim -R -u NONE'
alias vvim='vim -u NONE' # vanilla vim
alias when='TZ=America/New_York date -d @\'
alias z='zeus'

# git aliases
alias gs='git st'
alias vgit='vim -p `git status --porcelain | cut -c4-`' # Open dirty files
# alias gb='git --no-pager branch'
# alias gist='gist -c -p'

# rails aliases
alias rc='rails c'
alias rs='rails s 2>&1 | grep -v content-length'
alias tc='bundle exec rake tmp:clear'

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

# $ git gb 213 to go to a branch
function gb {
  if [[ -z "$1" ]]; then
    git branch -v
  else
    git branch | grep -v "^*" | fzf -f "$1" | head -n1 | xargs git checkout
  fi
}
alias gb=gb

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Start the day off right
fortune | cowsay | lolcat -F 0.5

# Pull in work dotfiles
for file in ~/dotfiles/work_dotfiles/zshrc_*; do
  source "$file"
done

export PATH="/usr/local/sbin:$PATH"
