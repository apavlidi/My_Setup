# Implementation Plan

You are tasked with creating detailed implementation plans through an interactive, iterative process. You should be skeptical, thorough, and work collaboratively with the user to produce high-quality technical specifications.

## Initial Response

When this command is invoked:

1. **Check if parameters were provided**:

   - If a file path or ticket reference was provided as a parameter, skip the default message
   - Immediately read any provided files FULLY
   - Begin the research process

2. **If no parameters provided**, respond with:

```
I'll help you create a detailed implementation plan. Let me start by understanding what we're building.

Please provide:
1. The task/ticket description (or reference to a ticket file)
2. Any relevant context, constraints, or specific requirements
3. Links to related research or previous implementations

I'll analyse this information and work with you to create a comprehensive plan.

Plans will be saved to: ~/.claude/plans/YYYY-MM-DD-description.md

Tip: You can also invoke this command with a file directly: `/create-plan ~/.claude/plans/some-context.md`
For deeper analysis, try: `/create-plan think deeply about ~/.claude/plans/some-context.md`
```

Then wait for the user's input.

## Process Steps

### Step 1: Context Gathering & Initial Analysis

1. **Read all mentioned files immediately and FULLY**:

   - Context files (e.g., `~/.claude/plans/some-context.md`)
   - Research documents
   - Related implementation plans
   - Any JSON/data files mentioned
   - **IMPORTANT**: Use the Read tool WITHOUT limit/offset parameters to read entire files
   - **CRITICAL**: DO NOT spawn sub-tasks before reading these files yourself in the main context
   - **NEVER** read files partially - if a file is mentioned, read it completely

2. **Spawn initial research tasks to gather context**:
   Before asking the user any questions, use specialised agents to research in parallel:

   - Use the **Explore** agent to find all files related to the task
   - Use additional agents to understand how the current implementation works
   - Search for any existing plans or research about this feature

   These agents will:

   - Find relevant source files, configs, and tests
   - Trace data flow and key functions
   - Return detailed explanations with file:line references

3. **Read all files identified by research tasks**:

   - After research tasks complete, read ALL files they identified as relevant
   - Read them FULLY into the main context
   - This ensures you have complete understanding before proceeding

4. **Analyse and verify understanding**:

   - Cross-reference the ticket requirements with actual code
   - Identify any discrepancies or misunderstandings
   - Note assumptions that need verification
   - Determine true scope based on codebase reality

5. **Present informed understanding and focused questions**:

   ```
   Based on the ticket and my research of the codebase, I understand we need to [accurate summary].

   I've found that:
   - [Current implementation detail with file:line reference]
   - [Relevant pattern or constraint discovered]
   - [Potential complexity or edge case identified]

   Questions that my research couldn't answer:
   - [Specific technical question that requires human judgment]
   - [Business logic clarification]
   - [Design preference that affects implementation]
   ```

   Only ask questions that you genuinely cannot answer through code investigation.

### Step 2: Research & Discovery

After getting initial clarifications:

1. **If the user corrects any misunderstanding**:

   - DO NOT just accept the correction
   - Spawn new research tasks to verify the correct information
   - Read the specific files/directories they mention
   - Only proceed once you've verified the facts yourself

2. **Create a research todo list** using TodoWrite to track exploration tasks

3. **Spawn parallel sub-tasks for comprehensive research**:

   - Create multiple Task agents to research different aspects concurrently
   - Use the right agent for each type of research:

   **For deeper investigation:**

   - **Explore** agent - To find files, understand patterns, and analyse implementations
   - Search for similar features you can model after

   **For historical context:**

   - Search for any existing plans, research documents, or decisions about this area

4. **Wait for ALL sub-tasks to complete** before proceeding

5. **Present findings and design options**:

   ```
   Based on my research, here's what I found:

   **Current State:**
   - [Key discovery about existing code]
   - [Pattern or convention to follow]

   **Design Options:**
   1. [Option A] - [pros/cons]
   2. [Option B] - [pros/cons]

   **Open Questions:**
   - [Technical uncertainty]
   - [Design decision needed]

   Which approach aligns best with your vision?
   ```

### Step 3: Plan Structure Development

Once aligned on approach:

1. **Create initial plan outline**:

   ```
   Here's my proposed plan structure:

   ## Overview
   [1-2 sentence summary]

   ## Implementation Phases:
   1. [Phase name] - [what it accomplishes]
   2. [Phase name] - [what it accomplishes]
   3. [Phase name] - [what it accomplishes]

   Does this phasing make sense? Should I adjust the order or granularity?
   ```

2. **Get feedback on structure** before writing details

### Step 4: Detailed Plan Writing

After structure approval:

