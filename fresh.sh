git clone git@github.com:zack/dotfiles.git ~/dotfiles
git clone https://github.com/zsh-users/antigen.git ~/dotfiles/antigen
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/scrooloose/syntastic.git ~/.vim/bundle/syntastic
sh ~/dotfiles/install_script
vim - +PluginInstall +qal
