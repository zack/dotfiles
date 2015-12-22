# Source secrets
if [[ -f /dotfiles/secrets/secrets.config ]]; then
  source ~/dotfiles/secrets/secrets.config
fi

# Antigen
source ~/dotfiles/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme zack/zsh-themes robbyrussell-ssh
antigen apply

# vi mode and settings
bindkey -v
export KEYTIMEOUT=1
bindkey '^R' history-incremental-search-backward

# Tmux for new zsh instance
if [ "$TMUX" = "" ]; then tmux -2; fi

# Don't rename TMUX windows on command execution
DISABLE_AUTO_TITLE=true

# Display red dots while waiting for autocompletion
COMPLETION_WAITING_DOTS="true"

# general aliases
alias ld='ls -d */'
alias tmux='tmux -2'
alias killswp='rm **/.*.swp; rm **/.*.swo'
alias cm='cmatrix'
alias noun='ack -v .un~'
alias ip="ifconfig | grep Bcast | cut -d':' -f 2 | cut -d' ' -f 1"
alias ack='echo "no more ack"'

# ccs machines
alias ccs='ssh zack@asterix.ccs.neu.edu'
alias ccs2='ssh zack@burninrubber.ccs.neu.edu'

# git aliases
alias gs='git st'
alias vgit='vim -p `git status --porcelain | cut -c4-`' # Open dirty files

# rails aliases
alias rc='rails c'
alias rs='rails s 2>&1 | grep -v content-length'
alias tc='bundle exec rake tmp:clear'

# work aliases
alias ctct='toilet -f calgphy2 "Constant Contact" -w 1000 -F border | lolcat'
alias vol100='while true; do osascript -e "set volume input volume 100"; sleep 1; done'
alias galileo='cd ~/dev/ctct/galileo'
alias devportal='cd ~/dev/ctct/galileo/auth-devportal'
alias platform='cd ~/dev/ctct/galileo/auth-platform'
alias devportalw='cd ~/dev/ctct/galileo/auth-devportal/auth-devportal-webapp'
alias platformw='cd ~/dev/ctct/galileo/auth-platform/auth-platform-webapp'

# contacts
alias rssl='bundle exec bin/secure_rails s 2>&1 | grep -v content-length'
alias rssld='RAILS_ENV=production_local_d1 bundle exec bin/secure_rails s \
  2>&1 | grep -v content-length'
alias kr='bundle exec rake konacha:run 2> >(grep -v CoreText 1>&2)'
alias ks='bundle exec rake konacha:serve'
alias rss='bundle exec rspec spec 2> >(grep -v CoreText 1>&2)'
alias gcot='git checkout app/assets/javascripts/templates/templates.js.erb'

# galileo
alias grs='SERVICES_ENV=local rails s'
alias grss='SERVICES_ENV=local rspec spec'

# Hit Ctrl-Z again to go back in
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

ip(){
  print -P "\033[1;31mExt IP:\033[0m `dig +short myip.opendns.com @resolver1.opendns.com`"
  print -P "\033[1;36mLcl IP:\033[0m `ipconfig getifaddr en0`"
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
