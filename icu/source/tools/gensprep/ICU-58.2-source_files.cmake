# Copyright (c) 2018, NikitaFeodonit. All rights reserved.
#
## ICU build file for CMake build tools

target_sources(${exe_NAME}
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/gensprep.c
    ${CMAKE_CURRENT_LIST_DIR}/store.c

  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/gensprep.h
)
