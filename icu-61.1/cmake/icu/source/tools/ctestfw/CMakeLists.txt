# Copyright (c) 2018, NikitaFeodonit. All rights reserved.
#
## ICU build file for CMake build tools

set(lib_NAME ${ICULIBS_CTESTFW})
set(lib_NAME_SUFFIX ${CTESTFW_STUBNAME})

set(private_src_DIR "${CMAKE_CURRENT_LIST_DIR}")
set(interface_src_DIR "${includedir}")
set(build_src_DIR
  "$<BUILD_INTERFACE:${private_src_DIR}>"
)
set(install_src_DIR
  "$<INSTALL_INTERFACE:${interface_src_DIR}>"
)
set(public_src_DIR "${build_src_DIR}${install_src_DIR}")

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
  ${private_src_DIR}
)

### Link libraries
# PUBLIC
# LIBS = $(LIBICUTOOLUTIL) $(LIBICUI18N) $(LIBICUUC) $(DEFAULT_LIBS)
target_link_libraries(${lib_NAME} PUBLIC ${ICULIBS_TOOLUTIL})

target_sources(${lib_NAME}
  PRIVATE
    ${private_src_DIR}/datamap.cpp
    ${private_src_DIR}/testdata.cpp
    ${private_src_DIR}/tstdtmod.cpp
    ${private_src_DIR}/uperf.cpp
    ${private_src_DIR}/ctest.c
    ${private_src_DIR}/ucln_ct.c

  PUBLIC
    ${public_src_DIR}/unicode/ctest.h
    ${public_src_DIR}/unicode/datamap.h
    ${public_src_DIR}/unicode/testdata.h
    ${public_src_DIR}/unicode/testlog.h
    ${public_src_DIR}/unicode/testtype.h
    ${public_src_DIR}/unicode/tstdtmod.h
    ${public_src_DIR}/unicode/uperf.h
    ${public_src_DIR}/unicode/utimer.h
)

install(
  TARGETS ${lib_NAME}
  EXPORT "${TARGETS_EXPORT_NAME}"
  ARCHIVE  DESTINATION "${libdir}"
  LIBRARY  DESTINATION "${libdir}"
  RUNTIME  DESTINATION "${bindir}"
  INCLUDES DESTINATION "${includedir}"
)
