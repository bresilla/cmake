#include "inc/Log.h"
#include "fmt/format.h"
// #include "spdlog/spdlog.h"

#define LOG(x) std::cout << x << std::endl

int main() {


    std::string s = fmt::format("I'd rather be {1} than {0}.", "right", "happy");
    fmt::print(s);  // Python-like format string syntax


    // Log log;
    // log.setLevel(Log::LevelInfo);
    // log.INFO("Sarting info here");
    // log.WARN("starting warning here");
    // log.ERROR("starting error here");
}
