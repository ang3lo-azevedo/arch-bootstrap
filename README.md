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

- [ ] Add [nvidia-inst](https://small.bloat.cat/@pranav072bex/comprehensive-guide-to-installing-and-managing-nvidia-driver-on-arch-linux-ubuntu-93eb0e11ce50) to the post-installation script
- [ ] Add persistence in ventoy so that I can get the my user passwords from the usb
- [ ] Improve the overall code
- [ ] Add a way to import the dotfiles
- [ ] Configure [chezmoi](https://www.chezmoi.io/) to manage the dotfiles

### Tools Used
- **archinstall**: [archinstall](https://wiki.archlinux.org/title/Archinstall) - A tool for setting up a fresh Arch Linux installation
- **archpostinstall**: [archpostinstall](https://github.com/ang3lo-azevedo/archpostinstall) - A tool for the post-installation of Arch Linux

## Features

- Installs and configures my Arch Linux system with all my packages, configurations and dotfiles.
