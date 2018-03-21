# make sure to have intalled:
# * tmux
# * vim
# * zsh

# should also probably install:
# * ag
# * diff-so-fancy
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
git clone https://github.com/gmarik/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl https://raw.githubusercontent.com/zack/zsh-themes/master/robbyrussell-ssh.zsh-theme >> ~/.oh-my-zsh/themes/robbyrussel-zack.zsh-theme
sh ~/dotfiles/install_script
vim - +PluginInstall +qal

# for fzf
sudo cp ~/dotfiles/with-dir /usr/bin/with-dir
sudo cp ~/dotfiles/only-dir /usr/bin/only-dir
sudo chmod +x /usr/bin/with-dir
sudo chmox +x /usr/bin/only-dir
