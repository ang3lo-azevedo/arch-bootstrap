# Arch Linux Bootstrap

This repository is what I use to bootstrap a new Arch Linux system.

## Development

This repository is a work in progress and is not ready for production use.

## TODO

- [ ] Add persistence in ventoy so that I can get the my user passwords from the usb
- [ ] Improve the overall code
- [ ] Add a way to import the dotfiles

## Overview

This repository contains my personal dotfiles and configuration scripts for setting up a fresh Arch Linux installation. The setup is designed to be automated and reproducible.

### Tools Used
- **archinstall**: [archinstall](https://wiki.archlinux.org/title/Archinstall) - A tool for setting up a fresh Arch Linux installation
- **archpostinstall**: [archpostinstall](https://github.com/ang3lo-azevedo/archpostinstall) - A tool for the post-installation of Arch Linux

## Usage

```bash
curl -L arch.pi.eu.org | sudo bash
```

## Features

- Installs and configures my Arch Linux system with all my packages, configurations and dotfiles.
