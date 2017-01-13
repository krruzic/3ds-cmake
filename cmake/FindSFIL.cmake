# - Try to find sfil
# Once done this will define
#  SFIL_FOUND - System has sfil
#  SFIL_INCLUDE_DIRS - The sfil include directories
#  SFIL_LIBRARIES - The libraries needed to use sfil
# Unless we are unable to find JPEG, ZLIB, PNG or SF2D

if(NOT DEVKITPRO)
    include(msys_to_cmake_path)
    msys_to_cmake_path("$ENV{DEVKITPRO}" DEVKITPRO)
endif()

include(LibFindMacros)

# sfil requires jpeg, zlib (because of png), png and sf2d
libfind_package(SFIL JPEG)
libfind_package(SFIL ZLIB)
libfind_package(SFIL PNG)
libfind_package(SFIL SF2D)

# sfil gets installed to ${DEVKITPRO}/libctru
set(SFIL_PATHS $ENV{SFIL} ${DEVKITPRO}/libctru ${DEVKITPRO}/ctrulib)

find_path(SFIL_INCLUDE_DIR sfil.h
          PATHS ${SFIL_PATHS}
          PATH_SUFFIXES include)

find_library(SFIL_LIBRARY NAMES sfil libsfil.a
          PATHS ${SFIL_PATHS}
          PATH_SUFFIXES lib)

set(SFIL_PROCESS_INCLUDES SFIL_INCLUDE_DIR)
set(SFIL_PROCESS_LIBS SFIL_LIBRARY)

set(JPEG_INCLUDE_OPTS JPEG_INCLUDE_DIR)
set(JPEG_LIBRARY_OPTS JPEG_LIBRARY)

set(LIBM_LIBRARY m)

set(PNG_INCLUDE_OPTS PNG_INCLUDE_DIR)
set(PNG_LIBRARY_OPTS PNG_LIBRARY LIBM_LIBRARY)

libfind_process(SFIL)
