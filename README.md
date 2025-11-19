# Dotfiles Setup and Usage Guide (macOS / Apple Silicon)

This document provides a **complete, step-by-step guide** for installing, configuring, and maintaining the dotfiles in this repository on a **macOS (Apple Silicon)** system. It covers all prerequisites, required tools, Stow usage, directory structure, and long‑term maintenance.

---

# 📌 Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Installing Required Software](#installing-required-software)
4. [Dotfiles Directory Structure](#dotfiles-directory-structure)
5. [What is GNU Stow?](#what-is-gnu-stow)
6. [Installation Steps](#installation-steps)
7. [Configuration Details for Each Tool](#configuration-details-for-each-tool)
8. [How to Add New Configurations](#how-to-add-new-configurations)
9. [Troubleshooting](#troubleshooting)
10. [Updating & Maintaining Dotfiles](#updating--maintaining-dotfiles)

---

# 1. Overview

This repository contains configuration files (dotfiles) designed to quickly set up a modern development environment on **macOS (Apple Silicon)**. All configurations are managed using **GNU Stow**, allowing clean, organized, and easily reproducible setups.

Tools configured in this repository:

* **Zsh** (default macOS shell)
* **Oh My Zsh** + Powerlevel10k
* **WezTerm** (terminal emulator)
* **Neovim** (code editor)
* **Tmux** (terminal multiplexer)
* **Lazygit** (Git interface)
* **GNU Stow** (symlink manager)

---

# 2. Prerequisites

Before starting, ensure the following:

* macOS 12 or later
* Apple Silicon (M1/M2/M3...)
* Xcode Command Line Tools installed:

```sh
xcode-select --install
```

---

# 3. Installing Required Software

## Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Add Homebrew to your PATH:

```sh
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

---

## Install all required packages

```sh
brew install \
    stow \
    zsh \
    neovim \
    tmux \
    lazygit \
    wezterm
```

Install Oh My Zsh:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install Powerlevel10k:

```sh
brew install romkatv/powerlevel10k/powerlevel10k
```

---

# 4. Dotfiles Directory Structure

Typical layout:

```
./dotfiles
 ├── zsh/
 │    └── .zshrc
 ├── nvim/
 │    └── .config/nvim/**
 ├── tmux/
 │    └── .tmux.conf
 ├── wezterm/
 │    └── .wezterm.lua
 └── lazygit/
      └── .config/lazygit/**
```

Each folder represents a separate Stow package.

---

# 5. What is GNU Stow?

GNU Stow is a symlink manager used to keep dotfiles organized. Instead of copying files manually into your home directory, Stow creates symbolic links automatically.

For example:

```
stow zsh
```

This command links:

```
zsh/.zshrc → ~/.zshrc
```

### Benefits of Stow

* Clean separation of configs
* Easy to version-control
* Fast machine setup
* Simple installation and removal

---

# 6. Installation Steps

### 1) Clone the repository

```sh
cd ~
git clone https://github.com/gorkem-arpaci/dotfiles.git
cd dotfiles
```

### 2) Stow each configuration

```sh
stow zsh
stow nvim
stow tmux
stow wezterm
stow lazygit
```

Or apply all at once:

```sh
stow */
```

### 3) Restart your terminal

---

# 7. Configuration Details for Each Tool

## 🔹 Zsh + Oh My Zsh + Powerlevel10k

Configuration file:

```
~/.zshrc
```

Powerlevel10k wizard runs automatically on first shell startup.

Re-run at any time:

```sh
p10k configure
```

---

## 🔹 Neovim

Location:

```
~/.config/nvim/
```

Includes:

* Plugin manager
* LSP configuration
* Key mappings
* Themes

Launch:

```sh
nvim
```

---

## 🔹 Tmux

Config file:

```
~/.tmux.conf
```

Start tmux:

```sh
tmux
```

---

## 🔹 WezTerm

Config file:

```
~/.wezterm.lua
```

WezTerm loads configuration automatically on startup.

---

## 🔹 Lazygit

Config directory:

```
~/.config/lazygit/
```

Launch:

```sh
lazygit
```

---

# 8. How to Add New Configurations

Example: Add configuration for **Kitty terminal**

### 1) Create directory in dotfiles

```
mkdir kitty
```

### 2) Place files using the real directory structure

```
kitty/.config/kitty/kitty.conf
```

### 3) Stow it

```
stow kitty
```

Done.

---

# 9. Troubleshooting

### ❌ “File already exists” errors

Remove conflicting file:

```sh
rm ~/.zshrc
stow zsh
```

### ❌ Wrong paths created

Unstow the package:

```sh
stow -D zsh
```

### ❌ Stow does nothing

Ensure you are inside the dotfiles repo:

```sh
pwd
```

Should output:

```
~/dotfiles
```

---

# 10. Updating & Maintaining Dotfiles

### To change a configuration

1. Edit files in the **dotfiles repository**, not in `$HOME`
2. If new files were added, run `stow` again

### When setting up a new machine:

```sh
git clone <repo>
stow */
```

Everything will be linked automatically.

---

# 🎉 Setup Complete!

You now have a clean, modular, and reproducible development environment powered by Stow and modern CLI tools.

If you'd like, I can also create:

* an automatic `install.sh` setup script
* a Brewfile for automated package installation
* a bootstrap script for new machines
