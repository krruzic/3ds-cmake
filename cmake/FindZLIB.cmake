# - Try to find zlib
# You can set ZLIB_ROOT to specify a certain directory to look in first.
# Once done this will define
#  ZLIB_FOUND - System has zlib
#  ZLIB_INCLUDE_DIRS - The zlib include directories
#  ZLIB_LIBRARIES - The libraries needed to use zlib

if(NOT 3DS)
    message(FATAL_ERROR "This module can only be used if you are using the 3DS toolchain file. Please erase this build directory or create another one, and then use -DCMAKE_TOOLCHAIN_FILE=DevkitArm3DS.cmake when calling cmake for the 1st time. For more information, see the Readme.md for more information.")
endif()

include(LibFindMacros)

set(_ZLIB_SEARCHES)

# Search ZLIB_ROOT first if it is set.
if(ZLIB_ROOT)
  set(_ZLIB_SEARCH_ROOT
    PATHS ${ZLIB_ROOT}
    NO_DEFAULT_PATH
    NO_CMAKE_FIND_ROOT_PATH)
  list(APPEND _ZLIB_SEARCHES _ZLIB_SEARCH_ROOT)
endif()

# Search below ${DEVKITPRO}, ${DEVKITARM}, portlibs (if enabled) etc.
set(_ZLIB_SEARCH_NORMAL
  PATHS /
  NO_DEFAULT_PATH
  ONLY_CMAKE_FIND_ROOT_PATH)
list(APPEND _ZLIB_SEARCHES _ZLIB_SEARCH_NORMAL)

foreach(search ${_ZLIB_SEARCHES})
  find_path(ZLIB_INCLUDE_DIR NAMES zlib.h
    ${${search}}
    PATH_SUFFIXES include)
  find_library(ZLIB_LIBRARY NAMES z libz.a
    ${${search}}
    PATH_SUFFIXES lib)
endforeach()

set(ZLIB_PROCESS_INCLUDES ZLIB_INCLUDE_DIR)
set(ZLIB_PROCESS_LIBS ZLIB_LIBRARY)

libfind_process(ZLIB)
