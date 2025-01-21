vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO facebook/react-native
    REF v0.74.2
    SHA512 3ced28660a4225b4c670e7646baa0ca51b3f9edd4daa48a30272745b7581ae1b29183e4109fa750c3399002ab52b58f3f609fb1ce2d832d151e19de9366aa077
    HEAD_REF main
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}/packages/react-native/ReactCommon/jsi")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}/packages/react-native/ReactCommon/jsi")
vcpkg_cmake_install()
vcpkg_cmake_config_fixup()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
