# 🔧 macOS Dotfiles

Bu depo (repository), macOS (Apple Silicon) tabanlı geliştirme ortamım için yapılandırma dosyalarını içerir. Tüm yapılandırmalar **GNU Stow** kullanılarak yönetilmektedir.

## 🛠 İçerik

* **OS:** macOS (Apple Silicon)
* **Terminal:** [WezTerm](https://wezfurlong.org/wezterm/)
* **Shell:** Zsh + [Oh My Zsh](https://ohmyz.sh/)
* **Prompt:** [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
* **Editor:** [Neovim](https://neovim.io/)
* **Multiplexer:** [Tmux](https://github.com/tmux/tmux)
* **Git Client:** [Lazygit](https://github.com/jesseduffield/lazygit)

## 🚀 Kurulum

Yeni bir Mac'te kurulum yapmak için aşağıdaki adımları izleyin.

### 1. Ön Gereksinimler

Öncelikle Homebrew'un ve gerekli araçların yüklü olduğundan emin olun:

```bash
# Homebrew yükle (Eğer yoksa)
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh](https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh))"

# Stow ve temel araçları yükle
brew install stow neovim tmux lazygit wezterm

# Zsh eklentileri için (Opsiyonel ama önerilir)
brew install zsh-autosuggestions zsh-syntax-highlighting
