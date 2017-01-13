# - Try to find sftd
# You can set SFTD_ROOT to specify a certain directory to look in first.
# Once done this will define
#  SFTD_FOUND - System has sftd
#  SFTD_INCLUDE_DIRS - The sftd include directories
#  SFTD_LIBRARIES - The libraries needed to use sftd
# Unless we are unable to find ZLIB, FREETYPE or SF2D

if(NOT 3DS)
    message(FATAL_ERROR "This module can only be used if you are using the 3DS toolchain file. Please erase this build directory or create another one, and then use -DCMAKE_TOOLCHAIN_FILE=DevkitArm3DS.cmake when calling cmake for the 1st time. For more information, see the Readme.md for more information.")
endif()

include(LibFindMacros)

# sftd requires zlib (because of freetype), freetype and sf2d
libfind_package(SFTD ZLIB)
libfind_package(SFTD FREETYPE)
libfind_package(SFTD SF2D)

set(_SFTD_SEARCHES)

# Search SFTD_ROOT first if it is set.
if(SFTD_ROOT)
  set(_SFTD_SEARCH_ROOT
    PATHS ${SFTD_ROOT}
    NO_DEFAULT_PATH
    NO_CMAKE_FIND_ROOT_PATH)
  list(APPEND _SFTD_SEARCHES _SFTD_SEARCH_ROOT)
endif()

# Search below ${DEVKITPRO}, ${DEVKITARM} etc.
set(_SFTD_SEARCH_NORMAL
  PATHS / /libsftd /sftdlib /libctru /ctrulib
  NO_DEFAULT_PATH
  ONLY_CMAKE_FIND_ROOT_PATH)
list(APPEND _SFTD_SEARCHES _SFTD_SEARCH_NORMAL)

foreach(search ${_SFTD_SEARCHES})
  find_path(SFTD_INCLUDE_DIR NAMES sftd.h
    ${${search}}
    PATH_SUFFIXES include libsftd/include)
  find_library(SFTD_LIBRARY NAMES sftd libsftd.a
    ${${search}}
    PATH_SUFFIXES lib libsftd/lib)
endforeach()

set(SFTD_PROCESS_INCLUDES SFTD_INCLUDE_DIR)
set(SFTD_PROCESS_LIBS SFTD_LIBRARY)

set(FREETYPE_INCLUDE_OPTS FREETYPE_INCLUDE_DIR_freetype2)
set(FREETYPE_LIBRARY_OPTS FREETYPE_LIBRARY)

libfind_process(SFTD)
