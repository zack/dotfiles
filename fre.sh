# This is kind of deprecated? But idk, keeping it around for posterity

# make sure to have intalled:
# * git
# * neovim
# * zsh

# should also probably install:
# * delta
# * fzf
# * ripgrep

OUTPUT=$(ssh -oStrictHostKeyChecking=no -T git@github.com 2>&1)

if [[ $OUTPUT = *"Hi zack!"* ]];
then
  git clone git@github.com:zack/dotfiles.git ~/dotfiles
  git clone git@github.com:zack/work_dotfiles.git ~/dotfiles/work_dotfiles
  git clone git@github.com:zack/secrets.git ~/dotfiles/secrets
else
  git clone https://github.com/zack/dotfiles.git ~/dotfiles
fi

mkdir -p ~/.vim/undo
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/dotfiles/zsh-syntax-highlighting/

sh ~/dotfiles/install_script

# for fzf
sudo cp ~/dotfiles/with-dir /usr/local/bin/with-dir
sudo cp ~/dotfiles/only-dir /usr/local/bin/only-dir
sudo chmod +x /usr/local/bin/with-dir
sudo chmod +x /usr/local/bin/only-dir

# vim-tmux-navigator
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Set up nvim.lazy plugins
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/nvim/lua ~/.config/nvim/lua

# Install yq: https://github.com/mikefarah/yq
echo "Install yq"
