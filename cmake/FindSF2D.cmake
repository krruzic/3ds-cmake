# - Try to find sf2d
# Once done this will define
#  LIBSF2D_FOUND - System has sf2d
#  LIBSF2D_INCLUDE_DIRS - The sf2d include directories
#  LIBSF2D_LIBRARIES - The libraries needed to use sf2d

# DevkitPro paths are broken on windows, so we have to fix those
macro(msys_to_cmake_path MsysPath ResultingPath)
    string(REGEX REPLACE "^/([a-zA-Z])/" "\\1:/" ${ResultingPath} "${MsysPath}")
endmacro()

if(NOT DEVKITPRO)
    msys_to_cmake_path("$ENV{DEVKITPRO}" DEVKITPRO)
endif()

# sf2d requires citro3d
find_package(CITRO3D REQUIRED)

# sf2d gets installed to ${DEVKITPRO}/libctru so check the ${CTRULIB_PATHS} aswell
set(SF2D_PATHS $ENV{SF2D} sf2dlib libsf2d ${CTRULIB_PATHS})

find_path(LIBSF2D_INCLUDE_DIR sf2d.h
          PATHS ${SF2D_PATHS}
          PATH_SUFFIXES include )

find_library(LIBSF2D_LIBRARY NAMES sf2d libsf2d.a
          PATHS ${SF2D_PATHS}
          PATH_SUFFIXES lib)

set(LIBSF2D_LIBRARIES ${LIBSF2D_LIBRARY} ${LIBCITRO3D_LIBRARIES} )
set(LIBSF2D_INCLUDE_DIRS ${LIBSF2D_INCLUDE_DIR} ${LIBCITRO3D_INCLUDE_DIRS} )

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBSF2D_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(SF2D  DEFAULT_MSG
                                  LIBSF2D_LIBRARY LIBSF2D_INCLUDE_DIR
                                  CITRO3D_FOUND)

mark_as_advanced(LIBSF2D_INCLUDE_DIR LIBSF2D_LIBRARY )
if(SF2D_FOUND)
    set(SF2D ${LIBSF2D_INCLUDE_DIR}/..)
    message(STATUS "setting SF2D to ${SF2D}")
endif()
