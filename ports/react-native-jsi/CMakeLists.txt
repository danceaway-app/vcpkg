cmake_minimum_required(VERSION 3.30)

project(react-native-jsi CXX)

find_package(folly CONFIG REQUIRED)

add_compile_options(-fexceptions -frtti -O3 -Wno-unused-lambda-capture -DLOG_TAG=\"ReactNative\")

add_library(react-native-jsi INTERFACE)
target_sources(react-native-jsi
  INTERFACE FILE_SET react_native_jsi_HEADERS
  TYPE HEADERS
  FILES
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/jsi/decorator.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/jsi/instrumentation.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/jsi/JSIDynamic.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/jsi/jsi.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/jsi/jsi-inl.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/jsi/jsilib.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/jsi/threadsafe.h>
)
target_sources(react-native-jsi
  PRIVATE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/jsi/jsi.cpp>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/jsi/JSIDynamic.cpp>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/jsi/jsilib-posix.cpp>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/jsi/jsilib-windows.cpp>
)
target_link_libraries(react-native-jsi INTERFACE Folly::folly Folly::folly_deps)

install(
  TARGETS react-native-jsi
  EXPORT react-native-jsi-config
  FILE_SET react_native_jsi_HEADERS
)
install(EXPORT react-native-jsi-config DESTINATION share/react-native-jsi)
