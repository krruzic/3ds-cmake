# - Try to find sfil
# Once done this will define
#  LIBSFIL_FOUND - System has sfil
#  LIBSFIL_INCLUDE_DIRS - The sfil include directories
#  LIBSFIL_LIBRARIES - The libraries needed to use sfil

if(NOT DEVKITPRO)
    include("${CMAKE_CURRENT_LIST_DIR}/msys_to_cmake_path.cmake")
    msys_to_cmake_path("$ENV{DEVKITPRO}" DEVKITPRO)
endif()

if(NOT WITH_PORTLIBS)
    message(FATAL_ERROR "SFILLIB requires WITH_PORTLIBS to be enabled.")
endif()

# sfil requires jpeg
find_package(JPEG REQUIRED)

# sfil requires png
find_package(PNG REQUIRED)

# sfil requires sf2d
find_package(SF2D REQUIRED)

# sfil gets installed to ${DEVKITPRO}/libctru so check the ${CTRULIB_PATHS} aswell
set(SFIL_PATHS $ENV{SFIL} sfillib libsfil ${CTRULIB_PATHS})

find_path(LIBSFIL_INCLUDE_DIR sfil.h
          PATHS ${SFIL_PATHS}
          PATH_SUFFIXES include )

find_library(LIBSFIL_LIBRARY NAMES sfil libsfil.a
          PATHS ${SFIL_PATHS}
          PATH_SUFFIXES lib)

# png requires libm
set(LIBSFIL_LIBRARIES ${LIBSFIL_LIBRARY} ${LIBSF2D_LIBRARIES} ${PNG_LIBRARIES} m ${JPEG_LIBRARIES} )
set(LIBSFIL_INCLUDE_DIRS ${LIBSFIL_INCLUDE_DIR} ${LIBSF2D_INCLUDE_DIRS} ${PNG_INCLUDE_DIRS} ${JPEG_INCLUDE_DIRS} )

# remove duplicates from _LIBRARIES and _INCLUDE_DIRS
list(REMOVE_DUPLICATES LIBSFIL_LIBRARIES)
list(REMOVE_DUPLICATES LIBSFIL_INCLUDE_DIRS)

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBSFIL_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(SFIL  DEFAULT_MSG
                                  LIBSFIL_LIBRARY LIBSFIL_INCLUDE_DIR
                                  SF2D_FOUND PNG_FOUND JPEG_FOUND)

mark_as_advanced(LIBSFIL_INCLUDE_DIR LIBSFIL_LIBRARY )
if(SFIL_FOUND)
    set(SFIL ${LIBSFIL_INCLUDE_DIR}/..)
    message(STATUS "setting SFIL to ${SFIL}")
endif()
