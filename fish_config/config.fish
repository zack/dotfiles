set PATH $PATH /usr/local/bin
set PATH $PATH $HOME/.rvm/bin

export LESS=-r

# Every new shell should launch tmux
if [ "$TMUX" = "" ]
    tmux -2
end

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  set -l show_untracked (git config --bool bash.showUntrackedFiles)
  set untracked ''
  if [ "$theme_display_git_untracked" = 'no' -o "$show_untracked" = 'false' ]
    set untracked '--untracked-files=no'
  end
  echo (command git status -s --ignore-submodules=dirty $untracked ^/dev/null)
end

function fish_prompt
  set -l last_status $status
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)

  if [ "$TMUX" != "" ]
      set arrow_glyph "→"
  else
      set arrow_glyph "⇝"
  end

  if test $last_status = 0
      set arrow "$green$arrow_glyph"
  else
      set arrow "$red$arrow_glyph"
  end

  set -l cwd $cyan(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    set -l git_branch $red(_git_branch_name)
    set git_info "$blue git:($git_branch$blue)"

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗"
      set git_info "$git_info$dirty"
    end
  end

  echo -n -s $arrow ' ' $cwd $git_info $normal ' '
end

# general aliases
alias ack 'echo "no more ack"'
alias ag 'ag -p ~/.agignore'
alias history 'history | nl'
alias killswp 'rm **/.*.swp; rm **/.*.swo'
alias ld 'ls -d */'
alias tmux 'tmux -2'

# git aliases
alias gs 'git st'

# rails aliases
alias rc 'rails c'
alias rs 'rails s 2>&1 | grep -v content-length'

# work aliases
alias rssl 'bundle exec bin/secure_rails s'
alias rssld 'RAILS_ENV=production_local_d1 bundle exec bin/secure_rails s'
alias rssll 'bundle exec bin/rails_l1 s'
# alias kr 'bundle exec rake konacha:run 2> >(grep -v CoreText 1>&2)'
alias ks 'bundle exec rake konacha:serve'
# alias rss 'bundle exec rspec spec 2> >(grep -v CoreText 1>&2)'

# Colorized manual pages
set -x LESS_TERMCAP_mb (printf "\033[01;31m")
set -x LESS_TERMCAP_md (printf "\033[01;31m")
set -x LESS_TERMCAP_me (printf "\033[0m")
set -x LESS_TERMCAP_se (printf "\033[0m")
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\033[0m")
set -x LESS_TERMCAP_us (printf "\033[01;32m")
