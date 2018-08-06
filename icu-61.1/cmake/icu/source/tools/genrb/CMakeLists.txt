# Copyright (c) 2018, NikitaFeodonit. All rights reserved.
#
## ICU build file for CMake build tools

foreach(exe_NAME "genrb" "derb")
  if(exe_NAME STREQUAL "derb" AND NOT ICU_ENABLE_ICUIO)
    continue()
  endif()
  
  add_executable(${exe_NAME} "")

  ### Common executables options
  include(${PROJECT_SOURCE_DIR}/common_tools_exe_flags.cmake)
  #include(${PROJECT_SOURCE_DIR}/common_tools_exe_libs.cmake)  # Included below.

  ### Executable's specifics

  # PRIVATE flags
  set_property(TARGET ${lib_NAME} APPEND PROPERTY
    COMPILE_DEFINITIONS
      UNISTR_FROM_CHAR_EXPLICIT=explicit
      UNISTR_FROM_STRING_EXPLICIT=explicit
  )
  
  ### Include directories
  # PRIVATE
  target_include_directories(${exe_NAME} PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}
    ${PROJECT_SOURCE_DIR}/common
    ${PROJECT_SOURCE_DIR}/i18n
    ${PROJECT_SOURCE_DIR}/tools/toolutil
    ${PROJECT_SOURCE_DIR}/io
  )
  
  ### Link libraries
  # PRIVATE
  if(exe_NAME STREQUAL "derb")
    # $(LIBICUIO) $(LIBS)
    target_link_libraries(${exe_NAME} PRIVATE ${ICULIBS_IO})
  endif()

  # Common libs must be after the ${ICULIBS_IO}
  include(${PROJECT_SOURCE_DIR}/common_tools_exe_libs.cmake)

  if(exe_NAME STREQUAL "genrb")
    target_sources(${exe_NAME}
      PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/genrb.cpp
        ${CMAKE_CURRENT_LIST_DIR}/parse.cpp
        ${CMAKE_CURRENT_LIST_DIR}/prscmnts.cpp
        ${CMAKE_CURRENT_LIST_DIR}/reslist.cpp
        ${CMAKE_CURRENT_LIST_DIR}/wrtjava.cpp
        ${CMAKE_CURRENT_LIST_DIR}/wrtxml.cpp
        ${CMAKE_CURRENT_LIST_DIR}/errmsg.c
        ${CMAKE_CURRENT_LIST_DIR}/rbutil.c
        ${CMAKE_CURRENT_LIST_DIR}/read.c
        ${CMAKE_CURRENT_LIST_DIR}/rle.c
        ${CMAKE_CURRENT_LIST_DIR}/ustr.c
    
      PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/errmsg.h
        ${CMAKE_CURRENT_LIST_DIR}/genrb.h
        ${CMAKE_CURRENT_LIST_DIR}/parse.h
        ${CMAKE_CURRENT_LIST_DIR}/prscmnts.h
        ${CMAKE_CURRENT_LIST_DIR}/rbutil.h
        ${CMAKE_CURRENT_LIST_DIR}/read.h
        ${CMAKE_CURRENT_LIST_DIR}/reslist.h
        ${CMAKE_CURRENT_LIST_DIR}/rle.h
        ${CMAKE_CURRENT_LIST_DIR}/ustr.h
    )
  endif()

  if(exe_NAME STREQUAL "derb")
    target_sources(${exe_NAME}
      PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/derb.cpp
    )
  endif()

  install(
    TARGETS ${exe_NAME}
    EXPORT "${TARGETS_EXPORT_NAME}"
    ARCHIVE  DESTINATION "${libdir}"
    LIBRARY  DESTINATION "${libdir}"
    RUNTIME  DESTINATION "${bindir}"
    INCLUDES DESTINATION "${includedir}"
  )
endforeach()
