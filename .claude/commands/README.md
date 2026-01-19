# Claude Commands

This directory contains custom slash commands for Claude Code.

## How Commands Work

Commands are markdown files that define reusable workflows. When you type `/command-name` in Claude Code, it executes the instructions in the corresponding file.

## File Naming

The filename (without `.md`) becomes the command name:
- `update-port.md` → `/update-port`
- `add-baseline.md` → `/add-baseline`
- `test-build.md` → `/test-build`

## Command Format

Commands are markdown files with optional YAML frontmatter:

```markdown
---
model: sonnet
description: Update a port to a new version
---

# Update Port Command

1. Update REF and version-string
2. Set SHA512 to 0
3. Build in container
4. Get correct SHA512 from error
5. Rebuild and verify
```

## Frontmatter Options

| Field | Description |
|-------|-------------|
| `model` | Override model for this command: `haiku`, `sonnet`, or `opus` |
| `description` | Short description shown in command list |

## Examples

See `repo-command-example.md` in the agentic-feature-dev templates directory for a complete example.