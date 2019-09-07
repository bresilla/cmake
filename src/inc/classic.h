#pragma once
#include <iostream>
// #include "fmt/format.h"

class Object {
public:
    int width;
    int heigh;
    int depth;

private:
    int surface;
    int volume;

public:
    void setSurface( int a, int b );
    void setVolume( int a, int b, int c );
    int getSurface();
    int getVolume();
};
