git clone https://github.com/zack/dotfiles.git ~/dotfiles
git clone https://github.com/zsh-users/antigen.git ~/dotfiles/antigen
git clone https://github.com/gmarik/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim
git clone https://github.com/scrooloose/syntastic.git ~/dotfiles/vim/bundle/syntastic
git clone https://github.com/guns/vim-clojure-static ~/dotfiles/vim/bundle/vim-clojure-static
sh ~/dotfiles/install_script
vim - +PluginInstall +qal