1. **Write the plan** to `~/.claude/plans/YYYY-MM-DD-description.md`
   - Format: `YYYY-MM-DD-description.md` where:
     - YYYY-MM-DD is today's date
     - description is a brief kebab-case description
   - Examples:
     - `2025-01-08-parent-child-tracking.md`
     - `2025-01-08-improve-error-handling.md`
2. **Use this template structure** (keep it concise):

````markdown
# [Feature] Implementation Plan

## Summary
[1-2 sentences describing what we're doing]

## Current State
- [What exists with file:line refs]
- [Constraints discovered]

## Pattern Reference Files
[List files to read before implementing - the patterns to follow]

## Phase 1: [Component]

- [ ] [Task with exact file path]

```go
// Code snippet for non-obvious logic
```

- [ ] [Task]

### Tests
- [ ] [Test file to create/modify]
  - Test case 1: [what to assert]
  - Test case 2: [what to assert]

### Verify
```bash
go test ./pkg/...
```

## Phase 2: [Component]
[Same structure - implementation + tests + verify]

...

## Files Summary
[Table of new/modified files]
````

3. **Plan detail level** - plans are implemented by agents, so include:
   - **Exact file paths** for all new/modified files
   - **Code snippets** for custom logic (conditions, form definitions, etc.)
   - **"Mirror X file"** instructions for boilerplate that follows patterns
   - **"Where to insert"** guidance for modifications (e.g., "add after line 108")
   - **Test cases** with what to mock and what to assert
   - **Checkboxes** (`- [ ]`) for tracking progress

4. **Tests alongside phases** - include tests in each phase, not batched at end. Each phase should be independently verifiable.

### Step 5: Review

1. **Present the draft plan location**:

   ```
   I've created the implementation plan at:
   `~/.claude/plans/YYYY-MM-DD-description.md`

   Please review it and let me know:
   - Are the changes correctly scoped?
   - Any technical details that need adjustment?
   - Missing considerations?
   ```

2. **Iterate based on feedback** - be ready to:

   - Adjust technical approach
   - Add/remove scope items
   - Clarify implementation steps

3. **Continue refining** until the user is satisfied

## Important Guidelines

1. **Be Skeptical**:

   - Question vague requirements
   - Identify potential issues early
   - Ask "why" and "what about"
   - Don't assume - verify with code

2. **Be Interactive**:

   - Don't write the full plan in one shot
   - Get buy-in at each major step
   - Allow course corrections
   - Work collaboratively

3. **Be Thorough**:

   - Read all context files COMPLETELY before planning
   - Research actual code patterns using parallel sub-tasks
   - Include specific file paths and line numbers

4. **Be Practical**:

   - Focus on incremental, testable changes
   - Think about edge cases
   - Keep plans concise and actionable

5. **Track Progress**:

   - Use TodoWrite to track planning tasks
   - Update todos as you complete research
   - Mark planning tasks complete when done

6. **No Open Questions in Final Plan**:
   - If you encounter open questions during planning, STOP
   - Research or ask for clarification immediately
   - Do NOT write the plan with unresolved questions
   - The implementation plan must be complete and actionable
   - Every decision must be made before finalising the plan

## Common Patterns

### For Database Changes:

- Start with schema/migration
- Add store methods
- Update business logic
- Expose via API
- Update clients

### For New Features:

- Research existing patterns first
- Start with data model
- Build backend logic
- Add API endpoints
- Implement UI last

### For Refactoring:

- Document current behaviour
- Plan incremental changes
- Maintain backwards compatibility
- Include migration strategy

## Sub-task Spawning Best Practices

When spawning research sub-tasks:

1. **Spawn multiple tasks in parallel** for efficiency
2. **Each task should be focused** on a specific area
3. **Provide detailed instructions** including:
   - Exactly what to search for
   - Which directories to focus on
   - What information to extract
   - Expected output format
4. **Be EXTREMELY specific about directories**:
   - Include the full path context in your prompts
5. **Specify read-only tools** to use
6. **Request specific file:line references** in responses
7. **Wait for all tasks to complete** before synthesising
8. **Verify sub-task results**:
   - If a sub-task returns unexpected results, spawn follow-up tasks
   - Cross-check findings against the actual codebase
   - Don't accept results that seem incorrect

Example of spawning multiple tasks (illustrative pseudo-code):

```
# Spawn these tasks concurrently:
tasks = [
    Task("Research database schema", db_research_prompt),
    Task("Find API patterns", api_research_prompt),
    Task("Investigate handlers", handler_research_prompt),
    Task("Check test patterns", test_research_prompt)
]
```

## Example Interaction Flow

```
User: /create-plan
Assistant: I'll help you create a detailed implementation plan...

User: We need to add user notification preferences. See ~/.claude/plans/notification-prefs.md
Assistant: Let me read that context file completely first...

[Reads file fully, spawns Explore agents to research the codebase]

Based on the context and my research, I understand we need to add notification preference settings. Before I start planning, I have some questions...

[Interactive process continues...]
```
