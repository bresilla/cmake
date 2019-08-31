#######################################################################
#                   TESTING CMAKE
#######################################################################
include(CTest)
include(CMakeDependentOption)

if (ENABLE_COVERAGE)
    # file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/gcov)
    add_custom_target(lcov
        # COMMAND find ${PROJECT_BINARY_DIR} -type f -name *.gcno -exec gcov -pb {} '\;' > ${PROJECT_BINARY_DIR}/gcov/coverage.info
        COMMAND lcov --no-external --capture --base-directory ${PROJECT_SOURCE_DIR} --directory ${PROJECT_BINARY_DIR} --output-file coverage.info --rc lcov_branch_coverage=1
        COMMAND lcov --remove coverage.info 3rdparty/* src/*/test/* --base-directory ${PROJECT_SOURCE_DIR} --output-file coverage.info --rc lcov_branch_coverage=1
        COMMAND genhtml coverage.info --output-directory html --demangle-cpp --rc genhtml_branch_coverage=1
        COMMAND echo "HTML report generated in: " ${PROJECT_BINARY_DIR}/lcov/html
        WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/lcov)
endif()


set(BUILD_TESTING_BCKP ${BUILD_TESTING})
set(BUILD_TESTING OFF CACHE BOOL "Force disable of tests for external dependencies" FORCE)
set(CUSTOM_COVERAGE_EXCLUDE ${CUSTOM_COVERAGE_EXCLUDE} "external" PARENT_SCOPE) # Replaced in CTestCustom.cmake.in
list(APPEND LCOV_REMOVE_PATTERNS "'${PROJECT_SOURCE_DIR}/thrd'") #exclude from coverage


set(TEST_1 ${PROJECT_NAME}_test_one)
add_executable(${TEST_1} test_one.cpp)
target_link_libraries(${TEST_1} PRIVATE doctest)
add_coverage(${TEST_1})

include(${PROJECT_PATH}/thrd/doctest/scripts/cmake/doctest.cmake)
doctest_discover_tests(${TEST_1})
