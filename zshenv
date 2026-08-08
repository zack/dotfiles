# Ubuntu's /etc/zsh/zshrc runs compinit before ~/.zshrc gets a chance to add
# ~/.eza/completions/zsh to fpath, so it counts 995 completion files while the
# dump says 996, decides the dump is stale, and rebuilds the whole thing. Then
# our compinit runs, counts 996 against the 995 that one just wrote, and
# rebuilds it right back. Two full rebuilds on every new tmux window, which
# works out to about half a second.
#
# I think the global compinit is redundant anyway since we call it ourselves in
# zshrc, so I'm turning it off rather than trying to get the two to agree.
skip_global_compinit=1

# add node (current version) to path for non-interactive shells
if [ -r "$HOME/.nvm/alias/default" ]; then
  nvm_default_alias=$(cat "$HOME/.nvm/alias/default")
  nvm_default_bin=$(ls -d "$HOME/.nvm/versions/node/v${nvm_default_alias}"* 2>/dev/null | sort -V | tail -1)/bin
  [ -d "$nvm_default_bin" ] && export PATH="$nvm_default_bin:$PATH"
  unset nvm_default_alias nvm_default_bin
fi
