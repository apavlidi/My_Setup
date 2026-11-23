# Monzo laptop setup

Shell and terminal config from my Monzo work laptop.

## What's included

| Path | Goes to |
|------|---------|
| [`zsh/.zshrc`](zsh/.zshrc) | `~/.zshrc` |
| [`zsh/.zprofile`](zsh/.zprofile) | `~/.zprofile` |
| [`zsh/.zshenv`](zsh/.zshenv) | `~/.zshenv` |
| [`iterm2/com.googlecode.iterm2.plist`](iterm2/com.googlecode.iterm2.plist) | iTerm2 preferences (profiles, colours, key mappings, etc.) |

**Not included:**
- `~/.zsh_secrets`: GitHub tokens (`GH_TOKEN_BILL`, `GH_TOKEN_ARIS`). Recreate this file by hand.
- `~/.config/monzo/worktree.zsh`: installed by Monzo Developer Tools.
- Monzo `starter-pack` zshrc/zshenv: sourced from the wearedev checkout, which onboarding sets up.

## Setup on a new laptop

Do the Monzo engineering onboarding first, so `starter-pack` and `worktree` exist. Then:

### 1. Oh My Zsh and plugins
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
brew install zsh-autosuggestions zoxide fzf nvm openjdk@21
$(brew --prefix)/opt/fzf/install
```

### 2. zsh config
```bash
cp monzo/zsh/.zshrc monzo/zsh/.zprofile monzo/zsh/.zshenv ~/
```

### 3. Secrets
```bash
cat > ~/.zsh_secrets <<'EOF'
export GH_TOKEN_BILL="..."
export GH_TOKEN_ARIS="..."
EOF
chmod 600 ~/.zsh_secrets
source ~/.zshrc
```

### 4. iTerm2
Quit iTerm2 completely first. If it's running, it overwrites the imported settings when it quits. Run this from Terminal.app:
```bash
defaults import com.googlecode.iterm2 monzo/iterm2/com.googlecode.iterm2.plist
```
Then open iTerm2.

To update the export from the current machine later:
```bash
plutil -convert xml1 -o monzo/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
```
