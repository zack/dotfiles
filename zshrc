export PATH="$PATH:/usr/local/bin/"

# Source secrets
if [[ -f ~/dotfiles/secrets/secrets.config ]]; then
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
#alias ip="ifconfig | grep Bcast | cut -d':' -f 2 | cut -d' ' -f 1"
alias ack='echo "no more ack"'
#alias sshvm="ssh zack@`VBoxManage guestproperty get 'Ubuntu64' '/VirtualBox/GuestInfo/Net/1/V4/IP' | awk '{ print $2 }'`"
alias clojure='java -cp ~/clojure/clojure-1.8.0.jar clojure.main'
alias ag='ag --path-to-agignore ~/.agignore'

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
alias copyoverride='pbcopy < ~/override.txt'
alias devportal='cd ~/dev/ctct/galileo/auth-devportal'
alias devportalw='cd ~/dev/ctct/galileo/auth-devportal/auth-devportal-webapp'
alias galileo='cd ~/dev/ctct/galileo'
alias getoverride='pbcopy < ~/override.txt'
alias platform='cd ~/dev/ctct/galileo/auth-platform'
alias platformw='cd ~/dev/ctct/galileo/auth-platform/auth-platform-webapp'
alias vol100='while true; do osascript -e "set volume input volume 100"; sleep 1; done'
alias fixbtaudio='
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40 &&
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" 80 &&
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 48 &&
  defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" 40 &&
  defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" 40 &&
  defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" 58 &&
  defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" 58 &&
  defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" 48 &&
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" 80 &&
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 80 &&
  defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" 80 &&
  defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" 80 &&
  defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" 80 &&
  defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" 80 &&
  defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" 80'

# contacts
alias rssl='bundle exec bin/secure_rails s'
alias rssld='RAILS_ENV=production_local_d1 bundle exec bin/secure_rails s'
alias rssll='bundle exec bin/rails_l1 s'
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

# Colorized man pages
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

# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# export PATH="/usr/local/apache-maven/3.3.9/bin:$PATH" # Add maven to path
# export JAVA_HOME=`/usr/libexec/java_home`
# # Add GHC 7.10.3 to the PATH, via https://ghcformacosx.github.io/
# export GHC_DOT_APP="/Applications/ghc-7.10.3.app"
# if [ -d "$GHC_DOT_APP" ]; then
  # export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
# fi
#

zstyle ':completion::complete:git-checkout:argument-rest:remote-branch-refs-noprefix' command "echo"

