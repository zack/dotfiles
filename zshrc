# Because why would we not want it?
if [ "$TMUX" = "" ]; then tmux; fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias gs="git st"
# Never commit this file
alias gcot="git checkout app/assets/javascripts/templates/templates.js.erb"
# Start the rails app without stupid warnings
alias rs="rails s 2>&1 | grep -v content-length"
# Start the rails console
alias rc="rails c"
# Start konacha:run with font warnings hidden
alias kr="bundle exec rake konacha:run 2> >(grep -v CoreText 1>&2)"
# Start rspec spec with font warnings hidden
alias rss="bundle exec rspec spec  2> >(grep -v CoreText 1>&2)"
# Start konacha:serve
alias ks="bundle exec rake konacha:serve"
# Beacuse hotkey doesn't work in tmux
alias cl="clear"
# Show me just the directories
alias ld="ls -d */"
# Open all uncommitted (git) files in vim
alias vim-git='vi -p `git status --porcelain | cut -c4-`'
# Update local (constant contact update local [old name] -> ctul -> cthulhu)
alias cthulhu="git checkout dev && git fetch upstream && git reset --hard upstream/development"


# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/zyoungren/.rvm/gems/ruby-1.9.3-p392/bin:/Users/zyoungren/.rvm/gems/ruby-1.9.3-p392@global/bin:/Users/zyoungren/.rvm/rubies/ruby-1.9.3-p392/bin:/Users/zyoungren/.rvm/bin:/Users/zyoungren/.rvm/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

