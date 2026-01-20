---
name: orchestration
description: This skill should be used when orchestrating complex tasks, decomposing work into atomic units, dispatching to subagents, verifying outputs, or when discussing task verification and deviation tracking patterns.
version: 1.0.0
---

# Orchestration Protocol

This skill provides procedural knowledge for observable subagent orchestration.

## Core Principles

1. **You are the only decision-maker.** Subagents execute; they do not judge, interpret ambiguity, or make policy choices.

2. **Atomic tasks only.** Each subagent receives ONE well-defined task with explicit success criteria.

3. **Structured contracts.** Every dispatch includes:
   - Exact input
   - Expected output schema
   - Explicit constraints
   - Required evidence for claims

4. **Full observability.** Log and review every input/output. No hidden reasoning.

5. **Verification is separate from execution.** Parse and validate all subagent responses.

## Task Decomposition

When given a complex task:

1. Identify atomic units that can be executed independently
2. Determine dependencies between units
3. Sequence units respecting dependencies
4. For each unit, define:
   - Clear objective (single verb phrase)
   - Input data required
   - Expected output format
   - Success criteria

## Dispatch Pattern

For each atomic task, dispatch to the `executor` subagent:

```
Task: [Single atomic instruction]

Input:
[Structured data the executor needs]

Success Criteria:
- [Criterion 1]
- [Criterion 2]
```

## Response Verification

After each executor response, verify:

| Check | Pass Condition |
|-------|----------------|
| Schema compliance | All required YAML fields present |
| Understanding match | `understood` semantically matches intended task |
| Confidence threshold | `confidence >= 0.7` or flag for review |
| Evidence support | `evidence` logically supports `output` |
| No blockers | `blockers` is null or acceptable |

## Verification Actions

```
IF schema_invalid:
  → Log deviation: "schema_violation"
  → Retry with explicit schema reminder

IF understood != intended:
  → Log deviation: "misinterpretation"
  → Refine task description
  → Retry

IF confidence < 0.7:
  → Flag for manual review
  → OR dispatch verification subagent

IF evidence_weak:
  → Log deviation: "unsupported_claim"
  → Request additional evidence
  → OR reject output

IF blockers != null:
  → Analyze blocker
  → Create new task to resolve
  → OR escalate to user
```

---

## Understanding Verification Protocol

After receiving executor response, explicitly compare `understood` to the original task:

```
┌─────────────────────────────────────────────────────────┐
│ UNDERSTANDING VERIFICATION                               │
├─────────────────────────────────────────────────────────┤
│ INTENDED: [original task as given to executor]          │
│ UNDERSTOOD: [executor's 'understood' field]             │
├─────────────────────────────────────────────────────────┤
│ Compare semantically:                                    │
│                                                          │
│ ☐ Does UNDERSTOOD capture all requirements of INTENDED? │
│ ☐ Does UNDERSTOOD add anything not in INTENDED?         │
│ ☐ Does UNDERSTOOD miss anything from INTENDED?          │
│ ☐ Does UNDERSTOOD change the scope of INTENDED?         │
└─────────────────────────────────────────────────────────┘
```

### Mismatch Actions

```
IF UNDERSTOOD adds scope:
  → Log deviation: "scope_expansion"
  → Assess if expansion is helpful or harmful
  → If harmful: Refine task with explicit boundaries, retry

IF UNDERSTOOD misses requirements:
  → Log deviation: "incomplete_understanding"
  → Refine task with explicit requirements
  → Retry

IF UNDERSTOOD changes meaning:
  → Log deviation: "misinterpretation"
  → Analyze why misinterpretation occurred
  → Refine task wording to prevent recurrence
  → Retry

IF UNDERSTOOD matches INTENDED:
  → Proceed to verify output
```

### Example Comparison

```
INTENDED: "Find current Python version from python.org"

UNDERSTOOD (GOOD): "Find and report the current stable Python version from python.org"
→ Match: Captures intent accurately

UNDERSTOOD (BAD): "Find all Python versions ever released"
→ Mismatch: Scope expansion, retry needed

UNDERSTOOD (BAD): "Find Python version"
→ Mismatch: Missing "from python.org" requirement
```

---

## Confidence Threshold Protocol

Explicit escalation paths based on executor confidence levels:

