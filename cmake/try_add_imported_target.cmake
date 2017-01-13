macro(try_add_imported_target LIBNAME)
  string(TOLOWER ${LIBNAME} LIBNAME_lwr)
  if(${LIBNAME}_FOUND AND NOT TARGET 3ds::${LIBNAME_lwr})
    add_library(3ds::${LIBNAME_lwr} STATIC IMPORTED GLOBAL)
    set_target_properties(3ds::${LIBNAME_lwr} PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${${LIBNAME}_INCLUDE_DIRS}"
      IMPORTED_LOCATION "${${LIBNAME}_LIBRARY}")
  endif()
endmacro()
