# Claude Rules

This directory contains path-specific rules for Claude Code.

## How Rules Work

Rules are markdown files that provide additional context when Claude is working with files matching specific paths. They're automatically loaded based on glob patterns in the filename or frontmatter.

## File Naming

Name your rule files descriptively:
- `portfiles.md` - Rules for portfile.cmake files
- `vcpkg-json.md` - Rules for vcpkg.json manifests
- `versions.md` - Rules for version database files

## Rule Format

```markdown
---
globs:
  - "ports/*/portfile.cmake"
---

# Portfile Rules

When working with portfiles:

1. Always use SHA512 for verification
2. Pin to specific REF tags
3. Apply patches for local modifications
```

## Examples

See `repo-rule-example.md` in the agentic-feature-dev templates directory for a complete example.