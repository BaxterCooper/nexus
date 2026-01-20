---
name: finishing
description: Use when all tasks are complete. Presents completion options and enforces test gate. Work is never left in limbo.
version: 1.0.0
---

# Finishing Skill

> **Core Principle**: Tests must pass before completion. Work is never abandoned without explicit choice.

## Pre-Completion Gate

> [!CRITICAL]
> TESTS MUST PASS before presenting options.

### Step 1: Run Full Test Suite

```bash
[project test command]
```

### Step 2: Check Results

| Result | Action |
|--------|--------|
| All pass | Proceed to options |
| Any fail | STOP - fix first |

**DO NOT present completion options with failing tests.**

---

## The Four Options

After tests pass, present EXACTLY these options:

```
Work complete. Tests passing. Choose:

1. Merge locally     - Merge to [base] and delete branch
2. Create PR         - Push and open pull request
3. Keep as-is        - No action, branch remains
4. Discard           - Delete all work (requires confirmation)
```

---

## Option Details

### Option 1: Merge Locally

```bash
git checkout [base-branch]
git merge [feature-branch]
git branch -d [feature-branch]
```

Result: Work merged, feature branch deleted

### Option 2: Create Pull Request

```bash
git push -u origin [feature-branch]
gh pr create --title "[title]" --body "[body]"
```

Result: PR created, branch preserved for review

### Option 3: Keep As-Is

No commands executed.

Result: Branch remains for future work

### Option 4: Discard

**Requires typed confirmation: "discard"**

Only after confirmation:
```bash
git checkout [base-branch]
git branch -D [feature-branch]
```

Result: All work deleted

---

## Rules

| Rule | Why |
|------|-----|
| Never add explanations | Keep options scannable |
| Never default to an option | User must explicitly choose |
| Never proceed without choice | Prevents abandoned work |
| Discard requires confirmation | Prevents accidental loss |

---

## Option Presentation Format

```
┌─────────────────────────────────────────────┐
│ All tasks complete. Tests passing.          │
├─────────────────────────────────────────────┤
│ 1. Merge locally   - Merge to main, cleanup │
│ 2. Create PR       - Push and open PR       │
│ 3. Keep as-is      - Branch remains         │
│ 4. Discard         - Delete work (confirm)  │
└─────────────────────────────────────────────┘

Choose [1-4]:
```

---

## Deviation Logging

Work abandoned without finishing workflow:

```yaml
- id: [auto]
  timestamp: [now]
  expected: "Finishing skill invoked after task completion"
  actual: "Session ended without completion choice"
  root_cause: incomplete_workflow
  fix: |
    Always invoke finishing skill after all tasks complete.
    Add reminder to orchestration skill chain.
```

---

## Integration with Orchestration

This skill is the final step in the workflow chain:

```
orchestration → executor → verification → reviewer → finishing
```

The `orchestration` skill should invoke `finishing` when:
- All tasks marked complete
- All verifications passed
- All reviews approved

---

## Worktree Cleanup

If using git worktrees:

| Option | Worktree Action |
|--------|-----------------|
| 1. Merge | Remove worktree |
| 2. PR | Keep worktree |
| 3. Keep | Keep worktree |
| 4. Discard | Remove worktree |

```bash
# Remove worktree
git worktree remove [path]
```
