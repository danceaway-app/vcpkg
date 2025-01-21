vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO facebook/react-native
    REF v0.76.4
    SHA512 50ef8047111ec128f1e8c4aa9b37d79c0a2001230e2161de4b9a9f2833e031bc763c37268333ba5a192e37ce4be3be625f7b76d0f366160fe816ab193dcf5e0d
    HEAD_REF main
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}/packages/react-native/ReactCommon/jsi")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}/packages/react-native/ReactCommon/jsi")
vcpkg_cmake_install()
vcpkg_cmake_config_fixup()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
