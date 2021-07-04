# configs

My configs for safe keeping.

Directory structure:

* `dotfiles` : collection of dotfiles
* `init_shell` : shell initialization script


## Collect dotfiles

dotfiles in the local host can be collected by running a convenient script:

```bash
./collect_dotfiles.sh
```


## Deploy dotfiles to the host

To copy dotfiles to the local host, execute the following script:

```bash
./update_dotfiles.sh
```


## Initialize shell after clean install

```bash
cd init_shell
./install_zsh.sh
# Launch zsh by executing the binary or re-login.
./install_packages.sh
```
