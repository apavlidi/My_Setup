# My Dev Setup

Personal development environment configuration for a new Mac.

## Restore Steps

### 1. Homebrew & packages
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file=Brewfile
```

### 2. zsh config
```bash
cp zsh/.zshrc ~/.zshrc
source ~/.zshrc
```

### 3. fzf shell integration
```bash
$(brew --prefix)/opt/fzf/install
```

### 4. Suppress login message
```bash
touch ~/.hushlogin
```

### 5. Git config
```bash
cp git/.gitconfig ~/.gitconfig
```

### 6. JetBrains keymap (GoLand & WebStorm)
Copy `jetbrains/keymaps/macOS copy.xml` to:
```
~/Library/Application Support/JetBrains/GoLand<version>/keymaps/
~/Library/Application Support/JetBrains/WebStorm<version>/keymaps/
```
Then in the IDE go to **Settings → Keymap** and select `macOS copy`.

## What's included

| File | Description |
|------|-------------|
| `Brewfile` | All Homebrew packages, casks, and tools |
| `zsh/.zshrc` | Zsh config with fzf, autosuggestions, zoxide, custom prompt |
| `git/.gitconfig` | Git user config |
| `jetbrains/keymaps/macOS copy.xml` | Custom keymap for GoLand & WebStorm |
