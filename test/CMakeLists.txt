#######################################################################
#                   TESTING CMAKE
#######################################################################
include(CTest)
include(CMakeDependentOption)

set(BUILD_TESTING_BCKP ${BUILD_TESTING})
set(BUILD_TESTING OFF CACHE BOOL "Force disable of tests for external dependencies" FORCE)
set(CUSTOM_COVERAGE_EXCLUDE ${CUSTOM_COVERAGE_EXCLUDE} "external" PARENT_SCOPE) # Replaced in CTestCustom.cmake.in
list(APPEND LCOV_REMOVE_PATTERNS "'${PROJECT_SOURCE_DIR}/thrd/*'") #exclude from coverage


set(TEST_1 ${PROJECT_NAME}_test_one)
add_executable(${TEST_1} test_one.cpp)
target_link_libraries(${TEST_1} PRIVATE doctest)

add_coverage(${TEST_1})

include(${PROJECT_PATH}/thrd/doctest/scripts/cmake/doctest.cmake)
doctest_discover_tests(${TEST_1})
