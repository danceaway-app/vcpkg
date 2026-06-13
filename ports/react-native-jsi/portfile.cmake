vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO facebook/react-native
    REF v0.86.0
    SHA512 f8ae78b05b94e9c641e011724e908fab1d1c13cf915fefb09a9209fd0d482e9ea02ad2f1cba120da8c0dfad86720f1fc61ba1a684cc18789138f1b844c4b9103
    HEAD_REF main
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}/packages/react-native/ReactCommon/jsi")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}/packages/react-native/ReactCommon/jsi")
vcpkg_cmake_install()
vcpkg_cmake_config_fixup()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
