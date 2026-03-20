# Claude Code Setup

Configuration for [Claude Code](https://docs.anthropic.com/en/docs/claude-code), Anthropic's CLI coding assistant.

---

## Workflow

Prompts are dictated via speech-to-text using [Hex](https://github.com/kitlangton/hex) rather than typed manually. Audio notifications from [Peon Ping](https://github.com/danwald/peon-ping) play character voice lines when Claude finishes a task, hits an error, or needs input — so you know when to look back at the terminal without watching it.

---

## What's Included

### `settings.json`

Global settings copied to `~/.claude/settings.json`. Includes:

- **Pre-approved permissions** for common shell commands so you don't get prompted every time:
  - [Git](https://git-scm.com/) operations (`add`, `commit`, `diff`, `checkout`, `branch`, `fetch`, `log`, `status`, `pull`, `push`, `worktree`)
  - [Go](https://go.dev/) tooling (`go doc`, `go test`, `go build`, `go generate`)
  - [GitHub CLI](https://cli.github.com/) (`gh pr view`, `gh pr create --draft`)
  - General shell commands (`ls`, `mkdir`, `cd`, `find`, `grep`, `cat`, `head`, `tail`, etc.)
  - Web fetch from github.com
  - Read/Glob access to `~/.claude/**`
- **Custom status line** pointing to `statusline-command.sh`
- **Plugins** — [`gopls-lsp`](https://pkg.go.dev/golang.org/x/tools/gopls) (Go language server) enabled by default

### `statusline-command.sh`

Custom status line script based on the [oh-my-zsh](https://ohmyz.sh/) robbyrussell theme. Shows:
- Current directory name in cyan
- Git branch in red (inside blue parentheses)
- Yellow `✗` indicator when the working tree is dirty

---

## Additional Setup (not in this repo)

These are installed separately and live in `~/.claude/` directly. Documented here for reference.

### Hooks — Peon Ping

[Peon Ping](https://github.com/danwald/peon-ping) is a hook system that plays audio notifications for Claude Code events. Character voice lines play when tasks complete, errors occur, or input is needed — acting as an audio cue so you don't have to watch the terminal.

**Installed at:** `~/.claude/hooks/peon-ping/`

**Hooked events:**
- `SessionStart`, `SessionEnd` — session lifecycle sounds
- `SubagentStart` — subagent spawn notification
- `UserPromptSubmit` — acknowledges your input (also handles `/peon-ping-use` and rename hooks)
- `Stop` — task completion sounds
- `Notification`, `PermissionRequest` — attention-required alerts
- `PostToolUseFailure` — error sounds (Bash tool only)
- `PreCompact` — context compaction notification

**Config highlights** (`~/.claude/hooks/peon-ping/config.json`):
- Default voice pack: `rick-and-morty`
- Volume: `0.5`
- Routes audio through macOS Sound Effects device
- Sound categories: session start, task complete, task error, input required, resource limit, user spam all enabled

**Available voice packs:**
- `rick-and-morty` — Rick and Morty quotes
- `abbot` — Warcraft Peon sounds
- More packs can be downloaded via `peon packs install <name>`

### Skills

Custom slash commands installed at `~/.claude/skills/`:

| Skill | Command | Description |
|---|---|---|
| peon-ping-toggle | `/peon-ping-toggle` | Mute/unmute sound notifications |
| peon-ping-use | `/peon-ping-use <pack>` | Set a voice pack for the current session |
| peon-ping-log | `/peon-ping-log <n> <exercise>` | Log exercise reps (pushups/squats) for the trainer |
| peon-ping-config | (internal) | Update peon-ping configuration settings |

### Plugins

Installed via the Claude Code plugin marketplace:

| Plugin | Marketplace | Description |
|---|---|---|
| [`gopls-lsp`](https://pkg.go.dev/golang.org/x/tools/gopls) | claude-plugins-official | Go language server protocol integration |

### Policy Restrictions

`~/.claude/policy-limits.json` disables remote control:
```json
{
  "restrictions": {
    "allow_remote_control": {
      "allowed": false
    }
  }
}
```

---

## Setup Steps

### 1. Copy config files
```bash
cp claude/settings.json ~/.claude/settings.json
cp claude/statusline-command.sh ~/.claude/statusline-command.sh
```

### 2. Install the Go LSP plugin
Inside Claude Code, run:
```
/plugin install gopls-lsp@claude-plugins-official
```

### 3. Install Peon Ping (optional)
Follow the [Peon Ping installation instructions](https://github.com/danwald/peon-ping) to set up audio notifications. The hook entries in `settings.json` are already configured — you just need the hook scripts installed at `~/.claude/hooks/peon-ping/`.

### 4. Install Hex (optional)
[Hex](https://github.com/kitlangton/hex) is installed via the [Brewfile](../Brewfile) (`cask "kitlangton-hex"`). Use it to dictate prompts to Claude Code via speech-to-text instead of typing.

### 5. Set up policy restrictions (optional)
```bash
cat > ~/.claude/policy-limits.json << 'EOF'
{
  "restrictions": {
    "allow_remote_control": {
      "allowed": false
    }
  }
}
EOF
```
