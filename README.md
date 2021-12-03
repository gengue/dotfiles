# Gengue's Dotfiles

include:

  - VIM Config
  - ZSH Config
  - Color schemes

> "Vim vim vim, the number of the beast..."
> , Bruce Dickinson.

## Installation

* Clone repo to `~/.dotfiles` folder:

```
cd ~
git clone https://github.com/gengue/dotfiles.git .dotfiles
```

* Create symbolic links to config files

```
ln -s .dotfiles/vimrc .vimrc
ln -s .dotfiles/zshrc .zshrc
ln -s .dotfiles/gitignore .gitignore
ln -s .dotfiles/vim .vim
ln -s .dotfiles/aliases .aliases
ln -s .dotfiles/functions .functions 
```

### Dependencies MacOS

```
brew install zsh
chsh -s /usr/local/bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install neovim gh lsd the_silver_searcher ack
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
brew install --cask font-fira-code-nerd-font
```

### Dependencies Linux

```
sudo apt install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo apt-get install neovim
sudo apt-get install python-neovim python3-neovim
```

Inside vim:

```
:CocInstall
:CocInstall <plugin1> <plugin2> ... 
```
