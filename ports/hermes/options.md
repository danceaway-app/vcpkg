# platform target
HERMES_IS_ANDROID OFF CACHE BOOL "Building for Android"
HERMES_IS_MOBILE_BUILD ${HERMES_IS_ANDROID} CACHE BOOL "Building for a mobile device"

# vm options
HERMESVM_GCKIND HADES CACHE STRING "HermesVM GC type: either MALLOC or HADES"

HERMESVM_ALLOW_CONCURRENT_GC ON CACHE BOOL "Enable concurrency in the GC for 64-bit builds."
HERMESVM_ALLOW_INLINE_ASM ON CACHE BOOL "Allow the use of inline assembly in VM code."
HERMESVM_ALLOW_COMPRESSED_POINTERS ON CACHE BOOL "Enable compressed pointers. If this is on and the target is a 64-bit build, compressed pointers will be used."
HERMESVM_ALLOW_HUGE_PAGES OFF CACHE BOOL "Enable huge pages to back the GC managed heap. Only useful on Linux."
HERMESVM_SANITIZE_HANDLES OFF CACHE BOOL "Enable Handle sanitization"
HERMES_ENABLE_TRACE_PC_GUARD OFF CACHE BOOL "Enable -fsanitize-coverage=trace-pc-guard"
HERMES_ENABLE_THREAD_SANITIZER OFF CACHE BOOL "Enable -fsanitize=thread"
HERMES_ENABLE_UNDEFINED_BEHAVIOR_SANITIZER OFF CACHE BOOL "Enable -fsanitize=undefined"
HERMES_ENABLE_ADDRESS_SANITIZER OFF CACHE BOOL "Enable -fsanitize=address"
# vm features
HERMES_ENABLE_BITCODE OFF CACHE BOOL "Include bitcode with the framework"
HERMES_ENABLE_UNICODE_REGEXP_PROPERTY_ESCAPES ON CACHE BOOL "Enable RegExp Unicode Property Escapes support"
HERMES_RUN_WASM OFF CACHE BOOL "Emit Asm.js/Wasm unsafe compiler intrinsics"
EMSCRIPTEN_FASTCOMP OFF CACHE BOOL "Emscripten is using the fastcomp backend instead of the LLVM one"

# security
HERMES_HARDENED OFF CACHE BOOL "Enable compile-time security mitigations"

# debug/profiling options
HERMES_THREAD_SAFETY_ANALYSIS ON CACHE BOOL "Whether to compile with clang's -Wthread-safety"
HERMESVM_PROFILER_OPCODE OFF CACHE BOOL "Enable opcode stats profiling in hermes VM"
HERMESVM_PROFILER_BB OFF CACHE BOOL "Enable basic block profiling in hermes VM"
HERMESVM_PROFILER_JSFUNCTION OFF CACHE BOOL "Enable JS Function profiling in hermes VM"
HERMESVM_PROFILER_NATIVECALL OFF CACHE BOOL "Enable native call profiling in hermes VM"
HERMESVM_API_TRACE_ANDROID_REPLAY OFF CACHE BOOL "Simulate Android config on Linux in API tracing."
HERMESVM_CRASH_TRACE OFF CACHE BOOL "Enable recording of instructions for crash debugging depending on VMExperiments"
HERMESVM_PLATFORM_LOGGING OFF CACHE BOOL "hermesLog(... is enabled, using the platform's logging mechanism"
HERMESVM_EXCEPTION_ON_OOM OFF CACHE BOOL "GC Out-of-memory raises an exception, rather than causing a crash"
HERMES_MEMORY_INSTRUMENTATION ${HERMES_ENABLE_DEBUGGER} CACHE BOOL "Build with memory instrumentation support"
HERMES_ENABLE_DEBUGGER ON CACHE BOOL "Build with debugger support"
HERMES_ENABLE_IR_INSTRUMENTATION OFF CACHE BOOL "Build IR instrumentation support"
HERMES_SLOW_DEBUG ON CACHE BOOL "Enable slow checks in Debug builds"
HERMES_FUZZING_FLAG "-fsanitize=fuzzer" CACHE STRING "Linker argument to link fuzz targets against a given fuzzer."
HERMES_ENABLE_CODE_COVERAGE OFF CACHE BOOL "Enables code coverage to be collected from binaries. Coverage output will be placed in a subdirectory called \"coverage\" of the build directory."
HERMES_ENABLE_LIBFUZZER OFF CACHE BOOL "Enable libfuzzer"
HERMES_ENABLE_FUZZILLI OFF CACHE BOOL "Enable fuzzilli"

# link options
HERMES_STATIC_LINK OFF CACHE BOOL "Link Hermes statically. May only work on GNU/Linux."
HERMES_USE_STATIC_ICU OFF CACHE BOOL "Force static linking of ICU. May only work on GNU/Linux."
HERMES_UNICODE_LITE OFF CACHE BOOL "Enable to use internal no-op unicode functionality instead of relying on underlying system libraries"
HERMES_ENABLE_WIN10_ICU_FALLBACK ON CACHE BOOL "Whether to allow falling back on Win10 ICU"
HERMES_USE_FLOWPARSER OFF CACHE BOOL "Use libflowparser for parsing es6"
HERMES_ENABLE_WERROR OFF CACHE BOOL "Whether the build should have -Werror enabled"
HERMES_BUILD_APPLE_FRAMEWORK ON CACHE BOOL "Whether to build the libhermes target as a framework bundle or dylib on Apple platforms"
HERMES_BUILD_APPLE_DSYM OFF CACHE BOOL "Whether to build a DWARF debugging symbols bundle"
HERMES_BUILD_NODE_HERMES OFF CACHE BOOL "Whether to build node-hermes"
HERMES_BUILD_SHARED_JSI ${DEFAULT_BUILD_SHARED_LIBS} CACHE BOOL "Build JSI as a shared library."
BUILD_SHARED_LIBS ${DEFAULT_BUILD_SHARED_LIBS} CACHE BOOL "Prefer producing shared libraries."

# tools
HERMES_ENABLE_TOOLS ON CACHE BOOL "Enable CLI tools"

# experimental
HERMES_ENABLE_INTL OFF CACHE BOOL "Enable JS Intl support (WIP"
