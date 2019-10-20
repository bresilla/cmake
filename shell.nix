with import <nixpkgs> {}; rec {
  boomerEnv = stdenv.mkDerivation {
    name = "libcli";
    buildInputs = [ stdenv
                    cmake
                    ncurses
                    gcc
                    clang
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
