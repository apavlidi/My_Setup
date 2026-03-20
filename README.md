# My Dev Setup

Personal development environment configuration for macOS. Use it to set up a new machine or as a reference for your own setup.

---

## What's Included

### [`Brewfile`](Brewfile)
All [Homebrew](https://brew.sh/) packages and Mac apps. Includes:
- **Dev tools**: Git, Go, Docker, Node (nvm), Python, Ruby, Terraform, AWS CLI
- **Terminal**: [fzf](https://github.com/junegunn/fzf) (fuzzy history search), [zoxide](https://github.com/ajeetdsouza/zoxide) (smart cd), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- **Apps**: [Alfred](https://www.alfredapp.com/), [Rectangle](https://rectangleapp.com/), [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/), GPG Suite, YubiKey Manager
- **Speech-to-text**: [Hex](https://github.com/kitlangton/hex) for dictating prompts to Claude Code and other tools

### [`zsh/.zshrc`](zsh/.zshrc)
Zsh shell configuration. Includes:
- **[Oh My Zsh](https://ohmyz.sh/)** with git plugin aliases (ggpush, ggpull, gst, gco, etc.)
- **[fzf](https://github.com/junegunn/fzf)** — fuzzy search through command history with Ctrl+R
- **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)** — ghost-text command suggestions as you type
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** — smart directory jumping with `z <folder>`
- **Custom prompt** — random emoji instead of the default arrow

### [`git/.gitconfig`](git/.gitconfig)
Global git configuration. Remember to update the email after copying.

### [`jetbrains/keymaps/macOS copy.xml`](jetbrains/keymaps/macOS%20copy.xml)
Custom keymap for GoLand and WebStorm. Key shortcuts include:
- `Cmd+J` — select next occurrence
- `Cmd+W` — expand selection
- `Cmd+Y` — delete line
- `Cmd+F12` — open terminal
- `Shift+Cmd+N` — go to file

### [`jetbrains/codestyles/GoogleStyle.xml`](jetbrains/codestyles/GoogleStyle.xml)
Google code style scheme used in GoLand. Key settings:
- 2-space indentation (no tabs)
- 100 character line width
- Wrapping on method/call parameters

### [`claude/`](claude/)
[Claude Code](https://docs.anthropic.com/en/docs/claude-code) configuration including global settings, custom status line, hooks, plugins, and skills. Also includes a write-up on [how I use Claude Code](claude/HOW_I_USE_CLAUDE.md) for day-to-day engineering. See the [Claude Code README](claude/README.md) for full details.

---

## Setup Steps

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
Update your email in `~/.gitconfig` after copying.

### 6. JetBrains keymap (GoLand & WebStorm)
Copy `jetbrains/keymaps/macOS copy.xml` to:
```
~/Library/Application Support/JetBrains/GoLand<version>/keymaps/
~/Library/Application Support/JetBrains/WebStorm<version>/keymaps/
```
Then in the IDE go to **Settings → Keymap** and select `macOS copy`.

Copy `jetbrains/codestyles/GoogleStyle.xml` to:
```
~/Library/Application Support/JetBrains/GoLand<version>/codestyles/
~/Library/Application Support/JetBrains/WebStorm<version>/codestyles/
```
Then go to **Settings → Editor → Code Style** and select `GoogleStyle`.

### 7. Claude Code
See the [Claude Code README](claude/README.md) for detailed setup instructions.

### 8. GitHub CLI
```bash
gh auth login
```
