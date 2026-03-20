# How I Use Claude Code

A rough overview of how I use Claude Code for day-to-day engineering. The "state of the art" for AI tools changes every month, so this will age quickly.

---

## Talking to Claude with speech-to-text

Most of my prompts are dictated via [Hex](https://github.com/kitlangton/hex) rather than typed. Claude is very good at interpreting poorly-structured thoughts — you can spew words at it in a rough order and it will understand your meaning just fine. This felt awkward at first, but it's significantly faster than typing out well-formed sentences.

Screenshots work the same way. Copy a screen region with `Cmd+Ctrl+Shift+4`, paste it into Claude with `Ctrl+V`, and say something like "fix this" or "implement this". It handles visual context surprisingly well.

## Handling tasks by size

My approach varies depending on complexity.

**Small tasks** — one or two prompts is enough. I start with something like: "Checkout a new feature branch on latest origin/master. Implement X and add corresponding tests. Raise a draft PR when you're done."

**Medium tasks** — like implementing a new handler or endpoint. I prompt Claude into [plan mode](https://docs.anthropic.com/en/docs/claude-code/common-workflows#when-to-use-plan-mode) before starting implementation. I go back and forth a few times refining the plan (e.g. "needs idempotency", "skip metrics for now") before accepting it. Roughly 30% of effort goes into refining the output afterwards: renaming things, trimming unhelpful tests, removing Claude's unnecessary comments.

**Large tasks** — for changes too big for a single PR, I use a two-phase approach:

1. **Plan and implement** the full change on a feature branch, ending up with one massive draft PR.
2. **Split the change** by prompting Claude to break it into smaller, reviewable PRs with corresponding [Linear](https://linear.app/) tickets using the `gh` CLI and the [Linear MCP server](https://linear.app/docs/mcp).

This works well for getting a large feature functional end-to-end, then slicing it into mergeable units.

## Always make Claude validate its work

The most useful tactic for autonomous Claude sessions: **always ask it how it's going to test its changes**. Claude produces much better results when it has a concrete validation plan. Common approaches:

- Writing and running unit tests
- Running integration/acceptance tests
- Deploying to a staging environment and verifying behaviour
- Reading logs and traces

Claude usually needs a nudge to start using these tools once per session. After that, it tends to keep using them without further prompting.

## Running multiple sessions in parallel

To avoid idle time while Claude works, I context-switch between two or three tasks concurrently using [Git worktrees](https://git-scm.com/docs/git-worktree):

```
~/src/project
├── worktrees
│   ├── alice       # task 1
│   ├── bob         # task 2
│   └── charlie     # task 3
└── main            # standard checkout (read-only, for investigations)
```

Each worktree gets its own terminal with a Claude Code session. Claude Code also has [built-in worktree support](https://docs.anthropic.com/en/docs/claude-code/common-workflows#run-parallel-claude-code-sessions-with-git-worktrees) worth exploring.

## Audio notifications with Peon Ping

Running multiple sessions means it's hard to track which ones have finished or are waiting for input. [Peon Ping](https://github.com/danwald/peon-ping) solves this by playing character voice lines on Claude Code events — task complete, errors, permission requests, etc. I can step away from the terminal and know when to come back.

See the [Claude Code README](README.md) for the full Peon Ping configuration.

## Things I'm still unhappy with

1. **Claude writes bad prose.** PR descriptions and commit messages often add nothing useful. I frequently throw away the generated output and write my own.
2. **Claude doesn't write code like I do.** For any meaningful change, I spend time refining the output. The most annoying habit is adding unnecessary comments everywhere.
3. **Speech-to-text struggles with jargon.** If I say "service dot account", Hex transcribes it literally. Claude handles garbled input well, but gets confused when you don't precisely reference specific files or systems.

## Copying this workflow

- Install [Hex](https://github.com/kitlangton/hex) via Homebrew (included in the [Brewfile](../Brewfile)) and download a transcription model from the app.
- Copy the Claude Code config from this repo — see the [setup steps](README.md#setup-steps).
- Install [Peon Ping](https://github.com/danwald/peon-ping) for audio notifications.
- See the [main setup README](../README.md) for the full dev environment.
