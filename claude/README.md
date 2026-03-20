# Claude Code Setup

Configuration for [Claude Code](https://docs.anthropic.com/en/docs/claude-code), Anthropic's CLI coding assistant.

---

## Workflow

Prompts are dictated via speech-to-text using [Hex](https://github.com/kitlangton/hex) rather than typed manually. Audio notifications from [Peon Ping](https://github.com/danwald/peon-ping) play character voice lines when Claude finishes a task, hits an error, or needs input — so you know when to look back at the terminal without watching it.

---

## What's Included

### `settings.json`

Global settings copied to `~/.claude/settings.json`. Includes:

- **Model**: `sonnet[1m]` (Claude Sonnet with 1M token context)
- **Pre-approved permissions** for common shell commands so you don't get prompted every time:
  - [Git](https://git-scm.com/) operations (`add`, `commit`, `diff`, `checkout`, `branch`, `fetch`, `log`, `status`, `pull`, `push`, `worktree`)
  - [Go](https://go.dev/) tooling (`go doc`, `go test`, `go build`, `go generate`)
  - [GitHub CLI](https://cli.github.com/) (`gh pr view`, `gh pr create --draft`)
  - [Linear](https://linear.app/) MCP server (`list_teams`, `list_cycles`, `list_issues`, `list_projects`)
  - General shell commands (`ls`, `mkdir`, `cd`, `find`, `grep`, `cat`, `head`, `tail`, etc.)
  - Web fetch from github.com
  - Read/Glob access to `~/.claude/**`
- **Custom status line** pointing to `statusline-command.sh`
- **Hooks** — [Peon Ping](https://github.com/danwald/peon-ping) wired to all key events (session start/end, task complete, errors, permission requests, context compaction)
- **Plugins** — [`gopls-lsp`](https://pkg.go.dev/golang.org/x/tools/gopls) (Go language server) enabled by default

### `statusline-command.sh`

Custom status line script based on the [oh-my-zsh](https://ohmyz.sh/) robbyrussell theme. Shows:
- Current directory name in cyan
- Git branch in red (inside blue parentheses)
- Yellow `✗` indicator when the working tree is dirty

---

## Additional Setup (not in this repo)

These are installed separately and live in `~/.claude/` directly. Documented here for reference.

### Model Preference

Default model is set to `sonnet[1m]` in `settings.json`. Change via `"model"` key or with `/model` inside Claude Code.

### MCP Servers

- **[Linear](https://linear.app/)** — issue tracking integration (permissions in `settings.json`)
- **[Notion](https://www.notion.so/)** — page fetch, search, create, and update (permissions in `settings.local.json`)

### Hooks — Peon Ping

[Peon Ping](https://github.com/danwald/peon-ping) plays character voice lines as audio cues for Claude Code events. Default voice pack is `rick-and-morty` at 50% volume, routed through the macOS Sound Effects device. More packs can be downloaded via `peon packs install <name>`.

**Skills** (slash commands installed with Peon Ping):

| Command | Description |
|---|---|
| `/peon-ping-toggle` | Mute/unmute sound notifications |
| `/peon-ping-use <pack>` | Set a voice pack for the current session |
| `/peon-ping-log <n> <exercise>` | Log exercise reps for the trainer |

### Plugins

Installed via the Claude Code plugin marketplace:

| Plugin | Marketplace | Description |
|---|---|---|
| [`gopls-lsp`](https://pkg.go.dev/golang.org/x/tools/gopls) | claude-plugins-official | Go language server protocol integration |

### Local Permissions (`settings.local.json`)

Additional permissions accumulated over time, not shipped in the repo:
- [Notion](https://www.notion.so/) MCP tools
- `WebSearch` and `WebFetch` for [docs.anthropic.com](https://docs.anthropic.com) and [roadmap.sh](https://roadmap.sh)
- [Homebrew](https://brew.sh/) commands (`brew list`, `brew install`, `brew uninstall`)
- Misc: `stow`, `fzf`, `git clone`, `git config`, `npx ccusage`, `claude mcp add`

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
Follow the [Peon Ping installation instructions](https://github.com/danwald/peon-ping). The hook entries in `settings.json` are already configured — you just need the scripts installed at `~/.claude/hooks/peon-ping/`.

### 4. Install Hex (optional)
[Hex](https://github.com/kitlangton/hex) is installed via the [Brewfile](../Brewfile) (`cask "kitlangton-hex"`). Use it to dictate prompts via speech-to-text instead of typing.

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
