#include "fmt/format.h"
// #include "spdlog/spdlog.h"
#include "inc/classic.h"
#include "sgl/utils.hpp"

int main() {
    std::string s = fmt::format( "I'd rather be {1} than {0}.", "right", "happy" );
    fmt::print( s );    // Python-like format string syntax

    fmt::print( "gogo" );

    fmt::print("something");

    // spdlog::info("Welcome to spdlog!");
    // spdlog::error("Some error message with arg: {}", 1);
}
