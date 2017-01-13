# - Try to find ctrulib
# Once done this will define
#  CTRULIB_FOUND - System has ctrulib
#  CTRULIB_INCLUDE_DIRS - The ctrulib include directories
#  CTRULIB_LIBRARIES - The libraries needed to use ctrulib

if(NOT DEVKITPRO)
    include("${CMAKE_CURRENT_LIST_DIR}/msys_to_cmake_path.cmake")
    msys_to_cmake_path("$ENV{DEVKITPRO}" DEVKITPRO)
endif()

include(LibFindMacros)

set(CTRULIB_PATHS $ENV{CTRULIB} ${DEVKITPRO}/libctru ${DEVKITPRO}/ctrulib)

find_path(CTRULIB_INCLUDE_DIR 3ds.h
          PATHS ${CTRULIB_PATHS}
          PATH_SUFFIXES include)

find_library(CTRULIB_LIBRARY NAMES ctru libctru.a
          PATHS ${CTRULIB_PATHS}
          PATH_SUFFIXES lib)

set(CTRULIB_PROCESS_INCLUDES CTRULIB_INCLUDE_DIR)
set(CTRULIB_PROCESS_LIBS CTRULIB_LIBRARY)

libfind_process(CTRULIB)

if (CTRULIB_FOUND AND NOT DEFINED CTRULIB)
  set(CTRULIB ${CTRULIB_INCLUDE_DIR}/..)
  message(STATUS "Setting CTRULIB to ${CTRULIB}")
endif()
