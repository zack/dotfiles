# Antigen
source ~/dotfiles/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme zack/zsh-themes robbyrussell-ssh
antigen apply

# Tmux for new zsh instance
if [ "$TMUX" = "" ]; then tmux -2; fi

# Display red dots while waiting for autocompletion
COMPLETION_WAITING_DOTS="true"

# general aliases
alias ld='ls -d */'
alias tmux='tmux -2'

# ccs machines
alias ccs='ssh zack@asterix.ccs.neu.edu'
alias ccs2='ssh zack@burninrubber.ccs.neu.edu'

# git aliases
alias gs='git st'
alias vgit='vim -p `git status --porcelain | cut -c4-`' # Open dirty files

# work related aliases
alias rc='rails c'
alias rs='rails s 2>&1 | grep -v content-length'
alias kr='bundle exec rake konacha:run 2> >(grep -v CoreText 1>&2)'
alias ks='bundle exec rake konacha:serve'
alias rss='bundle exec rspec spec 2> >(grep -v CoreText 1>&2)'
alias gcot='git checkout app/assets/javascripts/templates/templates.js.erb'

# Work Stuff
#export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/zyoungren/.rvm/gems/ruby-1.9.3-p392/bin:/Users/zyoungren/.rvm/gems/ruby-1.9.3-p392@global/bin:/Users/zyoungren/.rvm/rubies/ruby-1.9.3-p392/bin:/Users/zyoungren/.rvm/bin:/Users/zyoungren/.rvm/bin"
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
