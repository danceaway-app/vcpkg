cmake_minimum_required(VERSION 3.30)

project(react-native-callinvoker CXX)

add_compile_options(-fexceptions -frtti -std=c++20 -Wall -Wpedantic)

add_library(react-native-callinvoker INTERFACE)
target_sources(react-native-callinvoker
  INTERFACE FILE_SET react_native_callinvoker_HEADERS
  TYPE HEADERS
  FILES
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/ReactCommon/CallInvoker.h>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/ReactCommon/SchedulerPriority.h>
)

install(
  TARGETS react-native-callinvoker
  EXPORT react-native-callinvoker-config
  FILE_SET react_native_callinvoker_HEADERS
)
install(EXPORT react-native-callinvoker-config DESTINATION share/react-native-callinvoker)
