set(SQLITEVEC_GIT_HASH "a2dd24f27ec7e4a5743e58f5ab6835deea5db58d")

vcpkg_from_github(
    OUT_SOURCE_PATH SQLITE_SOURCE_PATH
    REPO sqlite/sqlite
    REF version-3.51.1
    SHA512 537ee149e0e142157301a8e3905d24a0438b8f52d0b556ee664cb43ed226a3183fdfff8d071c8bd393c9fce146f5e92549b680647a8c31e5e8475813f5952db8
    HEAD_REF main
    PATCHES
      patches/mksqlite3h.tcl.patch
      patches/spellfix.c.patch
)

file(
  COPY "${CMAKE_CURRENT_LIST_DIR}/extra/spellfix.h"
  DESTINATION "${SQLITE_SOURCE_PATH}/ext/misc/"
)

vcpkg_from_github(
    OUT_SOURCE_PATH SQLITEVEC_SOURCE_PATH
    REPO asg017/sqlite-vec
    REF ${SQLITEVEC_GIT_HASH}
    SHA512 1adcc6d90a7c4efddb3eac5512762b4c4bf621305d826c3dc38f273d96160aa42642875b4aa471c0c39671848c69cd26cafd7723e5b83b2cbfe526097d3621a1
    HEAD_REF main
    PATCHES
      patches/sqlite-vec.c.patch
)

vcpkg_execute_build_process(
  COMMAND sh -c " VERSION=$(cat VERSION) \
    DATE=$(date -r VERSION +'%FT%TZ%z') \
    SOURCE=${SQLITEVEC_GIT_HASH} \
    VERSION_MAJOR=$(echo $VERSION | cut -d. -f1) \
    VERSION_MINOR=$(echo $VERSION | cut -d. -f2) \
    VERSION_PATCH=$(echo $VERSION | cut -d. -f3 | cut -d- -f1) \
    envsubst < sqlite-vec.h.tmpl > sqlite-vec.h"
  WORKING_DIRECTORY ${SQLITEVEC_SOURCE_PATH}
  LOGNAME sqlite-vec
)

vcpkg_execute_build_process(
  COMMAND sh -c "sed -i '/#ifndef SQLITE_CORE.*/,/#endif/d' sqlite-vec.h"
  WORKING_DIRECTORY ${SQLITEVEC_SOURCE_PATH}
  LOGNAME sqlite-vec
)

file(
  COPY
    "${SQLITEVEC_SOURCE_PATH}/sqlite-vec.h"
    "${SQLITEVEC_SOURCE_PATH}/sqlite-vec.c"
  DESTINATION "${SQLITE_SOURCE_PATH}/ext/misc/"
)

vcpkg_make_configure(
    SOURCE_PATH "${SQLITE_SOURCE_PATH}"
    DISABLE_DEFAULT_OPTIONS
    OPTIONS
      --disable-tcl
      --memsys5
      --rtree
      --fts5
      --geopoly
      --session
      --update-limit
      --amalgamation-extra-src=${SQLITE_SOURCE_PATH}/ext/misc/spellfix.c
      --amalgamation-extra-src=${SQLITE_SOURCE_PATH}/ext/misc/sqlite-vec.c
    OPTIONS_RELEASE
      --bindir=${prefix}/tools/${PORT}/bin
      --sbindir=${prefix}/tools/${PORT}/sbin
      --libdir=${prefix}/lib
      --includedir=${prefix}/include
      --mandir=${prefix}/share/${PORT}
    OPTIONS_DEBUG
      --debug
      --bindir=${prefix}/debug/tools/${PORT}/bin
      --sbindir=${prefix}/debug//tools/${PORT}/sbin
      --libdir=${prefix}/debug//lib
      --includedir=${prefix}/debug/include
      --mandir=${prefix}/debug/share/${PORT}
)

vcpkg_make_install(
  OPTIONS
    -e OPTIONS=" -DSQLITE_CORE -DSQLITE_ENABLE_MEMORY_MANAGEMENT -DSQLITE_ENABLE_ATOMIC_WRITE -DSQLITE_ENABLE_BATCH_ATOMIC_WRITE -DSQLITE_ENABLE_COLUMN_METADATA -DSQLITE_ENABLE_SNAPSHOT -DSQLITE_ENABLE_STAT4 -DSQLITE_LIKE_DOESNT_MATCH_BLOBS -DSQLITE_OMIT_DEPRECATED -DSQLITE_OMIT_SHARED_CACHE -DSQLITE_MAX_MEMORY=104857600 -DSQLITE_DEFAULT_CACHE_SIZE=10000 -DSQLITE_DEFAULT_JOURNAL_SIZE_LIMIT=5242880 -DSQLITE_DEFAULT_MMAP_SIZE=5242880 -DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1 -DSQLITE_DEFAULT_SYNCHRONOUS=1 -DSQLITE_MAX_EXPR_DEPTH=0 -DSQLITE_MAX_MEMORY=104857600 -DSQLITE_MAX_MMAP_SIZE=10485760 -DSQLITE_THREADSAFE=1 -DSQLITE_TEMP_STORE=2"
  OPTIONS_RELEASE
  OPTIONS_DEBUG
    -e OPTIONS=" -DSQLITE_DEBUG=1 -DSQLITE_ENABLE_SELECTTRACE -DSQLITE_ENABLE_WHERETRACE"
)

file(
  INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/sqlite3.c"
  DESTINATION ${CURRENT_PACKAGES_DIR}/src
)

vcpkg_fixup_pkgconfig()

vcpkg_copy_pdbs()

vcpkg_install_copyright(
  FILE_LIST
    "${SQLITE_SOURCE_PATH}/LICENSE.md"
)

file(
  REMOVE_RECURSE
  "${CURRENT_PACKAGES_DIR}/debug/include"
  "${CURRENT_PACKAGES_DIR}/debug/share"
)
