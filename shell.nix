with import <nixpkgs> {}; rec {
  cplateEnv = stdenv.mkDerivation {
    name = "cmake";
    buildInputs = [ stdenv
                    ccache
                    cmake
                    pkgconfig
                    gcc
                    gdb
                    clang
                    clang-tools
                    llvm
                    llvmPackages.libclang
                    lldb
                    ctags
                    cppcheck
                    valgrind
                    kcov
                    xorg.libX11
                    ncurses
                  ];
    LD_LIBRARY_PATH="/run/opengl-driver/lib;${xorg.libX11}/lib/;${libGL}/lib/;${libGLU}/lib;${freeglut}/lib";
    CXX="clang++";
  };
}
