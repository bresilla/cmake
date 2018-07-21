add_library(hello STATIC inc/hello.cpp)
add_executable(main main.cpp)

target_link_libraries(main hello)