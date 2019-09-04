#pragma once
#include <iostream>
// #include "fmt/format.h"

class Logger {
public:
    enum Level { LevelError,
                 LevelWarn,
                 LevelInfo };

private:
    Level m_logLevel = LevelInfo;

public:
    void leveler( Level level );
};
