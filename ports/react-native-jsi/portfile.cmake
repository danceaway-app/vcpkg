vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO facebook/react-native
    REF v0.80.2
    SHA512 f599a8b25675af5e091be44bedaaf46beb852873edd8a21dd4a8d92473ca0e2284fabcd8bd6b5fdd65265324871001b7f97b64f7f09a8ad67124e99c3a80ba66
    HEAD_REF main
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}/packages/react-native/ReactCommon/jsi")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}/packages/react-native/ReactCommon/jsi")
vcpkg_cmake_install()
vcpkg_cmake_config_fixup()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
