#pragma once
#include <iostream>
// #include "fmt/format.h"

class Square {
public:
    int width;
    int heigh;

private:
    int surface;

public:
    void setSurface( int a, int b );
    int getSurface();
};
