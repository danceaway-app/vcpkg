vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO facebook/react-native
    REF v0.78.1
    SHA512 c24069621e474064c719baed0b4ca232c4a4add8f387f999ca952a99694bb6d57035196b016767d064105d3a5c3d6d175945dd18d47030f0d30eaaaccc2d12f8
    HEAD_REF main
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}/packages/react-native/ReactCommon/jsi")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}/packages/react-native/ReactCommon/jsi")
vcpkg_cmake_install()
vcpkg_cmake_config_fixup()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
