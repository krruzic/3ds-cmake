# - Try to find citro3d
# Once done this will define
#  CITRO3D_FOUND - System has citro3d
#  CITRO3D_INCLUDE_DIRS - The citro3d include directories
#  CITRO3D_LIBRARIES - The libraries needed to use citro3d
# Unless we are unable to find CTRULIB

if(NOT DEVKITPRO)
    include("${CMAKE_CURRENT_LIST_DIR}/msys_to_cmake_path.cmake")
    msys_to_cmake_path("$ENV{DEVKITPRO}" DEVKITPRO)
endif()

include(LibFindMacros)

# citro3d requires ctrulib
libfind_package(CITRO3D CTRULIB)

# citro3d gets installed to ${DEVKITPRO}/libctru
set(CITRO3D_PATHS $ENV{CITRO3D} ${DEVKITPRO}/libctru ${DEVKITPRO}/ctrulib)

find_path(CITRO3D_INCLUDE_DIR citro3d.h
          PATHS ${CITRO3D_PATHS}
          PATH_SUFFIXES include)

find_library(CITRO3D_LIBRARY NAMES citro3d libcitro3d.a
          PATHS ${CITRO3D_PATHS}
          PATH_SUFFIXES lib)

set(CITRO3D_PROCESS_INCLUDES CITRO3D_INCLUDE_DIR)
set(CITRO3D_PROCESS_LIBS CITRO3D_LIBRARY)

libfind_process(CITRO3D)
