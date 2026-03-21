---
name: github-pr-review
description: How to review GitHub pull requests using the gh CLI
---

# GitHub Pull Request Review Skill

This skill teaches Claude how to properly interact with the GitHub CLI (`gh`) when reviewing pull requests.

## Prerequisites

Before reviewing a PR, always verify `gh` is installed and authenticated:

```bash
gh auth status
```

If this fails or shows unauthenticated, inform the user:

> You need to have the GitHub CLI (`gh`) installed and authenticated.
>
> To install: `brew install gh`
> To authenticate: `gh auth login`

Do not proceed until authentication is confirmed.

## Fetching PR Information

### Get PR details

```bash
gh pr view <PR_NUMBER_OR_URL> --json number,title,body,author,baseRefName,headRefName,files
```

This returns structured JSON with:
- `number`: PR number
- `title`: PR title
- `body`: PR description
- `author`: Who opened the PR
- `baseRefName`: Target branch (e.g., `main`)
- `headRefName`: Source branch
- `files`: List of changed files

### Get the diff

```bash
gh pr diff <PR_NUMBER_OR_URL>
```

This shows the actual code changes. Use this to understand what was modified.

### Get existing comments

```bash
gh api repos/{owner}/{repo}/pulls/{pull_number}/comments
```

### Get PR checks status

```bash
gh pr checks <PR_NUMBER_OR_URL>
```

## Submitting Reviews

### Submit a review with inline comments (recommended)

Use the GitHub API to submit a cohesive review with both a summary and inline comments in one atomic operation:

```bash
gh api repos/{owner}/{repo}/pulls/{pull_number}/reviews \
  --method POST \
  --input - << 'EOF'
{
  "event": "COMMENT",
  "body": "## Review Summary\n\n[Your overall assessment here]",
  "comments": [
    {
      "path": "path/to/file.go",
      "line": 42,
      "body": "[Your comment about this line]"
    },
    {
      "path": "path/to/another.go",
      "line": 15,
      "body": "[Another comment]"
    }
  ]
}
EOF
```

### Review event types

- `"COMMENT"` - General feedback, no approval or rejection
- `"APPROVE"` - You must *never* approve a PR, only humans should do this
- `"REQUEST_CHANGES"` - Request changes before merging (cannot use on your own PR)

### Inline comment parameters

Each comment object requires:
- `path`: Relative path from repository root
- `line`: Line number that appears in the diff (integer)
- `body`: The comment text

For multi-line comments, add `start_line`:
```json
{
  "path": "src/handler.go",
  "start_line": 40,
  "line": 45,
  "body": "This entire block needs attention..."
}
```

### Important constraints

1. The `line` must reference a line that appears in the PR diff, not just any line in the file
2. If there are no inline comments, use an empty array: `"comments": []`
3. You cannot request changes on your own PR
4. You must not approve any PRs, only humans should do this
5. The response includes `html_url` - share this with the user so they can view the review

### Simple review without inline comments

For a quick simple comment:

```bash
gh pr review <PR_NUMBER_OR_URL> --comment --body "Some feedback here"
gh pr review <PR_NUMBER_OR_URL> --request-changes --body "Please fix X"
```

## Adding Individual Comments

To add a single comment to a specific line (outside of a formal review):

```bash
gh api repos/{owner}/{repo}/pulls/{pull_number}/comments \
  --method POST \
  -f body="Your comment" \
  -f path="path/to/file.go" \
  -f commit_id="<commit_sha>" \
  -F line=42
```

Get the commit SHA from `gh pr view --json headRefOid`.

## Replying to Comments

To reply to an existing review comment:

```bash
gh api repos/{owner}/{repo}/pulls/{pull_number}/comments/{comment_id}/replies \
  --method POST \
  -f body="Your reply"
```

## Common Workflows

### Full review workflow

1. Check auth: `gh auth status`
2. Fetch PR info: `gh pr view <PR> --json number,title,body,author,baseRefName,headRefName,files`
3. Get the diff: `gh pr diff <PR>`
4. Get existing reviews to understand ongoing discussions: `gh api repos/{owner}/{repo}/pulls/{pull_number}/reviews`
5. Analyze the changes
6. **If running locally with a human in the loop**: Ask the user to confirm they're happy with the review BEFORE submitting it
7. Submit review with `gh api repos/{owner}/{repo}/pulls/{pull_number}/reviews`
8. Share the `html_url` from the response with the user

### Check if PR is mergeable

```bash
gh pr view <PR> --json mergeable,mergeStateStatus
```

## Extracting owner/repo from PR URL

If given a full URL like `https://github.com/owner/repo/pull/123`:
- `owner`: `owner`
- `repo`: `repo`
- `pull_number`: `123`

Or use `gh pr view <URL> --json number` to get the PR number directly.

## Error Handling

Common issues:
- **"Resource not accessible"**: Check authentication with `gh auth status`
- **"Validation Failed" on line number**: The line must appear in the diff
- **"Cannot request changes on own PR"**: Use `COMMENT` instead of `REQUEST_CHANGES`

Always check the response from API calls and report any errors to the user.
