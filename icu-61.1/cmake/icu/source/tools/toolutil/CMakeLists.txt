# Copyright (c) 2018, NikitaFeodonit. All rights reserved.
#
## ICU build file for CMake build tools

set(lib_NAME ${ICULIBS_TOOLUTIL})
set(lib_NAME_SUFFIX ${TOOLUTIL_STUBNAME})

add_library(${lib_NAME} "")

set_target_properties(${lib_NAME} PROPERTIES
  EXPORT_NAME ${lib_NAME_SUFFIX}
  OUTPUT_NAME ${lib_NAME}${ICULIBSUFFIX_DEBUG}
)

### Common libraries options
include(${PROJECT_SOURCE_DIR}/common_icu_lib_flags.cmake)
#include(${PROJECT_SOURCE_DIR}/common_icu_lib_includes.cmake)  # Not included.

### Library's specific flags
# PRIVATE flags
set_property(TARGET ${lib_NAME} APPEND PROPERTY
  COMPILE_DEFINITIONS
    U_TOOLUTIL_IMPLEMENTATION
    UNISTR_FROM_CHAR_EXPLICIT=explicit
    UNISTR_FROM_STRING_EXPLICIT=explicit

    # TODO:
    # from icuinfo
    #CPPFLAGS+=  "-DU_BUILD=\"@build@\"" "-DU_HOST=\"@host@\"" "-DU_CC=\"@CC@\"" "-DU_CXX=\"@CXX@\""
    #CPPFLAGS+=  "-DU_BUILD=\"x86_64-pc-linux-gnu\"" "-DU_HOST=\"x86_64-pc-linux-gnu\"" "-DU_CC=\"clang\"" "-DU_CXX=\"clang++\""
)
set_property(TARGET ${lib_NAME} APPEND_STRING PROPERTY
  LINK_FLAGS ${LDFLAGSICUTOOLUTIL}
)

### Include directories
# PRIVATE
target_include_directories(${lib_NAME} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}
  ${PROJECT_SOURCE_DIR}/common
  ${PROJECT_SOURCE_DIR}/i18n
)

### Link libraries
# PUBLIC
# LIBS = $(LIBICUI18N) $(LIBICUUC) $(DEFAULT_LIBS)
target_link_libraries(${lib_NAME} PUBLIC ${ICULIBS_I18N})

target_sources(${lib_NAME}
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/collationinfo.cpp
    ${CMAKE_CURRENT_LIST_DIR}/dbgutil.cpp
    ${CMAKE_CURRENT_LIST_DIR}/denseranges.cpp
    ${CMAKE_CURRENT_LIST_DIR}/filestrm.cpp
    ${CMAKE_CURRENT_LIST_DIR}/filetools.cpp
    ${CMAKE_CURRENT_LIST_DIR}/flagparser.cpp
    ${CMAKE_CURRENT_LIST_DIR}/package.cpp
    ${CMAKE_CURRENT_LIST_DIR}/pkg_genc.cpp
    ${CMAKE_CURRENT_LIST_DIR}/pkg_gencmn.cpp
    ${CMAKE_CURRENT_LIST_DIR}/pkg_icu.cpp
    ${CMAKE_CURRENT_LIST_DIR}/pkgitems.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ppucd.cpp
    ${CMAKE_CURRENT_LIST_DIR}/swapimpl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/toolutil.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ucbuf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ucln_tu.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ucm.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ucmstate.cpp
    ${CMAKE_CURRENT_LIST_DIR}/udbgutil.cpp
    ${CMAKE_CURRENT_LIST_DIR}/unewdata.cpp
    ${CMAKE_CURRENT_LIST_DIR}/uoptions.cpp
    ${CMAKE_CURRENT_LIST_DIR}/uparse.cpp
    ${CMAKE_CURRENT_LIST_DIR}/writesrc.cpp
    ${CMAKE_CURRENT_LIST_DIR}/xmlparser.cpp

  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/collationinfo.h
    ${CMAKE_CURRENT_LIST_DIR}/dbgutil.h
    ${CMAKE_CURRENT_LIST_DIR}/denseranges.h
    ${CMAKE_CURRENT_LIST_DIR}/filestrm.h
    ${CMAKE_CURRENT_LIST_DIR}/filetools.h
    ${CMAKE_CURRENT_LIST_DIR}/flagparser.h
    ${CMAKE_CURRENT_LIST_DIR}/package.h
    ${CMAKE_CURRENT_LIST_DIR}/pkg_genc.h
    ${CMAKE_CURRENT_LIST_DIR}/pkg_gencmn.h
    ${CMAKE_CURRENT_LIST_DIR}/pkg_icu.h
    ${CMAKE_CURRENT_LIST_DIR}/pkg_imp.h
    ${CMAKE_CURRENT_LIST_DIR}/ppucd.h
    ${CMAKE_CURRENT_LIST_DIR}/swapimpl.h
    ${CMAKE_CURRENT_LIST_DIR}/toolutil.h
    ${CMAKE_CURRENT_LIST_DIR}/ucbuf.h
    ${CMAKE_CURRENT_LIST_DIR}/ucm.h
    ${CMAKE_CURRENT_LIST_DIR}/udbgutil.h
    ${CMAKE_CURRENT_LIST_DIR}/unewdata.h
    ${CMAKE_CURRENT_LIST_DIR}/uoptions.h
    ${CMAKE_CURRENT_LIST_DIR}/uparse.h
    ${CMAKE_CURRENT_LIST_DIR}/writesrc.h
    ${CMAKE_CURRENT_LIST_DIR}/xmlparser.h
)

install(
  TARGETS ${lib_NAME}
  EXPORT "${TARGETS_EXPORT_NAME}"
  ARCHIVE  DESTINATION "${libdir}"
  LIBRARY  DESTINATION "${libdir}"
  RUNTIME  DESTINATION "${bindir}"
  INCLUDES DESTINATION "${includedir}"
)
