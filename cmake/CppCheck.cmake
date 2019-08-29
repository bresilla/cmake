find_program(CPPCHECK cppcheck)
if (CPPCHECK)
    add_custom_target(
            cppcheck
            COMMAND ${CPPCHECK}
            --quiet
            --error-exitcode=1
            --enable=warning,portability,performance,style
            --std=c++11
            ${CMAKE_CURRENT_SOURCE_DIR}/src
    )
endif ()
