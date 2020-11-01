# dotfiles

## Installation

### dotfiles

Go to your home directory
```
$ cd ~
```
    
Clone this repository
```
$ git clone https://github.com/obcat/dotfiles.git
````

Create symbolic links
```
$ dotfiles/install.sh
```

### Vim plugins

Launch Vim
```
$ vim
```

Install plugin manager
```
:call PluginManagerInstall()
```

Reload `vimrc` file
```
:so $MYVIMRC
```

Install plugins
```
:PlugInstall
```
