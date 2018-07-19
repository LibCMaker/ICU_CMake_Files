# Copyright (c) 2018, NikitaFeodonit. All rights reserved.
#
## ICU build file for CMake build tools

set(lib_NAME ${ICULIBS_LX})
set(lib_NAME_SUFFIX ${LAYOUTEX_STUBNAME})

add_library(${lib_NAME} "")

set_target_properties(${lib_NAME} PROPERTIES EXPORT_NAME ${lib_NAME_SUFFIX})

### Common libraries options
include(${PROJECT_SOURCE_DIR}/common_icu_lib_flags.cmake)
include(${PROJECT_SOURCE_DIR}/common_icu_lib_includes.cmake)

### Library's specific flags
# PRIVATE flags
set_property(TARGET ${lib_NAME} APPEND PROPERTY
  COMPILE_DEFINITIONS
    U_LAYOUTEX_IMPLEMENTATION
)
set_property(TARGET ${lib_NAME} APPEND_STRING PROPERTY
  LINK_FLAGS ${LDFLAGSICULX}
)

### Include directories
# PRIVATE
target_include_directories(${lib_NAME} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}
  ${CMAKE_CURRENT_LIST_DIR}/unicode
  ${PROJECT_SOURCE_DIR}/common
)
if(NOT USING_ICULEHB)
  # cppflags: load .. so that #include <layout/...> works
  target_include_directories(${lib_NAME} PRIVATE
    ${PROJECT_SOURCE_DIR}
  )
else()
  target_include_directories(${lib_NAME} PRIVATE
    ${ICULEHB_CFLAGS} # TODO: check it
  )
endif()

### Link libraries
# PUBLIC
# LIBS = $(LIBICUUC) $(LIBICULE) $(DEFAULT_LIBS)
target_link_libraries(${lib_NAME} PUBLIC ${ICULIBS_UC} ${ICULIBS_LE})

target_sources(${lib_NAME}
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/LXUtilities.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ParagraphLayout.cpp
    ${CMAKE_CURRENT_LIST_DIR}/playout.cpp
    ${CMAKE_CURRENT_LIST_DIR}/plruns.cpp
    ${CMAKE_CURRENT_LIST_DIR}/RunArrays.cpp

  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/LXUtilities.h

  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/layout/ParagraphLayout.h
    ${CMAKE_CURRENT_LIST_DIR}/layout/playout.h
    ${CMAKE_CURRENT_LIST_DIR}/layout/plruns.h
    ${CMAKE_CURRENT_LIST_DIR}/layout/RunArrays.h
)

install(
  DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/layout
  DESTINATION "${includedir}"
  FILES_MATCHING
  PATTERN "*.h"
)

install(
  TARGETS ${lib_NAME}
  EXPORT "${TARGETS_EXPORT_NAME}"
  ARCHIVE  DESTINATION "${libdir}"
  LIBRARY  DESTINATION "${libdir}"
  RUNTIME  DESTINATION "${bindir}"
  INCLUDES DESTINATION "${includedir}"
)
