with import <nixpkgs> {}; rec {
  cplateEnv = stdenv.mkDerivation {
    name = "cmake";
    buildInputs = [ stdenv
                    cmake
                    ncurses
                    gcc
                    clang
                    clang-tools
                    ctags
                    cppcheck
                    lcov
                    llvmPackages.libclang
                    gdb
                    pkgconfig
                    xorg.libX11
                    libGL
                    libGLU
                    freeglut
                  ];
    LD_LIBRARY_PATH="/run/opengl-driver/lib;${xorg.libX11}/lib/;${libGL}/lib/;${libGLU}/lib;${freeglut}/lib";
  };
}
