# Copyright (c) 2018, NikitaFeodonit. All rights reserved.
#
## ICU build file for CMake build tools

### Common executables flags

# PRIVATE flags
set_property(TARGET ${exe_NAME} APPEND PROPERTY
  COMPILE_DEFINITIONS ${CPPFLAGS}
)
set_property(TARGET ${exe_NAME} APPEND PROPERTY
  COMPILE_OPTIONS $<$<COMPILE_LANGUAGE:C>:${CFLAGS}>
)
set_property(TARGET ${exe_NAME} APPEND PROPERTY
  COMPILE_OPTIONS $<$<COMPILE_LANGUAGE:CXX>:${CXXFLAGS}>
)
set_property(TARGET ${exe_NAME} APPEND_STRING PROPERTY
  LINK_FLAGS ${LDFLAGS}
)
