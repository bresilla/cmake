add_library(player STATIC inc/player.cpp)
add_library(log STATIC inc/Log.cpp)
add_executable(main main.cpp)

target_include_directories(main PUBLIC ${PROJECT_SOURCE_DIR}/src)
link_directories(/usr/lib)

find_package(Eigen3 REQUIRED)
target_include_directories(main PRIVATE ${EIGEN3_INCLUDE_DIR})

target_link_libraries(player log)
target_link_libraries(main PRIVATE
    player
    log
    ncurses
)
