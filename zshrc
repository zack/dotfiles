### PATH MODIFICATION
export PATH="$PATH:$HOME/bins"
export PATH="$PATH:/usr/local/bin/"
export PATH="$PATH:$HOME/etsy_bins"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:/opt/homebrew/lib/"
# Created by `pipx` on 2022-01-21 21:29:10
export PATH="$PATH:/Users/zack.youngren/.local/bin"

# Added by n-install (see http://git.io/n-install-repo).
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

### ALWAYS IN TMUX
if [ "$TMUX" = "" ]; then tmux -2; fi

### MISC EXPORTS
export KEYTIMEOUT=1 # disable wait when switching modes
export EDITOR=nvim
export LESS='-iRS#3NM~g'
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export BAT_CONFIG_PATH=$HOME/.batrc

### HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt INC_APPEND_HISTORY_TIME
setopt HIST_FIND_NO_DUPS

### SOURCE SECRETS
if [ -s ~/.secrets/secrets.config ];
then
  source ~/.secrets/secrets.config;
fi

### PROMPT
if [ "$TMUX" != "" ]; then ARROW="→" else ARROW="⇝" fi
STATUS="%(?.%F{green}.%F{red})${ARROW}%f"
if [[ -n "$SSH_CLIENT" ]]; then UN="%B%F{yellow}%n%b%f " else UN="" fi
LOC="%1~"
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]='%F{red}±%f'
  fi
}
zstyle ':vcs_info:*' unstagedstr "%B%F{yellow}±%f%b"
zstyle ':vcs_info:*' stagedstr "%F{green}±%f"
zstyle ':vcs_info:*' formats "(%B%F{magenta}%b%f%%b)%m%u%c"
setopt prompt_subst
PROMPT='👾 ${UN}${STATUS} ${LOC}${vcs_info_msg_0_} $ '

### ZSH SYNTAX HIGHLIGHTING
source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### USE VI MODE
set -o vi

### BINDKEYS
bindkey '^R' history-incremental-search-backward

# fzf
export FZF_DEFAULT_COMMAND='rg --files'

### GENERAL CONFIGURATION
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE=true

### ALIASES
# general aliases
alias ~="cd ~"
alias ag='ag -p ~/.agignore'
alias cat='bat'
alias cm='cmatrix'
alias cr='cargo run'
alias ff='nvim $(fzf-tmux -m)'
alias installdeb='sudo dpkg -i'
alias killswp='rm **/.*.swp; rm **/.*.swo'
alias l1='ls -1'
alias ld='ls -d */'
alias ll='ls -la'
# color for ls
alias ls='ls -G'
alias wtr='curl http://wttr.in/11217'
# alias pipes='pipes.sh -f35 -r0'
alias rg='rg -S --type-add "jsx:*.jsx"'
alias vim='nvim'
alias nvim='nvim'
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

# A kind of lazy loading for nvm,npm,etc.
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  nvm_cmds=(nvm node npm yarn npx)
  for cmd in $nvm_cmds ; do
    alias $cmd="unalias $nvm_cmds && unset nvm_cmds && . $NVM_DIR/nvm.sh &&  . $NVM_DIR/bash_completion && $cmd"
  done
fi

# Start the day off right
fortune | cowsay | lolcat -F 0.5

[ -f "$HOME/dotfiles/stellar_dotfiles/zshrc" ] && source "$HOME/dotfiles/stellar_dotfiles/zshrc"

export PATH="/usr/local/sbin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
