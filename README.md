# My Dev Setup

Personal development environment configuration for a new Mac. Clone this repo and follow the steps below to get back up and running quickly.

---

## What's Included

### `Brewfile`
All Homebrew packages and Mac apps. Includes:
- **Dev tools**: Git, Go, Docker, Node (nvm), Python, Ruby, Terraform, AWS CLI
- **Terminal**: fzf (fuzzy history search), zoxide (smart cd), zsh-autosuggestions
- **Apps**: Alfred, Rectangle, JetBrains Toolbox, GPG Suite, YubiKey Manager

### `zsh/.zshrc`
Zsh shell configuration. Includes:
- **Oh My Zsh** with git plugin aliases (ggpush, ggpull, gst, gco, etc.)
- **fzf** — fuzzy search through command history with Ctrl+R
- **zsh-autosuggestions** — ghost-text command suggestions as you type
- **zoxide** — smart directory jumping with `z <folder>`
- **Custom prompt** — random emoji instead of the default arrow

### `git/.gitconfig`
Global git configuration. Remember to update the email after copying.

### `jetbrains/keymaps/macOS copy.xml`
Custom keymap for GoLand and WebStorm. Key shortcuts include:
- `Cmd+J` — select next occurrence
- `Cmd+W` — expand selection
- `Cmd+Y` — delete line
- `Cmd+F12` — open terminal
- `Shift+Cmd+N` — go to file

### `jetbrains/codestyles/GoogleStyle.xml`
Google code style scheme used in GoLand. Key settings:
- 2-space indentation (no tabs)
- 100 character line width
- Wrapping on method/call parameters

### `claude/settings.json`
Claude Code global settings. Includes pre-approved shell permissions so you don't get prompted for common commands (git, go, gh, etc.), and the custom status line config.

### `claude/statusline-command.sh`
Custom Claude Code status line that shows the current directory and git branch (with a dirty indicator if there are uncommitted changes).

---

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
```bash
cp claude/settings.json ~/.claude/settings.json
cp claude/statusline-command.sh ~/.claude/statusline-command.sh
```
Then install the Go language server plugin:
```
/plugin install gopls-lsp@claude-plugins-official
```

### 8. GitHub CLI
```bash
gh auth login
```
