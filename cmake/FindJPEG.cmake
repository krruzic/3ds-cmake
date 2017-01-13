# - Try to find jpeg
# You can set JPEG_ROOT to specify a certain directory to look in first.
# Once done this will define
#  JPEG_FOUND - System has jpeg
#  JPEG_INCLUDE_DIRS - The jpeg include directories
#  JPEG_LIBRARIES - The libraries needed to use jpeg

if(NOT 3DS)
    message(FATAL_ERROR "This module can only be used if you are using the 3DS toolchain file. Please erase this build directory or create another one, and then use -DCMAKE_TOOLCHAIN_FILE=DevkitArm3DS.cmake when calling cmake for the 1st time. For more information, see the Readme.md for more information.")
endif()

include(LibFindMacros)

set(_JPEG_SEARCHES)

# Search JPEG_ROOT first if it is set.
if(JPEG_ROOT)
  set(_JPEG_SEARCH_ROOT
    PATHS ${JPEG_ROOT}
    NO_DEFAULT_PATH
    NO_CMAKE_FIND_ROOT_PATH)
  list(APPEND _JPEG_SEARCHES _JPEG_SEARCH_ROOT)
endif()

# Search below ${DEVKITPRO}, ${DEVKITARM}, portlibs (if enabled) etc.
set(_JPEG_SEARCH_NORMAL
  PATHS /
  NO_DEFAULT_PATH
  ONLY_CMAKE_FIND_ROOT_PATH)
list(APPEND _JPEG_SEARCHES _JPEG_SEARCH_NORMAL)

foreach(search ${_JPEG_SEARCHES})
  find_path(JPEG_INCLUDE_DIR NAMES jpeglib.h
    ${${search}}
    PATH_SUFFIXES include)
  find_library(JPEG_LIBRARY NAMES jpeg libjpeg.a
    ${${search}}
    PATH_SUFFIXES lib)
endforeach()

set(JPEG_PROCESS_INCLUDES JPEG_INCLUDE_DIR)
set(JPEG_PROCESS_LIBS JPEG_LIBRARY)

libfind_process(JPEG)
