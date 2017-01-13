# 3ds-cmake

CMake scripts for devkitArm and 3DS homebrew development.

It aims to provide at least the same functionalities than devkitPro makefiles.
It can help to build more complex projects or simply compile libraries by using
the toolchain file.

## How to use it ?

Simply copy `DevkitArm3DS.cmake` and the `cmake` folder at the root of your
project (where your CMakeLists.txt is). Then start cmake with

```sh
cmake -DCMAKE_TOOLCHAIN_FILE=DevkitArm3DS.cmake
```

Or, put the following at the top of your `CMakeLists.txt` file:

```cmake
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_LIST_DIR}/DevkitArm3DS.cmake)
```

If you are on windows, I suggest using the `Unix Makefiles` generator.

`cmake-gui` is also a good alternative, you can specify the toolchain file the
first time you configure a build.

You can use the macros and find scripts of the `cmake` folder by adding the
following line to your CMakeLists.cmake :

```cmake
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
```

## The toolchain file (DevkitArm3DS.cmake)

### 3DS

This CMake variable will be set so that you can test against it for projects that
can be built on other platforms.

### DKA_SUGGESTED_C_FLAGS

This CMake variable is set to `-fomit-frame-pointer -ffast-math`. Those are the
recommended C flags for devkitArm projects but are non-mandatory.

### DKA_SUGGESTED_CXX_FLAGS

This CMake variable is set to
`-fomit-frame-pointer -ffast-math -fno-rtti -fno-exceptions -std=gnu++11`.
Those are the recommended C++ flags for devkitArm projects but are non-mandatory.

### WITH_PORTLIBS

By default the portlibs folder will be used, it can be disabled by changing the
value of WITH_PORTLIBS to OFF from the cache (or forcing the value from your
CMakeLists.txt).

## FindCTRULIB.cmake

You can use `find_package(CTRULIB)`.  
You can optionally set `CTRULIB_ROOT` before calling `find_package(CTRULIB)` to
specify a directory to look in first.    
If found, `CTRULIB_FOUND`, `CTRULIB_LIBRARIES` and `CTRULIB_INCLUDE_DIRS` will be
set.

## FindCITRO3D.cmake

You can use `find_package(CITRO3D)`.  
You can optionally set `CITRO3D_ROOT` before calling `find_package(CITRO3D)` to
specify a directory to look in first.  
If found, `CITRO3D_FOUND`, `CITRO3D_LIBRARIES` and `CITRO3D_INCLUDE_DIRS` will be
set.  
Note, as CITRO3D depends on CTRULIB, if CTRULIB can't be found, the above won't
be set.

## FindSF2D.cmake

You can use `find_package(SF2D)`.  
You can optionally set `SF2D_ROOT` before calling `find_package(SF2D)` to specify
a directory to look in first.  
If found, `SF2D_FOUND`, `SF2D_LIBRARIES` and `SF2D_INCLUDE_DIRS` will be set.  
Note, as SF2D depends on CITRO3D, if CITRO3D can't be found, the above won't be
set.

## FindSFTD.cmake

You can use `find_package(SFTD)`.  
You can optionally set `SFTD_ROOT` before calling `find_package(SFTD)` to specify
a directory to look in first.  
If found, `SFTD_FOUND`, `SFTD_LIBRARIES` and `SFTD_INCLUDE_DIRS` will be set.  
Note, as SFTD depends on SF2D and the Freetype and by extension the ZLIB portlibs,
if any of them can't be found, the above won't be set. As such, this will most
likely fail if `WITH_PORTLIBS` is set to OFF, unless you manually set
`FREETYPE_ROOT` and `ZLIB_ROOT`.

## FindSFIL.cmake

You can use `find_package(SFIL)`.  
You can optionally set `SFIL_ROOT` before calling `find_package(SFIL)` to specify
a directory to look in first.  
If found, `SFIL_FOUND`, `SFIL_LIBRARIES` and `SFIL_INCLUDE_DIRS` will be set.  
Note, as SFIL depends on SF2D and the JPEG, PNG and by extension the ZLIB portlibs,
if any of them can't be found, the above won't be set. As such, this will most
likely fail if `WITH_PORTLIBS` is set to OFF, unless you set `JPEG_ROOT`,
`PNG_ROOT` and `ZLIB_ROOT`.

## FindZLIB.cmake

You can use `find_package(ZLIB)`.  
You can optionally set `ZLIB_ROOT` before calling `find_package(ZLIB)` to specify
a directory to look in first.  
If found, `ZLIB_FOUND`, `ZLIB_LIBRARIES` and `ZLIB_INCLUDE_DIRS` will be set.  
Note, as ZLIB is a portlib, this will most likely fail if `WITH_PORTLIBS` is set
to OFF, unless you set `ZLIB_ROOT`.

## FindPNG.cmake

You can use `find_package(PNG)`.  
You can optionally set `PNG_ROOT` before calling `find_package(PNG)` to specify
a directory to look in first.  
If found, `PNG_FOUND`, `PNG_LIBRARIES` and `PNG_INCLUDE_DIRS` will be set.  
Note, as PNG is a portlib, and depends on ZLIB this will most likely fail if
`WITH_PORTLIBS` is set to OFF, unless you set `PNG_ROOT` and `ZLIB_ROOT`.

## FindJPEG.cmake

You can use `find_package(JPEG)`.  
You can optionally set `JPEG_ROOT` before calling `find_package(JPEG)` to specify
a directory to look in first.  
If found, `JPEG_FOUND`, `JPEG_LIBRARIES` and `JPEG_INCLUDE_DIRS` will be set.  
Note, as JPEG is a portlib, this will most likely fail if `WITH_PORTLIBS` is set
to OFF, unless you set `JPEG_ROOT`.

