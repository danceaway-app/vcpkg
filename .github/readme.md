# vcpkg

[Package a public Github repo](https://learn.microsoft.com/en-gb/vcpkg/examples/packaging-github-repos)

## Init registry

- Create repo
- Create `ports` and `versions` directories
- Create `versions/baseline.json`

## Add / modify a package

- Add `ports/<name>/portfile.cmake` with a CMake instructions on how to obtain the sources
- Add `ports/<name>/vcpkg.json` with the package details and dependencies
- Add patches if required
- Add `ports/<name>/CMakeLists.txt` with build instructions
- Test the build with `vcpkg install <portname> --overlay-ports=./port/<name>`
- Commit port content
- Add `versions/<first-letter-of-name-and-minus>/<name>.json` with the desired version and point git-tree field to the commit of the port, using an output of `git rev-parse HEAD:ports/<name>`
- Add (if it's the first one added) or update package's version in `versions/baseline.json` (it always points to the latest within the registry)
- `vcpkg --x-builtin-ports-root=./ports --x-builtin-registry-versions-dir=./versions x-add-version --all --verbose` in the root directory

### Example

Imagine that we're at the moment of RN 0.76.6 release, while this registry points to the RN 0.76.5 as the latest. Our goal is to update `react-native-jsi` port to the latest version.

- Prerequisites: `vcpkg` binary or container (`ghcr.io/danceaway-app/vcpkg:latest`), `danceaway-app/vcpkg` repo cloned
- Modify `ports/react-native-jsi/portfile.cmake`: set `REF` to the new tag, 0.76.6; set `SHA512` to any value, like 0
- Modify `ports/react-native-jsi/vcpkg.json`: set `version-string` to the new tag, 0.76.6
- If any dependencies like folly are updated, change them accordingly
- Run `devcontainer up --workspace-folder .` once to setup build container (CLang and vcpkg environment)
- Run `devcontainer exec --workspace-folder . vcpkg install react-native-jsi --overlay-ports=./ports/react-native-jsi` to evaluate new version - could you build it. If there are any errors, review output and logs (recommended to attach to building container in a separate terminal and troubleshoot build issues
- There would be at least one error caused by the `SHA512` being set to 0 previously. In the output the correct hash is printed, use it to modify `portfile.cmake`'s `SHA512` (this is DA official WAY, btw)
- If needed, build state in the container could be reset with `devcontainer exec --workspace-folder . vcpkg x-ci-clean` (other commands are described by `vcpkg help commands`)
- Once the new version builds and installed, commit changes in the `port` directory. I suggest to form commit message as "[react-native-jsi] 0.76.6 port files"
- Run `git rev-parse HEAD:ports/react-native-jsi` to obtain commit hash
- Modify `versions/r-/react-native-jsi.json`: add new version object, use commit hash from previous step to fill `git-tree` field value
- Modify `versions/baseline.json`: change `baseline` version to the latest, 0.76.6 in this example
- Commit change in the `versions` directory. I suggest to form commit message as "[react-native-jsi] 0.76.6 add to baseline"
- Run `devcontainer exec --workspace-folder . vcpkg --x-builtin-ports-root=./ports --x-builtin-registry-versions-dir=./versions x-add-version --all --verbose`: if everything is done correctly, green output is printed. Otherwise, error in red would be present and (!) versions in baseline.json and react-native-jsi.json would be reverted
