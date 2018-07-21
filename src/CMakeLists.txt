add_library(hello inc/hello.cpp)
add_executable(main main.cpp)

target_link_libraries(main hello)