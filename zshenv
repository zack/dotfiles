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
  # "default" can point at another alias instead of a version number -- mine
  # is set to "stable" so it always tracks whatever's newest installed.
  # Follow the chain by hand instead of sourcing nvm.sh (slow); once a name
  # has no backing alias file left -- true immediately for the built-ins
  # "stable"/"node"/"iojs", which nvm resolves in code, not on disk -- treat
  # it as "newest installed".
  nvm_hops=0
  while [ -r "$HOME/.nvm/alias/$nvm_default_alias" ] && [ "$nvm_hops" -lt 10 ]; do
    nvm_default_alias=$(cat "$HOME/.nvm/alias/$nvm_default_alias")
    nvm_hops=$((nvm_hops + 1))
  done
  case "$nvm_default_alias" in
    v[0-9]*) nvm_version_prefix="$nvm_default_alias" ;;
    [0-9]*) nvm_version_prefix="v$nvm_default_alias" ;;
    *) nvm_version_prefix='v' ;;
  esac
  nvm_default_bin=$(ls -d "$HOME/.nvm/versions/node/${nvm_version_prefix}"* 2>/dev/null | sort -V | tail -1)/bin
  [ -d "$nvm_default_bin" ] && export PATH="$nvm_default_bin:$PATH"
  unset nvm_default_alias nvm_hops nvm_version_prefix nvm_default_bin
fi

# zshrc launches tmux before it reaches its own PATH section, and tmux here is
# a source build in ~/.local/bin rather than a package in /usr/bin. The entry
# has to exist before zshrc runs at all, or the first terminal of a session
# comes up with "command not found: tmux" and no tmux.
export PATH="$HOME/.local/bin:$PATH"
. "$HOME/.cargo/env"
