#######################################################################
#                   TESTING CMAKE
#######################################################################
include(CTest)

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
