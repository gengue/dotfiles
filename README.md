# Gengue's Dotfiles

include:

  - VIM Config
  - ZSH Config
  - Color schemes

> "Vim vim vim, the number of the beast..."
> , Bruce Dickinson.

## Installation

* clone repo to `~/.dotfiles` folder:

```
cd ~
git clone https://github.com/gengue/dotfiles.git .dotfiles
```

* create symbolic links to config files

```
ln -s .dotfiles/vimrc .vimrc
ln -s .dotfiles/zshrc .zshrc
ln -s .dotfiles/gitignore .gitignore
ln -s .dotfiles/vim .vim
```

### Dependencies MacOS

```
brew install neovim gh lsd the_silver_searcher ack
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
brew install --cask font-fira-code-nerd-font
```

Inside vim:

```
:CocInstall
:CocInstall <plugin1> <plugin2> ... 
```
