# danceaway-vcpkg

> Custom vcpkg registry for DanceAway's C++ dependencies, specifically React Native JSI-related packages.

## Overview

A vcpkg ports registry providing custom-built versions of React Native dependencies for the DanceAway platform. Contains ports for JSI bindings, Hermes engine, and SQLite that are consumed by the `turbo-modules` repo.

## Architecture

### Source Layout

```
danceaway-vcpkg/
├── ports/                        # Custom vcpkg port definitions
│   ├── hermes/                   # Facebook Hermes JS engine
│   ├── react-native-bridge/      # RN bridge utilities
│   ├── react-native-callinvoker/ # Async call invoker
│   ├── react-native-jsi/         # JavaScript Interface bindings
│   └── sqlite3/                  # SQLite database
├── versions/                     # Version database
│   ├── baseline.json             # Latest versions for all ports
│   ├── h-/hermes.json
│   ├── r-/react-native-*.json
│   └── s-/sqlite3.json
├── .devcontainer/                # Build containers
│   ├── clang/                    # Clang toolchain
│   └── gnu/                      # GCC toolchain
└── devkit/                       # Development utilities
```

### Port Structure

Each port in `ports/<name>/` contains:
- `portfile.cmake` - Download and patch instructions (REF, SHA512)
- `vcpkg.json` - Package metadata and dependencies
- `CMakeLists.txt` - Build instructions (if needed)
- `*.patch` - Source patches (if needed)

## Build & Test

**All builds run in devcontainers.** Do not attempt local vcpkg builds.

### Container Setup

```bash
# Clang toolchain
devcontainer up --config=.devcontainer/clang/devcontainer.json \
  --remove-existing-container --id-label=label=vcpkg-clang --workspace-folder .

# GCC toolchain
devcontainer up --config=.devcontainer/gnu/devcontainer.json \
  --remove-existing-container --id-label=label=vcpkg-gcc --workspace-folder .
```

### Build Commands (inside container)

```bash
# Install a port (test build)
devcontainer exec --id-label=label=vcpkg-clang --workspace-folder . \
  vcpkg install --debug --clean-buildtrees-after-build --no-print-usage \
  --overlay-ports=./ports/ <portname>

# Clean build state
devcontainer exec --id-label=label=vcpkg-clang --workspace-folder . \
  vcpkg x-ci-clean

# Remove installed port
devcontainer exec --id-label=label=vcpkg-clang --workspace-folder . \
  vcpkg remove <portname>

# Add version to baseline (after committing port changes)
devcontainer exec --id-label=label=vcpkg-clang --workspace-folder . \
  vcpkg x-add-version --x-builtin-ports-root=./ports \
  --x-builtin-registry-versions-dir=./versions --all --verbose
```

## Conventions

### Version Update Workflow

1. Modify `ports/<name>/portfile.cmake`: set `REF` to new tag, `SHA512` to `0`
2. Modify `ports/<name>/vcpkg.json`: set `version-string` to new tag
3. Build in container - SHA512 error will print correct hash
4. Update `SHA512` in portfile with correct hash
5. Rebuild until successful
6. Commit port changes: `[<portname>] X.Y.Z port files`
7. Run `vcpkg x-add-version` to update baseline
8. Commit version changes: `[<portname>] X.Y.Z add to baseline`

### Commit Messages

- Port file changes: `[react-native-jsi] 0.76.6 port files`
- Baseline updates: `[react-native-jsi] 0.76.6 add to baseline`

### File Naming

- Version files: `versions/<first-letter>-/<name>.json`
- Example: `versions/r-/react-native-jsi.json`

## Gotchas

- **SHA512 workflow**: Set to `0` first, get correct hash from error output, then update
- **Devcontainer required**: Never build locally - always use the vcpkg containers
- **Commit before x-add-version**: Port changes must be committed before running the version command
- **git-tree hash**: Obtained via `git rev-parse HEAD:ports/<name>` after committing
- **baseline.json**: Always points to latest version in registry

## Task-Model Mapping

| Task Type | Model | Rationale |
|-----------|-------|-----------|
| Reading port files, understanding structure | haiku | Fast exploration |
| Updating port versions | sonnet | Methodical multi-step process |
| Debugging build failures | opus | Complex C++ and CMake issues |
| Adding new ports | opus | Architecture decisions |

## Subagent Guidance

- **Explore agent** (haiku): Finding port files, understanding dependencies
- **Plan agent**: Before adding new ports or major updates
- **Bash agent**: Running devcontainer commands (already permitted)

## Related Repos

| Repository | Relationship |
|------------|--------------|
| **turbo-modules** | Consumes these vcpkg ports for C++ native modules |
| **mobile-app** | Indirectly consumes via turbo-modules |