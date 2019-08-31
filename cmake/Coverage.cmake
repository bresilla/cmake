# 3. Use the function SETUP_TARGET_FOR_COVERAGE to create a custom make target
#    which runs your test executable and produces a lcov code coverage report:
#    Example:
#    SETUP_TARGET_FOR_COVERAGE(
#               my_coverage_target  # Name for custom target.
#               test_driver         # Name of the test driver executable that runs the tests.
#                                   # NOTE! This should always have a ZERO as exit code
#                                   # otherwise the coverage generation will not complete.
#               coverage            # Name of output directory.
#               )
#
# 5. Extract specific files/directories.
#    Example:
#    set(COVERAGE_EXTRACT
#      '${CMAKE_CURRENT_SOURCE_DIR}/include/*'
#      '${CMAKE_CURRENT_SOURCE_DIR}/src/*'
#      '${CMAKE_CURRENT_SOURCE_DIR}/tests/*'
#    )
#

# Check prereqs
FIND_PROGRAM( GCOV_PATH gcov )
file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/coverage/gcov)
message("-- gcov found, coverage reports available through target 'gcov'")

FIND_PROGRAM( LCOV_PATH lcov )
FIND_PROGRAM( GENHTML_PATH genhtml )
message("-- lcov and genhtml found, html reports available through target 'lcov'")
file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/coverage/lcov/html)

SET(CMAKE_CXX_FLAGS_COVERAGE
    "-g -O0 --coverage -fprofile-arcs -ftest-coverage"
    CACHE STRING "Flags used by the C++ compiler during coverage builds."
    FORCE )
SET(CMAKE_C_FLAGS_COVERAGE
    "-g -O0 --coverage -fprofile-arcs -ftest-coverage"
    CACHE STRING "Flags used by the C compiler during coverage builds."
    FORCE )
SET(CMAKE_EXE_LINKER_FLAGS_COVERAGE
    ""
    CACHE STRING "Flags used for linking binaries during coverage builds."
    FORCE )
SET(CMAKE_SHARED_LINKER_FLAGS_COVERAGE
    ""
    CACHE STRING "Flags used by the shared libraries linker during coverage builds."
    FORCE )
MARK_AS_ADVANCED(
    CMAKE_CXX_FLAGS_COVERAGE
    CMAKE_C_FLAGS_COVERAGE
    CMAKE_EXE_LINKER_FLAGS_COVERAGE
    CMAKE_SHARED_LINKER_FLAGS_COVERAGE )

if (ENABLE_COVERAGE)
    add_custom_target(gcov
        COMMAND find ${PROJECT_BINARY_DIR} -type f -name *.gcno -exec gcov -pb {} '\;' > ${PROJECT_BINARY_DIR}/coverage/gcov/coverage.info
        COMMAND echo "Generated coverage report: " ${PROJECT_BINARY_DIR}/coverage/gcov/coverage.info
        WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/coverage/gcov)
    add_custom_target(lcov
        COMMAND lcov --no-external --capture --base-directory ${PROJECT_SOURCE_DIR} --directory ${PROJECT_BINARY_DIR} --output-file coverage.info --rc lcov_branch_coverage=1
        COMMAND lcov --remove coverage.info 3rdparty/* src/*/test/* --base-directory ${PROJECT_SOURCE_DIR} --output-file coverage.info --rc lcov_branch_coverage=1
        COMMAND genhtml coverage.info --output-directory html --demangle-cpp --rc genhtml_branch_coverage=1
        COMMAND echo "HTML report generated in: " ${PROJECT_BINARY_DIR}/coverage/lcov/html
        WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/coverage/lcov)
endif()
