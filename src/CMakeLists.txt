###### ADD THE MAIN FILE as EXECUTABLE ######
add_executable(${PROJECT_NAME} main.cpp)



###### INTERNAL LIBRARIES ######
add_library(log STATIC ${PROJECT_SOURCE_DIR}/src/inc/Log.cpp)
add_library(utl INTERFACE)
target_sources(utl INTERFACE ${PROJECT_SOURCE_DIR}/src/inc/utl/utils.hpp)
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/src)




###### EXTERNAL PACKAGES ######
# LET LD SEARCH HERE (avoid, better use find_library())
link_directories(/usr/lib)

# EIGEN
# find_package(Eigen3 REQUIRED)
# if(Eigen3_FOUND)
    # message ("Eigen3 FOUND")
    # target_include_directories(${PROJECT_NAME} PRIVATE ${EIGEN3_INCLUDE_DIR})
# else()
    # message (FATAL_ERROR "Cannot find Eigen3")
# endif()



###### LAST LINK WITH EXECUTABLE ######
target_link_libraries(${PROJECT_NAME} PRIVATE
    log
    ncurses${CMAKE_STATIC_LIBRARY_SUFFIX}
)


###### INSTALL ######
install(TARGETS ${PROJECT_NAME} DESTINATION bin)
