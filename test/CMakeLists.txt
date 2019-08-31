#######################################################################
#                   TESTING CMAKE
#######################################################################
include(CTest)

set(BUILD_TESTING_BCKP ${BUILD_TESTING})
set(BUILD_TESTING OFF CACHE BOOL "Force disable of tests for external dependencies" FORCE)
set(CUSTOM_COVERAGE_EXCLUDE ${CUSTOM_COVERAGE_EXCLUDE} "external" PARENT_SCOPE) # Replaced in CTestCustom.cmake.in


set(TEST_BINARY ${PROJECT_NAME}_test)
add_executable(${TEST_BINARY} test_one.cpp)

target_compile_features(${TEST_BINARY} PRIVATE cxx_std_17)
target_link_libraries(${TEST_BINARY} PRIVATE doctest)

# add_test(
    # NAME ${TEST_BINARY}
    # COMMAND ${EXECUTABLE_OUTPUT_PATH}/${TEST_BINARY}
# )

include(${PROJECT_PATH}/thrd/doctest/scripts/cmake/doctest.cmake)
doctest_discover_tests(${TEST_BINARY})
