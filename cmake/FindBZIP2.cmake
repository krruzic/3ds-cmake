# - Try to find zlib
# You can set BZIP2_ROOT to specify a certain directory to look in first.
# Once done this will define
#  BZIP2_FOUND - System has zlib
#  BZIP2_INCLUDE_DIRS - The zlib include directories
#  BZIP2_LIBRARIES - The libraries needed to use zlib
# It also adds an imported target named `3ds::zlib`, Linking against it is
# equivalent to:
# target_link_libraries(mytarget ${BZIP2_LIBRARY})
# target_include_directories(mytarget PRIVATE ${BZIP2_INCLUDE_DIRS})

if (NOT 3DS)
    message(FATAL_ERROR "This module can only be used if you are using the 3DS toolchain file. Please erase this build directory or create another one, and then use -DCMAKE_TOOLCHAIN_FILE=DevkitArm3DS.cmake when calling cmake for the 1st time. For more information, see the Readme.md for more information.")
endif ()

include(LibFindMacros)
include(try_add_imported_target)

set(_BZIP2_SEARCHES)

# Search BZIP2_ROOT first if it is set.
if (BZIP2_ROOT)
    set(_BZIP2_SEARCH_ROOT
            PATHS ${BZIP2_ROOT}
            NO_DEFAULT_PATH
            NO_CMAKE_FIND_ROOT_PATH)
    list(APPEND _BZIP2_SEARCHES _BZIP2_SEARCH_ROOT)
endif ()

# Search below ${DEVKITPRO}, ${DEVKITARM}, portlibs (if enabled) etc.
set(_BZIP2_SEARCH_NORMAL
        PATHS /
        NO_DEFAULT_PATH
        ONLY_CMAKE_FIND_ROOT_PATH)
list(APPEND _BZIP2_SEARCHES _BZIP2_SEARCH_NORMAL)

foreach (search ${_BZIP2_SEARCHES})
    find_path(BZIP2_INCLUDE_DIR NAMES bzlib.h
            ${${search}}
            PATH_SUFFIXES include)
    find_library(BZIP2_LIBRARY NAMES libbz2.a
            ${${search}}
            PATH_SUFFIXES lib)
endforeach ()

set(BZIP2_PROCESS_INCLUDES BZIP2_INCLUDE_DIR)
set(BZIP2_PROCESS_LIBS BZIP2_LIBRARY)

libfind_process(BZIP2)

try_add_imported_target(BZIP2)