```
┌─────────────────────────────────────────────────────────┐
│ CONFIDENCE THRESHOLD PROTOCOL                            │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  confidence < 0.5                                        │
│  ──────────────────                                      │
│  Action: REJECT                                          │
│  1. Reject output                                        │
│  2. Request executor explain uncertainty                 │
│  3. Refine task or provide additional context           │
│  4. Retry with improved contract                         │
│                                                          │
│  confidence >= 0.5 AND < 0.7                            │
│  ────────────────────────────                            │
│  Action: FLAG                                            │
│  1. Flag for verification                                │
│  2. Options:                                             │
│     a) Dispatch verification subagent                    │
│     b) Present to user with warning:                     │
│        "Executor uncertain - verify manually"            │
│     c) Cross-check with independent source               │
│                                                          │
│  confidence >= 0.7                                       │
│  ──────────────────                                      │
│  Action: ACCEPT (subject to other checks)               │
│  1. Proceed with understanding verification              │
│  2. Proceed with evidence verification                   │
│  3. If all pass → accept output                          │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### Confidence Deviation Log

```yaml
- id: [auto]
  timestamp: [now]
  confidence_reported: 0.4
  threshold: 0.7
  action_taken: REJECT
  reason: |
    Executor reported low confidence.
    Task may be ambiguous or require information not available.
  fix: |
    Refine task with more specific requirements.
    Provide additional context or constraints.
```

---

## Deviation Logging

When verification fails, log:

```yaml
deviation:
  id: [auto-increment]
  timestamp: [ISO 8601]
  task_id: [reference]
  expected: [what should have happened]
  actual: [what did happen]
  root_cause: [misinterpretation | schema_violation | unsupported_claim | blocked | low_confidence]
  fix: |
    [Exact change to prompt/task/schema to prevent recurrence]
```

Location: `.claude/plugins/nexus-orchestrator/deviations/log.yaml`

## Closed Loop

Every deviation teaches:
1. Log the deviation
2. Apply the fix to the prompt/schema
3. Retry if appropriate
4. Monitor for recurrence

Over time, prompts become more robust and failure modes decrease.

---

## Skill Chain

This skill connects to other skills in the nexus-orchestrator framework:

| Trigger | Invoke |
|---------|--------|
| Before any completion claim | → `verification` skill |
| Multiple independent tasks | → `parallel-dispatch` skill |
| 3+ failed fix attempts | → `systematic-debugging` skill |
| Creating implementation plan | → `writing-plans` skill |
| Writing code | → `tdd` skill |
| All tasks complete | → `finishing` skill |
| Code needs review | → `reviewer` agent |

### Chaining Rules

1. **ALWAYS** invoke `verification` before reporting success
2. **CHECK** `parallel-dispatch` decision framework before multi-task dispatch
3. **IF** fix_attempts >= 3 **THEN** STOP and invoke `systematic-debugging`
4. **IF** writing code **THEN** invoke `tdd` skill
5. **AFTER** all tasks complete **THEN** invoke `finishing` skill

---

## Batch Execution Protocol

For tasks with many atomic units, execute in batches with checkpoints:

```
BATCH_SIZE = 3 (configurable)

for each batch of BATCH_SIZE tasks:
  1. Execute batch (dispatch to executor)
  2. Verify all outputs
  3. Report results to user
  4. **PAUSE** - Wait for user feedback
  5. If feedback.abort → stop execution
  6. If feedback.continue → proceed to next batch
```

> [!CRITICAL]
> DO NOT proceed past batch boundary without user acknowledgment.

### Batch Report Format

```
Batch N/M complete.

Tasks completed:
- [Task 1]: [status]
- [Task 2]: [status]
- [Task 3]: [status]

Remaining: [count] tasks

Continue? [yes/no/abort]
```

### Why Batch Execution

| Benefit | Explanation |
|---------|-------------|
| Observability | User sees progress incrementally |
| Control | User can abort if going wrong direction |
| Feedback | User can provide corrections mid-execution |
| Recovery | Smaller blast radius if something fails |

## Example Orchestration

User request: "Find current Python version and its release date"

**Decomposition:**
- Task 1: Find current stable Python version
- Task 2: Find release date of that version

**Dispatch Task 1:**
```
Task: Find the current stable Python MAJOR version (e.g., 3.14, not patch versions)

Input: None required

Success Criteria:
- Single version number returned
- From official source (python.org)
- Confidence >= 0.8
```

**Verify Task 1 response:**
- Schema: Valid YAML with all fields
- Understanding: Matches "current stable major version"
- Confidence: Check >= 0.7
- Evidence: Contains python.org reference

**If pass → Dispatch Task 2 with version from Task 1**

**Aggregate and report to user.**
