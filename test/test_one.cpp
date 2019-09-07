#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "../src/inc/classic.h"
#include "../src/sgl/utils.hpp"
#include <doctest.h>

TEST_CASE( "testing the factorial function" ) {
    CHECK( utl::factorial( 1 ) == 1 );
    CHECK( utl::factorial( 2 ) == 2 );
    CHECK( utl::factorial( 3 ) == 6 );
    CHECK( utl::factorial( 10 ) == 3628800 );
}

TEST_CASE( "testing square class" ) {
    Square square;
    square.setSurface( 5, 4 );
    CHECK( square.getSurface() == 20 );
}
