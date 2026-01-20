#!/usr/bin/env bash
# Initialize Nexus Orchestrator context on session start
# Injects core priming directive, skill reminder, and CLAUDE.md protocol reference

cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "## Nexus Orchestrator Active\n\n**Core Directive:**\n> Think first. Act deliberately. Verify everything.\n\n**Operating Principles:**\n1. If you don't know, don't guess - investigate\n2. If you haven't verified, don't claim done\n3. If you've tried 3 times, stop and question architecture\n4. If a skill applies, you MUST invoke it\n\n---\n\n**Available Skills:**\n- `orchestration` - Task decomposition and subagent dispatch\n- `verification` - 5-step evidence-before-claims protocol\n- `parallel-dispatch` - Concurrency decision framework\n- `writing-plans` - Structured plan format\n- `finishing` - Completion workflow with options\n- `systematic-debugging` - 4-phase debugging methodology\n- `tdd` - Test-driven development cycle\n\n**Available Agents:**\n- `executor` - Atomic task execution with YAML schema\n- `reviewer` - Two-stage review (spec then quality)\n\n> [!CRITICAL]\n> IF A SKILL APPLIES TO YOUR TASK, YOU MUST INVOKE IT BEFORE ACTING.\n>\n> Key triggers:\n> - About to claim \"done\"? → `verification` skill\n> - Multiple independent tasks? → `parallel-dispatch` skill\n> - 3+ failed fixes? → `systematic-debugging` skill\n> - Writing code? → `tdd` skill\n> - Creating a plan? → `writing-plans` skill\n> - All tasks complete? → `finishing` skill"
  }
}
EOF

exit 0
