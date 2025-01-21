cmake_minimum_required(VERSION 3.30)

project(react-native-bridge CXX)

find_package(folly CONFIG REQUIRED)
find_package(react-native-callinvoker CONFIG REQUIRED)
find_package(react-native-jsi CONFIG REQUIRED)

add_compile_options(-fexceptions -frtti -std=c++20 -Wall -Wpedantic -DLOG_TAG=\"ReactNative\")

add_library(react-native-bridge INTERFACE)
target_sources(react-native-bridge
  INTERFACE FILE_SET react_native_bridge_HEADERS
  TYPE HEADERS
  FILES
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Array.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/AString.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Base.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Bool.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Bridging.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/CallbackWrapper.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Class.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Convert.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Dynamic.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Error.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Function.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/LongLivedObject.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Number.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Object.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Promise.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Value.h>
)
target_sources(react-native-bridge
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/LongLivedObject.cpp>
)
install(
  TARGETS react-native-bridge
  EXPORT react-native-bridge-config
  FILE_SET react_native_bridge_HEADERS DESTINATION include/react/bridging
)
install(EXPORT react-native-bridge-config DESTINATION share/react-native-bridge)