## FindFreetype.cmake

You can use `find_package(Freetype)`.  
You can optionally set `FREETYPE_ROOT` before calling `find_package(Freetype)`
to specify a directory to look in first.  
If found, `FREETYPE_FOUND`, `FREETYPE_LIBRARIES` and `FREETYPE_INCLUDE_DIRS`
will be set.  
Note, as FREETYPE is a portlib, and depends on ZLIB this will most likely fail if
`WITH_PORTLIBS` is set to OFF, unless you set `FREETYPE_ROOT` and `ZLIB_ROOT`.

## Tools3DS.cmake

This file must be included with `include(Tools3DS)`. It provides several macros
related to 3DS development such as `add_shader_library` which assembles your
shaders into a C library.

### add_3dsx_target

This macro has two signatures :

#### add_3dsx_target(target [NO_SMDH])

Adds a target that generates a .3dsx file from `target`. If NO_SMDH is specified,
no .smdh file will be generated.

You can set the following variables to change the SMDH file :

* APP_TITLE is the name of the app stored in the SMDH file (Optional)
* APP_DESCRIPTION is the description of the app stored in the SMDH file (Optional)
* APP_AUTHOR is the author of the app stored in the SMDH file (Optional)
* APP_ICON is the filename of the icon (.png), relative to the project folder.
  If not set, it attempts to use one of the following (in this order):
    - $(target).png
    - icon.png
    - $(libctru folder)/default_icon.png

#### add_3dsx_target(target APP_TITLE APP_DESCRIPTION APP_AUTHOR [APP_ICON])

This version will produce the SMDH with the values passed as arguments.
The APP_ICON is optional and follows the same rule as the other version of
`add_3dsx_target`.

### add_cia_target(target RSF IMAGE SOUND [APP_TITLE APP_DESCRIPTION APP_AUTHOR [APP_ICON]])

Same as add_3dsx_target but for CIA files.

* RSF is the .rsf file to be given to makerom.
* IMAGE is either a .png or a cgfximage file.
* SOUND is either a .wav or a cwavaudio file.

### add_netload_target(target FILE)

Adds a target `name` that sends a .3dsx using the homebrew launcher netload
system (3dslink).
* `target_or_file` is either the name of a target (on which you used
  add_3dsx_target) or a file name.

### add_binary_library(target input1 [input2 ...])

__/!\ Requires ASM to be enabled ( `enable_language(ASM)` or
`project(yourprojectname C CXX ASM)`)__

Converts the files given as input to arrays of their binary data. This is useful
to embed resources into your project.  
For example, logo.bmp will generate the array `u8 logo_bmp[]` and its size
`logo_bmp_size`. By linking this library, you will also have access to a
generated header file called `logo_bmp.h` which contains the declarations you
need to use it.

Note : All dots in the filename are converted to `_`, and if it starts with a
number, `_` will be prepended.
For example `8x8.gas.tex` would give the name `_8x8_gas_tex`.

### target_embed_file(target input1 [input2 ...])

Same as:
```cmake
add_binary_library(tempbinlib input1 [input2 ...])
target_link_libraries(target tempbinlib)
```

### add_shbin(output input [entrypoint] [shader_type])

Assembles the shader given as `input` into the file `output`. No file extension
is added.
You can choose the shader assembler by setting SHADER_AS to `picasso` or `nihstro`.

If `nihstro` is set as the assembler, entrypoint and shader_type will be used.
- entrypoint is set to `main` by default
- shader_type can be either VSHADER or GSHADER. By default it is VSHADER.

### generate_shbins(input1 [input2 ...])

Assemble all the shader files given as input into .shbin files. Those will be
located in the folder `shaders` of the build directory.
The names of the output files will be
`<name of input without longest extension>.shbin`. `vshader.pica` will output
`shader.shbin` but `shader.vertex.pica` will output `shader.shbin` too.

### add_shbin_library(target input1 [input2 ...])

__/!\ Requires ASM to be enabled ( `enable_language(ASM)` or
`project(yourprojectname C CXX ASM)`)__

This is the same as calling generate_shbins and add_binary_library.
This is the function to be used to reproduce devkitArm makefiles behaviour.
For example, add_shbin_library(shaders data/my1stshader.vsh.pica) will generate
the target library `shaders` and you will be able to use the shbin in your
program by linking it, including `my1stshader_pica.h` and using
`my1stshader_pica[]` and `my1stshader_pica_size`.

### target_embed_shader(target input1 [input2 ...])

Same as:
```cmake
add_shbin_library(tempbinlib input1 [input2 ...])
target_link_libraries(target tempbinlib)
```

# Example of CMakeLists.txt using ctrulib and shaders

```cmake
cmake_minimum_required(VERSION 2.8)
project(videoPlayer C CXX ASM)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
include(Tools3DS)

find_package(CTRULIB REQUIRED)

file(GLOB_RECURSE SHADERS_FILES
    data/*.pica
)
add_shbin_library(shaders ${SHADERS_FILES})

file(GLOB_RECURSE SOURCE_FILES
    source/*
)
add_executable(hello_cmake ${SOURCE_FILES})
target_include_directories(hello_cmake PRIVATE ${CTRULIB_INCLUDE_DIRS})
target_link_libraries(hello_cmake shaders ${CTRULIB_LIBRARIES})

add_3dsx_target(hello_cmake)
```
