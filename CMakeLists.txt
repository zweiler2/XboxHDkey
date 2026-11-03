cmake_minimum_required(VERSION 3.16.0)
project(xboxhdkey VERSION 0.1.0)

include(CTest)
enable_testing()

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
add_executable(xboxhdkey
  src/apt.c src/sgio.c src/sysfs.c src/BootEEPROM.c
  src/BootHddKey.c src/rc4.c src/sha1.c src/main.c
)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)

install(TARGETS xboxhdkey RUNTIME DESTINATION bin)
