# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "GSWCBuilder"
version = v"0.0.0"

# Collection of sources required to build GSWCBuilder
sources = [
    "https://github.com/TEOS-10/GSW-C/archive/master.zip" =>
    "4d77c322b9a8ac107b0fee3fe36267e43384ae6cb2532ab8cd883e80d086aa5b",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd GSW-C-master/
$CC $CFLAGS -fPIC -c -O3 -Wall  gsw_oceanographic_toolbox.c gsw_saar.c
if [ $target = "x86_64-w64-mingw32" ] || [ $target = "i686-w64-mingw32" ] || [ $target = "x86_64-apple-darwin14" ]; then   LD=$CC; elif [ $target = "x86_64-unknown-freebsd11.1" ]; then   LD=ld; fi
$LD $LDFLAGS -fPIC -shared -o libgswteos-10.$dlext gsw_oceanographic_toolbox.o gsw_saar.o -lm
cp libgswteos-10.$dlext $prefix
cp gsw_data_v3_0.nc $prefix

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:i686, libc=:glibc),
    Linux(:x86_64, libc=:glibc),
    Linux(:aarch64, libc=:glibc),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf),
    Linux(:powerpc64le, libc=:glibc),
    Linux(:i686, libc=:musl),
    Linux(:x86_64, libc=:musl),
    Linux(:aarch64, libc=:musl),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf),
    MacOS(:x86_64),
    FreeBSD(:x86_64),
    Windows(:i686),
    Windows(:x86_64)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libgswteos", :libgswteos)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

