set(AUTH_TOKEN "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")

execute_process(
  COMMAND sh "-c" "curl -fsSL -H 'Authorization: Bearer ${AUTH_TOKEN}' https://api.github.com/repos/danceaway-app/sqlite/releases/tags/${VERSION}"
  COMMAND sh "-c" "jq -r '.assets[].url'"
  OUTPUT_VARIABLE DOWNLOAD_URL
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

vcpkg_download_distfile(
  ARCHIVE
  URLS ${DOWNLOAD_URL}
  FILENAME "amalgamation.tar.gz"
  SHA512 8cc3af9d3bb1368c4ffb024972f160a04228aa3c56eb01af2cdd35ace5bec2e6f6b77c1dc9850234639248cc016962af0db5742c9063e4aa2ad7f367c4e528d7
  HEADERS
    "Authorization: Bearer ${AUTH_TOKEN}"
    "Accept: application/octet-stream"
)

vcpkg_extract_source_archive(
  SOURCE_PATH
  ARCHIVE "${ARCHIVE}"
  NO_REMOVE_ONE_LEVEL
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
  set(SQLITE_API "__attribute__((visibility(\"default\")))")
else()
  set(SQLITE_API "")
endif()

file(
  COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt"
  DESTINATION "${SOURCE_PATH}"
)

vcpkg_check_features(
  OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
    cfg-mem-mgmt                SQLITE_ENABLE_MEMORY_MANAGEMENT
    cfg-memsys5                 SQLITE_ENABLE_MEMSYS5
    ext-icu                     SQLITE_ENABLE_ICU
    ext-rtree                   SQLITE_ENABLE_RTREE
    ext-fts5                    SQLITE_ENABLE_FTS5
    ext-geopoly                 SQLITE_ENABLE_GEOPOLY
    feat-atomic-write           SQLITE_ENABLE_ATOMIC_WRITE
    feat-batch-atomic-write     SQLITE_ENABLE_BATCH_ATOMIC_WRITE
    feat-column-metadata        SQLITE_ENABLE_COLUMN_METADATA
    feat-vtab-bytecode          SQLITE_ENABLE_BYTECODE_VTAB
    feat-vtab-dbpage            SQLITE_ENABLE_DBPAGE_VTAB
    feat-vtab-dbstat            SQLITE_ENABLE_DBSTAT_VTAB
    feat-vtab-statement         SQLITE_ENABLE_STMTVTAB
    feat-math-funcs             SQLITE_ENABLE_MATH_FUNCTIONS
    fact-preupdate-hook         SQLITE_ENABLE_PREUPDATE_HOOK
    feat-session                SQLITE_ENABLE_SESSION
    feat-snapshot               SQLITE_ENABLE_SNAPSHOT
    feat-stat4                  SQLITE_ENABLE_STAT4
    feat-update-delete-limit    SQLITE_ENABLE_UPDATE_DELETE_LIMIT
    feat-like-dontmatch-blob    SQLITE_LIKE_DOESNT_MATCH_BLOBS
    feat-omit-deprecated        SQLITE_OMIT_DEPRECATED
    feat-omit-shared-cache      SQLITE_OMIT_SHARED_CACHE
)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    ${FEATURE_OPTIONS}
    SQLITE_PROFILE_DANCEAWAY
  OPTIONS_DEBUG
    SQLITE3_SKIP_TOOLS
  MAYBE_UNUSED_VARIABLES
    SQLITE3_SKIP_TOOLS
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME danceaway-${PORT})
# Original amalgamation .c file
file(
  INSTALL "${SOURCE_PATH}/sqlite3.c"
  DESTINATION ${CURRENT_PACKAGES_DIR}/src
)
# Construct copyright file
file(
  WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright"
  "SQLite is in the Public Domain.\nhttp://www.sqlite.org/copyright.html\n"
)
# Copy usage file
file(
  INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
)
# Remove duplicated files from debug configuration
file(
  REMOVE_RECURSE
  "${CURRENT_PACKAGES_DIR}/debug/include"
  "${CURRENT_PACKAGES_DIR}/debug/share"
)
