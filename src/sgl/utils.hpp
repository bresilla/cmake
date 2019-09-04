#pragma once
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

namespace utl {
    ///count the number of factorial
    int factorial( int number ) { return number <= 1 ? number : factorial( number - 1 ) * number; }
}
