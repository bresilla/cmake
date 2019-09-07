#include "classic.h"
/// calculate volume of the square
/// based on the input `a` and `b` and `c`
void Object::setVolume( int a, int b, int c ) {
    this->volume = a * b * c;
}

/// calculate surface of the square
/// based on the input `a` and `b`
void Object::setSurface( int a, int b ) {
    this->surface = a * b;
}

/// return the surface of the square
int Object::getSurface() {
    return this->surface;
}

/// return the surface of the square
int Object::getVolume() {
    return this->volume;
}
