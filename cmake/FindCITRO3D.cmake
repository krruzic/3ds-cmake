# - Try to find citro3d
# Once done this will define
#  LIBCITRO3D_FOUND - System has citro3d
#  LIBCITRO3D_INCLUDE_DIRS - The citro3d include directories
#  LIBCITRO3D_LIBRARIES - The libraries needed to use citro3d

# DevkitPro paths are broken on windows, so we have to fix those
macro(msys_to_cmake_path MsysPath ResultingPath)
    string(REGEX REPLACE "^/([a-zA-Z])/" "\\1:/" ${ResultingPath} "${MsysPath}")
endmacro()

if(NOT DEVKITPRO)
    msys_to_cmake_path("$ENV{DEVKITPRO}" DEVKITPRO)
endif()

# citro3d requires ctrulib
find_package(CTRULIB REQUIRED)

# citro3d gets installed to ${DEVKITPRO}/libctru so check the ${CTRULIB_PATHS} aswell
set(CITRO3D_PATHS $ENV{CITRO3D} citro3d ${CTRULIB_PATHS})

find_path(LIBCITRO3D_INCLUDE_DIR citro3d.h
          PATHS ${CITRO3D_PATHS}
          PATH_SUFFIXES include )

find_library(LIBCITRO3D_LIBRARY NAMES citro3d libcitro3d.a
          PATHS ${CITRO3D_PATHS}
          PATH_SUFFIXES lib )

set(LIBCITRO3D_LIBRARIES ${LIBCITRO3D_LIBRARY} ${LIBCTRU_LIBRARIES})
set(LIBCITRO3D_INCLUDE_DIRS ${LIBCITRO3D_INCLUDE_DIR} ${LIBCTRU_INCLUDE_DIRS})

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBCITRO3D_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(CITRO3D  DEFAULT_MSG
                                  LIBCITRO3D_LIBRARY LIBCITRO3D_INCLUDE_DIR
                                  CTRULIB_FOUND)

mark_as_advanced(LIBCITRO3D_INCLUDE_DIR LIBCITRO3D_LIBRARY )
if(CITRO3D_FOUND)
    set(CITRO3D ${LIBCITRO3D_INCLUDE_DIR}/..)
    message(STATUS "setting CITRO3D to ${CITRO3D}")
endif()
