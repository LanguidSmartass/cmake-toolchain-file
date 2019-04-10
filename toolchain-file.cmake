set(binutils objcopy objdump size)

if(NOT $ENV{cmake-toolchain-root})
    message(WARNING "To use this toolchain file you should specify 'cmake-toolchain-root' variable")
endif()

if(NOT $ENV{cmake-toolchain-prefix})
    message(WARNING "You should probably define a 'cmake-toolchain-prefix' variable as well")
endif()

if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")
    set(exec_end ".exe")
elseif(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Linux")
    set(exec_end "")
else()
    message("${CMAKE_HOST_SYSTEM_NAME}" not supported yet)
endif()

# Set some helper variables, I'll get rid of them later with 'unset'
set(ar      ${cmake-toolchain-prefix}ar${exec_end})
set(ccomp   ${cmake-toolchain-prefix}gcc${exec_end})
set(cxxcomp ${cmake-toolchain-prefix}g++${exec_end})
set(cxxfilt ${cmake-toolchain-prefix}c++filt${exec_end})
set(gdb     ${cmake-toolchain-prefix}gdb${exec_end})
set(nm      ${cmake-toolchain-prefix}nm${exec_end})
set(objcopy ${cmake-toolchain-prefix}objcopy${exec_end})
set(objdump ${cmake-toolchain-prefix}objdump${exec_end})
set(readelf ${cmake-toolchain-prefix}readelf${exec_end})
set(size    ${cmake-toolchain-prefix}size${exec_end})

#set(CMAKE_CROSSCOMPILING   TRUE)
# this is a name of a target system, not a host one (which I compile and debug from)
set(CMAKE_SYSTEM_NAME      Generic)

# without setting CMAKE_TRY_COMPILE_TARGET_TYPE to STATIC_LIBRARY
# the CMake try_compile the none 'main' function will fail on
# a linking error like 'undefined reference to '_exit'
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")
    set(CMAKE_FIND_ROOT_PATH  ${cmake-toolchain-root})
elseif(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Linux")
    set(CMAKE_FIND_ROOT_PATH  ${cmake-toolchain-root})
else()
    message("${CMAKE_HOST_SYSTEM_NAME}" not supported yet)
endif()

set(CMAKE_C_COMPILER      ${CMAKE_FIND_ROOT_PATH}/bin/${ccomp})
set(CMAKE_CXX_COMPILER    ${CMAKE_FIND_ROOT_PATH}/bin/${cxxcomp})
set(CMAKE_ASM_COMPILER    ${CMAKE_C_COMPILER})


set(CMAKE_AR        ${CMAKE_FIND_ROOT_PATH}/bin/${ar})
set(CMAKE_CXXFILT   ${CMAKE_FIND_ROOT_PATH}/bin/${cxxfilt})
set(CMAKE_GDB       ${CMAKE_FIND_ROOT_PATH}/bin/${gdb})
set(CMAKE_NM        ${CMAKE_FIND_ROOT_PATH}/bin/${nm})
set(CMAKE_OBJCOPY   ${CMAKE_FIND_ROOT_PATH}/bin/${objcopy})
set(CMAKE_OBJDUMP   ${CMAKE_FIND_ROOT_PATH}/bin/${objdump})
set(CMAKE_READELF   ${CMAKE_FIND_ROOT_PATH}/bin/${readelf})
set(CMAKE_SIZE      ${CMAKE_FIND_ROOT_PATH}/bin/${size})

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

unset(ccomp)
unset(cxxcomp)
unset(cxxfilt)
unset(nm)
unset(ar)
unset(objcopy)
unset(objdump)
unset(size)
unset(gdb)
unset(readelf)

unset(cmake-toolchain-prefix)
unset(cmake-toolchain-root)
