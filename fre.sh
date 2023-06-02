# This is kind of deprecated? But idk, keeping it around for posterity

# make sure to have intalled:
# * git
# * vim
# * zsh

# should also probably install:
# * ag
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
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sh ~/dotfiles/install_script

vim +PlugInstall +qal

# for fzf
sudo cp ~/dotfiles/with-dir /usr/local/bin/with-dir
sudo cp ~/dotfiles/only-dir /usr/local/bin/only-dir
sudo chmod +x /usr/local/bin/with-dir
sudo chmod +x /usr/local/bin/only-dir
