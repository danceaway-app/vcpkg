cmake_minimum_required(VERSION 3.10)

project(sqlite3 C)

option(WITH_ZLIB "Build sqlite3 with zlib support" OFF)
option(SQLITE3_SKIP_TOOLS "Disable build sqlite3 executable" OFF)

add_library(sqlite3 sqlite3.c)

target_include_directories(
  sqlite3
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}> $<INSTALL_INTERFACE:include>
)

target_compile_definitions(
  sqlite3
  PRIVATE
    $<$<CONFIG:Debug>:SQLITE_DEBUG=1>
    $<$<CONFIG:Debug>:SQLITE_ENABLE_SELECTTRACE>
    $<$<CONFIG:Debug>:SQLITE_ENABLE_WHERETRACE>
    $<$<COMPILE_LANGUAGE:RC>:RC_VERONLY>
)

if (BUILD_SHARED_LIBS)
  target_compile_definitions(
    sqlite3
    PRIVATE
      "SQLITE_API=__attribute__((visibility(\"default\")))"
  )
endif()

include(CMakeFindDependencyMacro)
find_package(Threads REQUIRED)
target_link_libraries(sqlite3 PRIVATE Threads::Threads ${CMAKE_DL_LIBS})

if(SQLITE_ENABLE_FTS5 OR SQLITE_ENABLE_MATH_FUNCTIONS)
  find_library(HAVE_LIBM m)
  if(HAVE_LIBM)
    target_link_libraries(sqlite3 PRIVATE m)
  endif()
endif()

if(SQLITE_ENABLE_ICU)
  find_package(ICU COMPONENTS uc i18n REQUIRED)
  target_link_libraries(sqlite3 PRIVATE ICU::uc ICU::i18n)
endif()

install(
    TARGETS sqlite3
    EXPORT danceaway-sqlite3-targets
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

install(
  FILES
    sqlite3.h sqlite3ext.h
    sqlite3.c
  DESTINATION share/danceaway-sqlite3/amalgamantion
  CONFIGURATIONS Release
)
install(
  EXPORT danceaway-sqlite3-targets
  NAMESPACE danceaway::sqlite3::
  FILE danceaway-sqlite3-targets.cmake
  DESTINATION share/danceaway-sqlite3
)
