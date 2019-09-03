#pragma once
#include <iostream>
// #include "fmt/format.h"

class Log {
    public:
        enum Level{LevelError, LevelWarn, LevelInfo};
    private:
        Level m_logLevel = LevelInfo;
    public:




        void setLevel(Level level);
};
