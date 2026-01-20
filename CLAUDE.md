# Initialization Protocol v1.0

> This document is the master initialization protocol for all sessions.
> It is read automatically at every session start.

**Last Updated**: 2026-01-21

---

## Core Identity

**Operating Directive**: Think first. Act deliberately. Verify everything.

**Principles**:
1. Investigate before assuming
2. Verify before claiming done
3. Question architecture after 3 failures
4. Invoke applicable skills before acting

---

## Documentation Registry

### Always Read (Session Start)

| Document | Path | Purpose |
|----------|------|---------|
| This Protocol | `CLAUDE.md` | Master initialization |
| Quick Reference | `plugins/nexus-orchestrator/QUICK-REFERENCE.md` | Skill triggers & thresholds |

### Conditional Reading

| Trigger Condition | Document | Path |
|-------------------|----------|------|
| Quality assessment needed | Quality Framework | `docs/frameworks/quality-categories.md` |
| Unfamiliar codebase area | Context Gathering Skill | `plugins/nexus-orchestrator/skills/context-gathering/SKILL.md` |
| Creating implementation plan | Plan Writing Skill | `plugins/nexus-orchestrator/skills/writing-plans/SKILL.md` |
| About to claim completion | Verification Skill | `plugins/nexus-orchestrator/skills/verification/SKILL.md` |

### On-Demand References

Skills, agents, and detailed protocols are loaded when invoked - no need to pre-load.
The nexus-orchestrator plugin provides: orchestration, verification, tdd, writing-plans, finishing, parallel-dispatch, systematic-debugging, context-gathering, error-recovery, estimation skills.

---

## Idea Inbox

**Location**: `docs/inbox/ideas.md`

Dump new ideas, patterns, preferences, or decisions here. Process with `/process-inbox` command.

**Format**:
```markdown
## [YYYY-MM-DD] [Idea Title]

**Source**: [conversation | observation | external | user-request]
**Category**: [which existing framework category might this fit?]
**Raw Idea**: [the idea as captured]
**Status**: pending
```

---

## Self-Maintenance Protocol

### Curation Rules

- **Max 5** "always read" documents (to minimize context bloat)
- **Staleness**: Flag docs not referenced in 30 days for review
- **Duplication**: Before adding new knowledge, check for overlap
- **Evidence**: Each knowledge item must cite source/evidence

### Processing Protocol (via `/process-inbox`)

1. **Triage**: Is idea actionable? (YES → evaluate, NO → archive with reason)
2. **Evaluate**: Fits existing structure? New pattern needed?
3. **Integrate**: Add to relevant doc OR create new knowledge doc in `docs/knowledge/`
4. **Clean**: Remove from inbox, update `docs/changelog.md`

### Knowledge Locations

| Type | Location | Purpose |
|------|----------|---------|
| Quality Framework | `docs/frameworks/quality-categories.md` | 20-category assessment reference |
| Curated Knowledge | `docs/knowledge/*.md` | Integrated learnings |
| Dismissed Ideas | `docs/archive/dismissed-ideas.md` | Ideas rejected with reasoning |
| Change Log | `docs/changelog.md` | Integration history |

---

## Hook Integration

This protocol expects SessionStart hook to ensure CLAUDE.md is read.
The hook provides plugin-specific context (skills, agents) as `additionalContext`.

**Contract**:
- SessionStart hook outputs instruction to read this protocol
- This protocol defines what additional docs to read (registry above)
- Agent follows protocol before beginning task execution
