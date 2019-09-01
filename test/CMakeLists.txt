#######################################################################
#                   TESTING CMAKE
#######################################################################
include(CTest)
include(CMakeDependentOption)
include(${PROJECT_PATH}/thrd/doctest/scripts/cmake/doctest.cmake)

set(BUILD_TESTING_BCKP ${BUILD_TESTING})
set(BUILD_TESTING OFF CACHE BOOL "Force disable of tests for external dependencies" FORCE)
list(APPEND LCOV_REMOVE_PATTERNS "'${PROJECT_SOURCE_DIR}/thrd'") #exclude from coverage

# function to automatically set up testing for specific file
function (add_testing PATH)
    get_filename_component(NAME ${PATH} NAME_WE)
    set(NAME ${PROJECT_NAME}_${NAME})
    add_executable(${NAME} ${PATH})
    target_link_libraries(${NAME} PRIVATE doctest)
    add_test(NAME ${NAME} COMMAND ${EXECUTABLE_OUTPUT_PATH}/${NAME})
    if(ENABLE_COVERAGE)
        add_coverage(${NAME})
        add_custom_command(TARGET ${NAME} POST_BUILD COMMAND kcov ${PROJECT_BINARY_DIR}/kcov ${PROJECT_BINARY_DIR}/bin/${NAME})
    endif()
endfunction(add_testing)

file(GLOB TEST_FILES "*.c" "*.cpp")
if(BUILD_TESTS)
    foreach(A_FILE ${TEST_FILES})
        add_testing(${A_FILE})
    endforeach()
endif()
