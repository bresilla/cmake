#pragma once
#include <string>
#include <fstream>
#include <sstream>
#include <iostream>
#include <vector>

namespace utl {

    int factorial(int number) { return number <= 1 ? number : factorial(number - 1) * number; }
}
