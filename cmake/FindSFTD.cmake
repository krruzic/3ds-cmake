# - Try to find sftd
# Once done this will define
#  SFTD_FOUND - System has sftd
#  SFTD_INCLUDE_DIRS - The sftd include directories
#  SFTD_LIBRARIES - The libraries needed to use sftd
# Unless we are unable to find ZLIB, FREETYPE or SF2D

if(NOT DEVKITPRO)
    include("${CMAKE_CURRENT_LIST_DIR}/msys_to_cmake_path.cmake")
    msys_to_cmake_path("$ENV{DEVKITPRO}" DEVKITPRO)
endif()

include(LibFindMacros)

# sftd requires zlib (because of freetype), freetype and sf2d
libfind_package(SFTD ZLIB)
libfind_package(SFTD FREETYPE)
libfind_package(SFTD SF2D)

# sftd gets installed to ${DEVKITPRO}/libctru
set(SFTD_PATHS $ENV{SFTD} ${DEVKITPRO}/libctru ${DEVKITPRO}/ctrulib)

find_path(SFTD_INCLUDE_DIR sftd.h
          PATHS ${SFTD_PATHS}
          PATH_SUFFIXES include)

find_library(SFTD_LIBRARY NAMES sftd libsftd.a
          PATHS ${SFTD_PATHS}
          PATH_SUFFIXES lib)

set(SFTD_PROCESS_INCLUDES SFTD_INCLUDE_DIR)
set(SFTD_PROCESS_LIBS SFTD_LIBRARY)

set(FREETYPE_INCLUDE_OPTS FREETYPE_INCLUDE_DIR_freetype2)
set(FREETYPE_LIBRARY_OPTS FREETYPE_LIBRARY)

libfind_process(SFTD)
