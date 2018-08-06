# Copyright (c) 2018, NikitaFeodonit. All rights reserved.
#
## ICU build file for CMake build tools

# TODO: PLUGIN_OBJECTS = testplug.o

set(exe_NAME icuinfo)

add_executable(${exe_NAME} "")

### Common executables options
include(${PROJECT_SOURCE_DIR}/common_tools_exe_flags.cmake)
include(${PROJECT_SOURCE_DIR}/common_tools_exe_libs.cmake)

### Executable's specifics

### Include directories
# PRIVATE
target_include_directories(${exe_NAME} PRIVATE
  ${PROJECT_SOURCE_DIR}/common
  ${PROJECT_SOURCE_DIR}/tools/toolutil
  ${PROJECT_SOURCE_DIR}/tools/ctestfw
  ${PROJECT_SOURCE_DIR}/i18n
)

target_sources(${exe_NAME}
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/icuinfo.cpp
)

if(ICU_ENABLE_PLUGINS)
  # TODO: PLUGIN_OBJECTS = testplug.o
  # TODO: see source/tools/genrb/CMakeLists.txt with foreach()
  #target_sources(${exe_NAME}
  #PRIVATE
  #  ${CMAKE_CURRENT_LIST_DIR}/testplug.c
  #)
endif()

install(
  TARGETS ${exe_NAME}
  EXPORT "${TARGETS_EXPORT_NAME}"
  ARCHIVE  DESTINATION "${libdir}"
  LIBRARY  DESTINATION "${libdir}"
  RUNTIME  DESTINATION "${bindir}"
  INCLUDES DESTINATION "${includedir}"
)
