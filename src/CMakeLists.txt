#######################################################################
#                   SOURCE CMAKE
#######################################################################
###### ADD THE MAIN FILE as EXECUTABLE ######
add_executable(${PROJECT_NAME} main.cpp)
file(MAKE_DIRECTORY "${INCLUDE_PATH}")

file(GLOB HEAD_FILES "inc/*.h" "inc/*.hpp")
file(GLOB CODE_FILES "inc/*.c" "inc/*.cpp")
file(GLOB SINGLE_FILES "inc/*.hpp")


###### INTERNAL LIBRARIES ######
#function to add internal libs and copy headers
function (add_filelib FILE)
    set(CODE ${PROJECT_SOURCE_DIR}/src/inc/${FILE}.cpp)
    set(HEAD ${PROJECT_SOURCE_DIR}/src/inc/${FILE}.h)
    add_library(${FILE} STATIC ${CODE})
    file(COPY "${HEAD}" DESTINATION "${INCLUDE_PATH}")
endfunction(add_filelib)
#function to add header only internal libraries
function (add_filehead FILE )
    set(HEAD ${PROJECT_SOURCE_DIR}/src/sgl/${FILE}.hpp)
    add_library(${FILE} INTERFACE)
    target_sources(${FILE} INTERFACE ${HEAD})
endfunction(add_filehead)

add_filelib(classic)
add_filehead(utils)


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
        # ncurses${CMAKE_STATIC_LIBRARY_SUFFIX}
        # spdlog
        fmt
        classic)


###### INSTALL ######
# install(TARGETS ${PROJECT_NAME} DESTINATION "usr/local/bin")
# install(TARGETS ${LIB_PATH} DESTINATION "usr/local/lib")
# install(DIRECTORY "${INCLUDE_PATH}/" DESTINATION "usr/local/include")
