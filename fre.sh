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
git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/dotfiles/zsh-syntax-highlighting/

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

curl https://raw.githubusercontent.com/zack/zsh-themes/master/robbyrussell-ssh.zsh-theme >> ~/.oh-my-zsh/themes/robbyrussel-zack.zsh-theme

sh ~/dotfiles/install_script

vim +PluginInstall +qal
vim +"call minpac#update"

# for fzf
sudo cp ~/dotfiles/with-dir /usr/local/bin/with-dir
sudo cp ~/dotfiles/only-dir /usr/local/bin/only-dir
sudo chmod +x /usr/local/bin/with-dir
sudo chmod +x /usr/local/bin/only-dir
