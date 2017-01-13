# - Try to find sf2d
# Once done this will define
#  SF2D_FOUND - System has sf2d
#  SF2D_INCLUDE_DIRS - The sf2d include directories
#  SF2D_LIBRARIES - The libraries needed to use sf2d
# Unless we are unable to find CITRO3D

if(NOT DEVKITPRO)
    include("${CMAKE_CURRENT_LIST_DIR}/msys_to_cmake_path.cmake")
    msys_to_cmake_path("$ENV{DEVKITPRO}" DEVKITPRO)
endif()

include(LibFindMacros)

# sf2d requires citro3d
libfind_package(SF2D CITRO3D)

# sf2d gets installed to ${DEVKITPRO}/libctru
set(SF2D_PATHS $ENV{SF2D} ${DEVKITPRO}/libctru ${DEVKITPRO}/ctrulib)

find_path(SF2D_INCLUDE_DIR sf2d.h
          PATHS ${SF2D_PATHS}
          PATH_SUFFIXES include)

find_library(SF2D_LIBRARY NAMES sf2d libsf2d.a
          PATHS ${SF2D_PATHS}
          PATH_SUFFIXES lib)

set(SF2D_PROCESS_INCLUDES SF2D_INCLUDE_DIR)
set(SF2D_PROCESS_LIBS SF2D_LIBRARY)

libfind_process(SF2D)
