# First terminal opened with nothing else running: resume wherever we left
# off. Additional windows opened while others are already up: each gets its
# own independent session, so they don't mirror each other -- tmux.conf
# prunes these back down once closed.
#
# Shadows the real tmux binary, since ctrl+d in the last pane kills the
# session outright (not a detach, so tmux.conf's prune hook never fires)
# and drops back to a plain shell. Without this, typing tmux by hand
# afterward would skip straight to tmux's own numbered session instead of
# reattaching or making a fresh term-$$ one.
tmux() {
  if [ $# -gt 0 ]; then
    command tmux "$@"
    return
  fi

  if [ -z "$(command tmux list-clients 2>/dev/null)" ]; then
    local last
    last=$(command tmux list-sessions -F '#{session_last_attached} #{session_name}' 2>/dev/null | sort -rn | head -n1 | cut -d' ' -f2-)
    if [ -n "$last" ]; then
      command tmux attach-session -t "$last"
    else
      command tmux new-session -s "term-$$"
    fi
  else
    command tmux new-session -s "term-$$"
  fi
}

if [ "$TMUX" = "" ]; then
  tmux
fi
typeset -U PATH path FPATH fpath # deduplicate path values after launching tmux

### PATH MODIFICATION
export FPATH="$HOME/.eza/completions/zsh:$FPATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/snap/bin"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

### MISC EXPORTS
export KEYTIMEOUT=1 # disable wait when switching modes
export EDITOR=nvim
export LESS='-iRS#3NM~g'
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export BAT_THEME='Dracula'
export GROFF_NO_SGR=1 # for fixing colorized man pages

### HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt INC_APPEND_HISTORY_TIME
setopt HIST_FIND_NO_DUPS

### PROMPT
if [ "$TMUX" != "" ]; then ARROW="➜ " else ARROW="⇝ " fi
STATUS="%(?.%F{green}.%F{red})${ARROW}%f"
if [[ -n "$SSH_CLIENT" ]]; then UN="%B%F{yellow}%n%b%f " else UN="" fi
LOC="%1~"
autoload -Uz add-zsh-hook; add-zsh-hook precmd vcs_info
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
PROMPT='${UN}${STATUS} ${LOC}${vcs_info_msg_0_} $ '
if [[ -n "$SSH_CLIENT" ]]; then
  PROMPT="👾 ${PROMPT}"
fi

### USE VI MODE
set -o vi

# fzf
## ZSH fzf-tab completion
autoload -U compinit; compinit
source ~/.zsh-plugins/fzf-tab/fzf-tab.plugin.zsh
## completion and key bindings (ctrl-r, etc.); needs to come after
## fzf-tab.plugin.zsh, looks backwards but that's the order fzf-tab wants
command -v fzf > /dev/null 2>&1 && source <(fzf --zsh)
## defaults
export FZF_DEFAULT_COMMAND='rg --files'

### ALIASES
# general aliases
alias ~="cd ~"
alias cat='bat'
alias cd='z'
alias ff='() { [[ -n "$1" ]] && nvim "$@" } "${(@f)$(fzf -m)}"' # kill nvim if <esc>d
alias installdeb='sudo dpkg -i'
alias killswp='rm **/.*.swp; rm **/.*.swo'
alias la='ls -la'
alias ls='eza'
alias l1='ls -1'
alias ld='ls -d */'
alias ll='ls -la'
alias wtr='curl http://wttr.in/11217'
alias rg='rg -S --type-add "jsx:*.jsx"'
alias rgns='rg --glob "!*spec.jsx"'
alias rgjsx='rg --glob "*.jsx" --glob "!*spec.jsx"'
alias v='vim'
alias vi='vim'
alias vim='nvim'
alias view='vim -R'
alias vview='vim -R -u NONE'
alias vvim='vim -u NONE' # vanilla vim
alias when='TZ=America/New_York date -d @\'

# git aliases
alias gs='git status'
alias vgit='vim -p `git status --porcelain | cut -c4-`' # Open dirty files

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
    branch=$(echo "$branches" | fzf) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# open a dir in Windows Explorer; explorer.exe only understands absolute
# paths, so translate whatever we're given (default to cwd) with wslpath first
exp() {
  explorer.exe "$(wslpath -w "${1:-.}")"
}

# $ git gb 213 to go to a branch
function gb {
  if [[ -z "$1" ]]; then
    git branch -v
  else
    git branch | grep -v "^*" | fzf -f "$1" | head -n1 | xargs git checkout
  fi
}

# A kind of lazy loading for nvm,npm,etc.
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  # nvim for the mason-installed LSP servers
  nvm_cmds=(nvm node npm yarn npx nvim)
  for cmd in $nvm_cmds ; do
    alias $cmd="unalias $nvm_cmds && unset nvm_cmds && . $NVM_DIR/nvm.sh &&  . $NVM_DIR/bash_completion && $cmd"
  done
fi

# Start the day off right
[[ -o interactive && -t 1 ]] && fortune | cowsay | rainbow 0.5

# zoxide
# Its doctor warns that init isn't last in the file, but syntax highlighting
# genuinely has to come after it, so that's a warning we can never satisfy.
export _ZO_DOCTOR=0
eval "$(zoxide init zsh)"

### WORK DOTFILES
# no per-file symlinking here, this just sources whatever's in the private
# work_dotfiles repo directly. The (N) glob qualifier is zsh's inline
# nullglob, so this is silent instead of erroring on a machine that never
# cloned work_dotfiles
for f in "$HOME"/dotfiles/work_dotfiles/zshrc(N); do
  source "$f"
done

### PRIVATE DOTFILES
# same as work dotfiles
# cloned private_dotfiles
for f in "$HOME"/dotfiles/private_dotfiles/zshrc(N); do
  source "$f"
done

### ZSH SYNTAX HIGHLIGHTING (must be last!)
source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
