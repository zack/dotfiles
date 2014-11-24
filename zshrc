# Because why would we not want it?
if [ "$TMUX" = "" ]; then tmux -2; fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# oh-my-zsh theme
ZSH_THEME="robbyrussell-ssh"

# Aliases
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
# SSH into CCS
alias ccs="ssh zack@asterix.ccs.neu.edu"
# SSH into CCS2
alias ccs2="ssh zack@burninrubber.ccs.neu.edu"
# SSH into CCS3 for systems and networks
alias ccs3="ssh zack@cs3600tcp.ccs.neu.edu"
# For 256color mode
alias tmux="tmux -2"
# Because I'm lazy
alias ctct="cd ~/dev/work/contacts-core"

# Display red dots while waiting for autocompletion
COMPLETION_WAITING_DOTS="true"

# oh-my-zsh plugins to be loaded
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/zyoungren/.rvm/gems/ruby-1.9.3-p392/bin:/Users/zyoungren/.rvm/gems/ruby-1.9.3-p392@global/bin:/Users/zyoungren/.rvm/rubies/ruby-1.9.3-p392/bin:/Users/zyoungren/.rvm/bin:/Users/zyoungren/.rvm/bin"
