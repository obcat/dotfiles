# dotfiles

## Installation

### dotfiles

1. Navigate to your home directory:
    ```
    $ cd ~
    ```
    
1. Clone this repository:
    ```
    $ git clone https://github.com/obcat/dotfiles.git
    ````

1. Run a shell script to create symbolic links:
    ```
    $ dotfiles/install.sh
    ```

### Vim plugins

1. Launch Vim and run the following command to install a plugin manager:

    ```
    :call PluginManagerInstall()
    ```

1. Reload `vimrc` file:

    ```
    :so $MYVIMRC
    ```

1. Run the following command to install plugins:

    ```
    :PlugInstall
    ```
