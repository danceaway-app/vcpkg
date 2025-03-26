vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO facebook/hermes
  REF hermes-2024-11-25-RNv0.77.0-d4f25d534ab744866448b36ca3bf3d97c08e638c
  SHA512 f6c06f86199b2cb28a6bb090d74c0ffd053f7d859f0dd92f1cac882ddc4c06fd0dcbcc96da3d72b3ab5ecd9d681cf992ad84c9e95ef5c2ae61961d2b545bcb50
  HEAD_REF main
)

file(
  COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt"
  DESTINATION "${SOURCE_PATH}"
)

vcpkg_check_features(
  OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
    tools                                 HERMES_ENABLE_TOOLS
    android                               HERMES_IS_ANDROID
    hardened                              HERMES_HARDENED
    enable-bitcode                        HERMES_ENABLE_BITCODE
    hermes-linked-statically              HERMES_STATIC_LINK
    enable-fastcomp-emscripten            EMSCRIPTEN_FASTCOMP
    enable-unicode-regexp-escape          HERMES_ENABLE_UNICODE_REGEXP_PROPERTY_ESCAPES
    gc-type-hades                         CFG_GCTYPE_HADES_OVER_MALLOC
    vm-enable-sanitizers                  HERMESVM_SANITIZE_HANDLES
    vm-enable-sanitizers                  HERMES_ENABLE_TRACE_PC_GUARD
    vm-enable-sanitizers                  HERMES_ENABLE_THREAD_SANITIZER
    vm-enable-sanitizers                  HERMES_ENABLE_UNDEFINED_BEHAVIOR_SANITIZER
    vm-enable-sanitizers                  HERMES_ENABLE_ADDRESS_SANITIZER
    vm-enable-optimizations               HERMESVM_ALLOW_CONCURRENT_GC
    vm-enable-optimizations               HERMESVM_ALLOW_INLINE_ASM
    vm-enable-optimizations               HERMESVM_ALLOW_COMPRESSED_POINTERS
    vm-enable-optimizations               HERMESVM_ALLOW_HUGE_PAGES
    enable-debug-and-profiling-features   HERMESVM_PROFILER_OPCODE
    enable-debug-and-profiling-features   HERMESVM_PROFILER_BB
    enable-debug-and-profiling-features   HERMESVM_PROFILER_JSFUNCTION
    enable-debug-and-profiling-features   HERMESVM_PROFILER_NATIVECALL
    enable-debug-and-profiling-features   HERMESVM_API_TRACE_ANDROID_REPLAY
    enable-debug-and-profiling-features   HERMESVM_CRASH_TRACE
    enable-debug-and-profiling-features   HERMESVM_PLATFORM_LOGGING
    enable-debug-and-profiling-features   HERMESVM_EXCEPTION_ON_OOM
    enable-debug-and-profiling-features   HERMES_ENABLE_DEBUGGER
    enable-debug-and-profiling-features   HERMES_ENABLE_IR_INSTRUMENTATION
    enable-debug-and-profiling-features   HERMES_SLOW_DEBUG
    enable-debug-and-profiling-features   HERMES_ENABLE_CODE_COVERAGE
    enable-debug-and-profiling-features   HERMES_ENABLE_LIBFUZZER
    enable-debug-and-profiling-features   HERMES_ENABLE_FUZZILLI
    experimental-js-intl                  HERMES_ENABLE_INTL
  INVERTED_FEATURES
    enable-debug-and-profiling-features   HERMES_THREAD_SAFETY_ANALYSIS
)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME danceaway-${PORT})

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/include/hermes/cdp/tools")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
