with import <nixpkgs> {}; rec {
  cplateEnv = stdenv.mkDerivation {
    name = "cmake";
    buildInputs = [ stdenv
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
                  ];
    LD_LIBRARY_PATH="/run/opengl-driver/lib;${xorg.libX11}/lib/;${libGL}/lib/;${libGLU}/lib;${freeglut}/lib";
    TOOLSET="clang++-7.1";
    LLVM_CONFIG_BINARY="/nix/store/jkjzhbfmf2miplcz0svy5c8yd01qsg1l-llvm-7.1.0/bin/llvm-config";
  };
}
