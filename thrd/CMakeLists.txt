#######################################################################
#                   THIRD PARTY LIB CMAKE
#######################################################################
set(BUILD_TESTING_BCKP ${BUILD_TESTING})
set(BUILD_TESTING OFF CACHE BOOL "Force disable of tests for external dependencies" FORCE)

set(CUSTOM_COVERAGE_EXCLUDE ${CUSTOM_COVERAGE_EXCLUDE} "external" PARENT_SCOPE) # Replaced in CTestCustom.cmake.in

find_package(Git REQUIRED)


#Use fmtlib for formatting
add_subdirectory(fmt EXCLUDE_FROM_ALL)
target_set_warnings(fmt DISABLE ALL)              # Treat fmtlib as a system include as to ignore the warnings
# Add new external (non-interface) targets to this list
set_target_properties(fmt PROPERTIES FOLDER "external")


#Use spdlog for logging, and tell it to use our version of fmtlib
add_subdirectory(spdlog EXCLUDE_FROM_ALL)
target_compile_definitions(spdlog INTERFACE SPDLOG_FMT_EXTERNAL)
file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/logs")


#Doctest for unit tests
add_library(doctest INTERFACE)
target_include_directories(
    doctest
    INTERFACE
    doctest/doctest # note : will expose the parts/ folder...
)
target_compile_features(doctest INTERFACE cxx_std_11)
include_directories(${DOCTEST_INCLUDE_DIR})
