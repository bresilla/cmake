#######################################################################
#                   SOURCE CMAKE
#######################################################################
###### ADD THE MAIN FILE as EXECUTABLE ######
add_executable(${PROJECT_NAME} main.cpp)
file(MAKE_DIRECTORY "${INCLUDE_PATH}")

file(GLOB HEAD_FILES "inc/*.h" "inc/*.hpp")
file(GLOB CODE_FILES "inc/*.c" "inc/*.cpp")
file(GLOB SINGLE_FILES "sgl/*.hpp")


###### INTERNAL LIBRARIES ######
#function to add internal libs and copy headers
function (add_filelib FILE)
    get_filename_component(NAME ${FILE} NAME_WE)
    get_filename_component(PATH ${FILE} DIRECTORY)
    set(CODE ${PATH}/${NAME}.cpp)
    set(HEAD ${PATH}/${NAME}.h)
    add_library(${NAME} STATIC ${CODE})
    file(COPY "${HEAD}" DESTINATION "${INCLUDE_PATH}")
endfunction(add_filelib)
#function to add header only internal libraries
function (add_filehead FILE )
    get_filename_component(NAME ${FILE} NAME_WE)
    get_filename_component(PATH ${FILE} DIRECTORY)
    set(HEAD ${PATH}/${NAME}.h)
    add_library(${NAME} INTERFACE)
    target_sources(${NAME} INTERFACE ${HEAD})
endfunction(add_filehead)

#automatically add all libraries in /src
foreach(A_FILE ${CODE_FILES})
    # add_filelib(${PROJECT_PATH}/src/inc/classic.cpp)
    add_filelib(${A_FILE})
    message(STATUS "added library: ${A_FILE}")
endforeach()
#automatically add all header-onl-libraries in /sgl
foreach(A_FILE ${SINGLE_FILES})
    # add_filehead(${PROJECT_PATH}/src/sgl/utils.hpp)
    add_filehead(${A_FILE})
    message(STATUS "added header: ${A_FILE}")
endforeach()


###### EXTERNAL PACKAGES ######
# LET LD SEARCH HERE (avoid, better use find_library())
# link_directories(/usr/lib)

# EIGEN
# find_package(Eigen3 REQUIRED)
# if(Eigen3_FOUND)
    # message ("Eigen3 FOUND")
    # target_include_directories(${PROJECT_NAME} PRIVATE ${EIGEN3_INCLUDE_DIR})
# else()
    # message (FATAL_ERROR "Cannot find Eigen3")
# endif()


##### INCLUDE HEADERS
#per target include
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/src)
#or all in src include
include_directories(${PROJECT_SOURCE_DIR}/src})


###### LINK OTHER LIBRARIES ######
target_link_libraries(classic
    PRIVATE
        fmt
        doctest)


###### LAST LINK WITH EXECUTABLE ######
target_link_libraries(${PROJECT_NAME}
    PRIVATE
        classic
    PUBLIC
        fmt
        # spdlog
        # ncurses${CMAKE_STATIC_LIBRARY_SUFFIX}
)


###### INSTALL ######
install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY "${LIB_PATH}/" DESTINATION ${CMAKE_INSTALL_LIBDIR})
install(DIRECTORY "${INCLUDE_PATH}/" DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
