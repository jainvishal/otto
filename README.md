OTTO - Automate C/C++ CMake for Large Repositories
==================================================

For large repository with many projects, dependencies and contributors, getting everything to work nicely is not an easy task. Standardization is the biggest issue. The idea behind this project is to get any project up and running with the tooling needed for a modern C or C++ codebase. 

Features in a nutshell:

- Encapsulate complexities of cmake in module files
- Very small and simple makefiles for end user projects
- Handle external dependencies between projects using `find_package`
- Out of source compilation
- Support for installing both 'release' and 'debug' binaries and shared objects
- Support for installation target. The binaries can be installed with the command `make install`.
- Automatic `version.h` generated files.
- Provide toolchain support

Project Structure
------------------
Following is the main structure how the code is divided. Main important files are the files that end in cmake and are in templates directory. Samples directory contains two samples on how to use and can be removed later.

```
.
├── LICENSE.md
├── otto.cmake
├── otto_create_version.cmake
├── otto_external_dependency.cmake
├── otto_find.cmake
├── otto_install.cmake
├── otto_run.cmake
├── otto_set_toolchain.cmake
├── README.md
├── sample
│   ├── sayHello
│   │   ├── CMakeLists.txt
│   │   ├── include
│   │   │   ├── dummy.h
│   │   │   └── sayHello.h
│   │   └── src
│   │       ├── sayHello.cpp
│   │       └── sayit.cpp
│   └── saySomething
│       ├── CMakeLists.txt
│       └── src
│           └── saySomething.cpp
├── templates
│   ├── ProjectConfig.cmake
│   └── version.h.in
└── toolchains
    └── linux.x86_64.gcc92.cmake

8 directories, 19 files
```

Getting Started
-----------------
Note: Make sure to use cmake 3.15 or above as some of the generator expressions that are in use do not work properly with older revisions.

1. Clone the repository to get the boilerplate:

```
git clone https://github.com/jainvishal/otto.git
cd otto
```
2. Configure `otto` to match your release and installation environment. `otto.cmake` provides following variables that can be tuned.

- `CMAKE_INSTALL_PREFIX` - Where to publish headers, shared library and binary
- `OTTO_INSTALL_RPATH_PREFIX` - Expected path in production where libraries and binaries are installed. This sets the `rpath`.

3. Create your toolchain file (with path to compiles and flags). See provided toolchain file for ideas.
4. Looking at a test project that publishes header, a shared library and a binary. It is `sayHello` project in sample directory. Its `CMakeLists.txt` file shall provide enough guidance on the usage. To compile, follow below steps in `sayHello` root directory.

    1. configure:
        ```cmake
        cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DOTTO_TOOLCHAIN=linux.x86_64.gcc91
        ```
        1. Change `-DCMAKE_BUILD_TYPE` to `Debug` to compile in debug mode.
        1. Change `-DOTTO_TOOLCHAIN` to whichever toolchain file is required. 

    2. To compile: (on linux `make` in `build` directory can also be used, also note that this could be skipped as next step will performt the build as well)
        ```cmake
        cmake --build build
        ```
    3. To install (in `CMAKE_INSTALL_PREFIX`): (on linux `make install` in `build` directory will do same)
        ```cmake
        cmake --build build --target install
        ```
    So now you compiled a project that produces header file, a shared library and also a test binary. It also installs cmake configuration files for other projects to use `find_package` to configure flags.
5. Next step now is to use what we just accomplished. Look at `saySomething` project. Again check `CMakeLists.txt` in that project for the idea on how to specify external dependencies.
    1. Setup dependencies: Main variable to look for is `OTTO_DEPENDENCY_ON`. It is a list of `<package>:<version>`, e.g. if the project depends on:

        - sayHello version 1.5
        - myMonitoring version 7.65

        Value of `OTTO_DEPENDENCY_ON` would be `sayHello:1.5 myMonitoring:7.65`. Note that for now this will only work if both packages and their versions are compiled using `otto` (or at least published in same format as `otto` publishes).
    2. Configure and compile: Use same steps as `sayHello`.
    3. Test: When `saySomething` (from published area) is run or `ldd` or `objdump -x` is used on it, it will show that it is using right `rpath` to find libraries from `OTTO_INSTALL_RPATH_PREFIX` path followed by `CMAKE_INSTALL_PREFIX`.
    
Output Directory Structure
----------------------------
```
.
├── lib
│   └── cmake
│       └── sayHello-0.0 -> ../../sayHello/0.0.1/cmake
├── sayHello
│   └── 0.0.1
│       ├── cmake
│       │   ├── sayHelloConfig.cmake
│       │   ├── sayHelloConfigVersion.cmake
│       │   ├── sayHelloTargets.cmake
│       │   └── sayHelloTargets-debug.cmake
│       ├── include
│       │   ├── dummy.h
│       │   └── sayHello.h
│       └── linux.x86_64.gcc92
│           ├── bin_debug
│           │   └── sayHello
│           └── lib_debug
│               ├── libsayHello.so -> libsayHello.so.0
│               ├── libsayHello.so.0 -> libsayHello.so.0.0.1
│               └── libsayHello.so.0.0.1
└── saySomething
    └── 1.0.0
        └── linux.x86_64.gcc92
            └── bin_debug
                └── saySomething

14 directories, 11 files
```