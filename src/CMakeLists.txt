add_executable(${PROJECT_NAME} main.cpp)

add_library(log STATIC ${PROJECT_SOURCE_DIR}/src/inc/Log.cpp)
add_library(utl INTERFACE)
target_sources(utl INTERFACE ${PROJECT_SOURCE_DIR}/src/inc/utl/utils.hpp)

target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/src)
link_directories(/usr/lib)

find_package(Eigen3 REQUIRED)
target_include_directories(${PROJECT_NAME} PRIVATE ${EIGEN3_INCLUDE_DIR})

target_link_libraries(${PROJECT_NAME} PRIVATE
    log
    ncurses${CMAKE_STATIC_LIBRARY_SUFFIX}
)
