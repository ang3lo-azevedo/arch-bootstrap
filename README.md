# Arch Linux Bootstrap

Arch Linux bootstrap is a script that installs and configures a fresh Arch Linux 
installation to a state that is ready to use and already configured with 
something like dotfiles if the user wants.
The setup is designed to be automated and reproducible.

## Development

This repository is a work in progress and is not ready for production use.

## Usage

```bash
curl -L arch.pi.eu.org | sudo bash
```

## TODO

- [ ] Add a config menu to choose what to install and configure
- [ ] Add a way to use [archinstall](https://wiki.archlinux.org/title/Archinstall) to install the base system and ask or get the config
- [ ] Install yay automatically on archinstall and all the packages
- [ ] See if is possible to install the [chaotic-aur](https://aur.chaotic.cx/) and the [endevouros repo](https://forum.endeavouros.com/t/adding-endeavour-os-repo-on-arch-linux/16444) on archinstall and use them to install the packages
- [ ] Add probably [chezmoi](https://www.chezmoi.io/) to manage the dotfiles
- [ ] Add [ansible](https://www.ansible.com/) to configure the system
- [ ] Configure all the post-installation scripts

## Post-installation scripts
- [ ] Add multithreading to the makepkg on the post-installation script
- [ ] Add pacman parallel downloading to the post-installation script
- [ ] Use [nvidia-inst](https://small.bloat.cat/@pranav072bex/comprehensive-guide-to-installing-and-managing-nvidia-driver-on-arch-linux-ubuntu-93eb0e11ce50) to install the nvidia driver
- [ ] Automatically configure KVM
- [ ] Add [endevouros repo](https://forum.endeavouros.com/t/adding-endeavour-os-repo-on-arch-linux/16444) to the post-installation script
- [ ] Add [nvidia-inst](https://small.bloat.cat/@pranav072bex/comprehensive-guide-to-installing-and-managing-nvidia-driver-on-arch-linux-ubuntu-93eb0e11ce50) to the post-installation script
