OUTPUT=$(ssh -oStrictHostKeyChecking=no -T git@github.com 2>&1)

case $OUTPUT in
*"zack"*) git clone git@github.com:zack/dotfiles.git ~/dotfiles &&
          git clone git@github.com:zack/secrets.git ~/dotfiles/secrets ;;
*       ) git clone https://github.com/zack/dotfiles.git ~/dotfiles ;;
esac

git clone https://github.com/gmarik/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl https://raw.githubusercontent.com/zack/zsh-themes/master/robbyrussell-ssh.zsh-theme >> ~/.oh-my-zsh/themes/robbyrussel-zack.zsh-theme
sh ~/dotfiles/install_script
vim - +PluginInstall +qal
