# - Try to find sftd
# Once done this will define
#  LIBSFTD_FOUND - System has sftd
#  LIBSFTD_INCLUDE_DIRS - The sftd include directories
#  LIBSFTD_LIBRARIES - The libraries needed to use sftd

if(NOT DEVKITPRO)
    include("${CMAKE_CURRENT_LIST_DIR}/msys_to_cmake_path.cmake")
    msys_to_cmake_path("$ENV{DEVKITPRO}" DEVKITPRO)
endif()

if(NOT WITH_PORTLIBS)
    message(FATAL_ERROR "SFTDLIB requires WITH_PORTLIBS to be enabled.")
endif()

# freetype requires zlib
find_package(ZLIB REQUIRED)

# sftd requires freetype
find_package(Freetype REQUIRED)

# sftd requires sf2d
find_package(SF2D REQUIRED)

# sftd gets installed to ${DEVKITPRO}/libctru so check the ${CTRULIB_PATHS} aswell
set(SFTD_PATHS $ENV{SFTD} sftdlib libsftd ${CTRULIB_PATHS})

find_path(LIBSFTD_INCLUDE_DIR sftd.h
          PATHS ${SFTD_PATHS}
          PATH_SUFFIXES include )

find_library(LIBSFTD_LIBRARY NAMES sftd libsftd.a
          PATHS ${SFTD_PATHS}
          PATH_SUFFIXES lib)

set(LIBSFTD_LIBRARIES ${LIBSFTD_LIBRARY} ${LIBSF2D_LIBRARIES} ${FREETYPE_LIBRARIES} ${ZLIB_LIBRARIES} )
set(LIBSFTD_INCLUDE_DIRS ${LIBSFTD_INCLUDE_DIR} ${LIBSF2D_INCLUDE_DIRS} ${FREETYPE_INCLUDE_DIRS} ${ZLIB_INCLUDE_DIRS} )

# remove duplicates from _LIBRARIES and _INCLUDE_DIRS
list(REMOVE_DUPLICATES LIBSFTD_LIBRARIES)
list(REMOVE_DUPLICATES LIBSFTD_INCLUDE_DIRS)

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBSFTD_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(SFTD  DEFAULT_MSG
                                  LIBSFTD_LIBRARY LIBSFTD_INCLUDE_DIR
                                  SF2D_FOUND FREETYPE_FOUND ZLIB_FOUND)

mark_as_advanced(LIBSFTD_INCLUDE_DIR LIBSFTD_LIBRARY )
if(SFTD_FOUND)
    set(SFTD ${LIBSFTD_INCLUDE_DIR}/..)
    message(STATUS "setting SFTD to ${SFTD}")
endif()
