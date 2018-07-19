# Copyright (c) 2018, NikitaFeodonit. All rights reserved.
#
## ICU build file for CMake build tools

set(lib_NAME ${ICULIBS_CTESTFW})
set(lib_NAME_SUFFIX ${CTESTFW_STUBNAME})

add_library(${lib_NAME} "")

set_target_properties(${lib_NAME} PROPERTIES EXPORT_NAME ${lib_NAME_SUFFIX})

### Common libraries options
include(${PROJECT_SOURCE_DIR}/common_icu_lib_flags.cmake)
#include(${PROJECT_SOURCE_DIR}/common_icu_lib_includes.cmake)  # Not included.

### Library's specific flags
# PRIVATE flags
set_property(TARGET ${lib_NAME} APPEND PROPERTY
  COMPILE_DEFINITIONS ${CPPFLAGSCTESTFW}
    T_CTEST_IMPLEMENTATION
)
set_property(TARGET ${lib_NAME} APPEND_STRING PROPERTY
  LINK_FLAGS ${LDFLAGSCTESTFW}
)

### Include directories
# PRIVATE
target_include_directories(${lib_NAME} PRIVATE
  ${PROJECT_SOURCE_DIR}/common
  ${PROJECT_SOURCE_DIR}/i18n
  ${PROJECT_SOURCE_DIR}/tools/toolutil
  ${CMAKE_CURRENT_LIST_DIR}
)

### Link libraries
# PUBLIC
# LIBS = $(LIBICUTOOLUTIL) $(LIBICUI18N) $(LIBICUUC) $(DEFAULT_LIBS)
target_link_libraries(${lib_NAME} PUBLIC ${ICULIBS_TOOLUTIL})

target_sources(${lib_NAME}
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/datamap.cpp
    ${CMAKE_CURRENT_LIST_DIR}/testdata.cpp
    ${CMAKE_CURRENT_LIST_DIR}/tstdtmod.cpp
    ${CMAKE_CURRENT_LIST_DIR}/uperf.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ctest.c
    ${CMAKE_CURRENT_LIST_DIR}/ucln_ct.c

  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/unicode/ctest.h
    ${CMAKE_CURRENT_LIST_DIR}/unicode/datamap.h
    ${CMAKE_CURRENT_LIST_DIR}/unicode/testdata.h
    ${CMAKE_CURRENT_LIST_DIR}/unicode/testlog.h
    ${CMAKE_CURRENT_LIST_DIR}/unicode/testtype.h
    ${CMAKE_CURRENT_LIST_DIR}/unicode/tstdtmod.h
    ${CMAKE_CURRENT_LIST_DIR}/unicode/uperf.h
    ${CMAKE_CURRENT_LIST_DIR}/unicode/utimer.h
)

install(
  TARGETS ${lib_NAME}
  EXPORT "${TARGETS_EXPORT_NAME}"
  ARCHIVE  DESTINATION "${libdir}"
  LIBRARY  DESTINATION "${libdir}"
  RUNTIME  DESTINATION "${bindir}"
  INCLUDES DESTINATION "${includedir}"
)
