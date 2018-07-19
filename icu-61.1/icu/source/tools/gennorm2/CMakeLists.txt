# Copyright (c) 2018, NikitaFeodonit. All rights reserved.
#
## ICU build file for CMake build tools

set(exe_NAME gennorm2)

add_executable(${exe_NAME} "")

### Common executables options
include(${PROJECT_SOURCE_DIR}/common_tools_exe_flags.cmake)
include(${PROJECT_SOURCE_DIR}/common_tools_exe_libs.cmake)

### Executable's specifics

### Include directories
# PRIVATE
target_include_directories(${exe_NAME} PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}
  ${PROJECT_SOURCE_DIR}/common
  ${PROJECT_SOURCE_DIR}/tools/toolutil
)

target_sources(${exe_NAME}
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/extradata.cpp
    ${CMAKE_CURRENT_LIST_DIR}/gennorm2.cpp
    ${CMAKE_CURRENT_LIST_DIR}/n2builder.cpp
    ${CMAKE_CURRENT_LIST_DIR}/norms.cpp

  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/extradata.h
    ${CMAKE_CURRENT_LIST_DIR}/n2builder.h
    ${CMAKE_CURRENT_LIST_DIR}/norms.h
)

install(
  TARGETS ${exe_NAME}
  EXPORT "${TARGETS_EXPORT_NAME}"
  ARCHIVE  DESTINATION "${libdir}"
  LIBRARY  DESTINATION "${libdir}"
  RUNTIME  DESTINATION "${bindir}"
  INCLUDES DESTINATION "${includedir}"
)
