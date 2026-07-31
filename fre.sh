# Ensure that SSH is set up
github_probe=$(ssh -oStrictHostKeyChecking=no -oBatchMode=yes -T git@github.com 2>&1 || true)
case $github_probe in
  *"Hi "*"!"*) ;;
  *)
    printf 'GitHub SSH access is not set up yet. Set it up now? [y/N] '
    if ! read -r ans < /dev/tty 2>/dev/null; then
      ans=n
    fi
    case $ans in
      y | Y)
        mkdir -p -m 700 ~/.ssh
        keyfile="$HOME/.ssh/id_ed25519"
        if [ ! -f "$keyfile" ]; then
          ssh-keygen -t ed25519 -f "$keyfile" -N ""
        fi
        echo
        echo "Add this public key at https://github.com/settings/keys:"
        echo
        cat "$keyfile.pub"
        echo
        printf 'Press Enter once added: '
        read -r _ < /dev/tty 2>/dev/null || true
        ;;
      *)
        echo "Skipping — the clone below will fail without SSH access to GitHub." >&2
        ;;
    esac
    ;;
esac

# Get the repositories
git clone git@github.com:zack/dotfiles.git ~/dotfiles
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ~/dotfiles/zsh-syntax-highlighting/
git clone git@github.com:tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone git@github.com:Aloxaf/fzf-tab ~/.zsh-plugins/fzf-tab

# Install everything
sh ~/dotfiles/install_script
