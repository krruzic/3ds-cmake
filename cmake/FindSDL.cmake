# - Try to find SDL
# You can set SDL_ROOT to specify a certain directory to look in first.
# Once done this will define
#  SDL_FOUND - System has SDL
#  SDL_INCLUDE_DIRS - The SDL include directories
#  SDL_LIBRARIES - The libraries needed to use SDL
# It also adds an imported target named `3ds::SDL`, Linking against it is
# equivalent to:
# target_link_libraries(mytarget ${SDL_LIBRARY})
# target_include_directories(mytarget PRIVATE ${SDL_INCLUDE_DIRS})

if (NOT 3DS)
    message(FATAL_ERROR "This module can only be used if you are using the 3DS toolchain file. Please erase this build directory or create another one, and then use -DCMAKE_TOOLCHAIN_FILE=DevkitArm3DS.cmake when calling cmake for the 1st time. For more information, see the Readme.md for more information.")
endif ()

include(LibFindMacros)
include(try_add_imported_target)

libfind_package(SDL CITRO3D)
libfind_package(SDL PNG)
libfind_package(SDL JPEG)
libfind_package(SDL Freetype)

set(_SDL_SEARCHES)

# Search SDL_ROOT first if it is set.
if (SDL_ROOT)
    set(_SDL_SEARCH_ROOT
            PATHS ${SDL_ROOT}
            NO_DEFAULT_PATH
            NO_CMAKE_FIND_ROOT_PATH)
    list(APPEND _SDL_SEARCHES _SDL_SEARCH_ROOT)
endif ()

# Search below ${DEVKITPRO}, ${DEVKITARM}, portlibs (if enabled) etc.
set(_SDL_SEARCH_NORMAL
        PATHS /
        NO_DEFAULT_PATH
        ONLY_CMAKE_FIND_ROOT_PATH)
list(APPEND _SDL_SEARCHES _SDL_SEARCH_NORMAL)

# find every sdl library
foreach (search ${_SDL_SEARCHES})
    find_path(SDL_INCLUDE_DIR NAMES SDL/SDL.h
            ${${search}}
            PATH_SUFFIXES include/)
    find_library(SDL_LIBRARY NAMES libSDL.a libSDLmain.a ${${search}} PATH_SUFFIXES lib)
    find_library(SDL_IMG_LIBRARY NAMES libSDL_image.a ${${search}} PATH_SUFFIXES lib)
    find_library(SDL_GFX_LIBRARY NAMES libSDL_gfx.a ${${search}} PATH_SUFFIXES lib)
    find_library(SDL_TTF_LIBRARY NAMES libSDL_ttf.a ${${search}} PATH_SUFFIXES lib)
    find_library(SDL_MIXER_LIBRARY NAMES libSDL_mixer.a ${${search}} PATH_SUFFIXES lib)
endforeach ()

# setup each lib to be imported
set(SDL_PROCESS_INCLUDES SDL_INCLUDE_DIR)
set(SDL_IMG_PROCESS_INCLUDES SDL_INCLUDE_DIR)
set(SDL_GFX_PROCESS_INCLUDES SDL_INCLUDE_DIR)
set(SDL_TTF_PROCESS_INCLUDES SDL_INCLUDE_DIR)
set(SDL_MIXER_PROCESS_INCLUDES SDL_INCLUDE_DIR)


set(SDL_PROCESS_LIBS SDL_LIBRARY)
set(SDL_IMG_PROCESS_LIBS SDL_IMG_LIBRARY)
set(SDL_GFX_PROCESS_LIBS SDL_GFX_LIBRARY)
set(SDL_TTF_PROCESS_LIBS SDL_TTF_LIBRARY)
set(SDL_MIXER_PROCESS_LIBS SDL_MIXER_LIBRARY)

libfind_process(SDL)
libfind_process(SDL_IMG)
libfind_process(SDL_TTF)
libfind_process(SDL_MIXER)

try_add_imported_target(SDL)
try_add_imported_target(SDL_IMG)
try_add_imported_target(SDL_TTF)
try_add_imported_target(SDL_MIXER)