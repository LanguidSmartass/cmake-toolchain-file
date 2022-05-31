if(NOT $ENV{cmake-toolchain-root})
    message(WARNING "To use this toolchain file you should specify 'cmake-toolchain-root' variable")
endif()

if(NOT $ENV{cmake-toolchain-prefix})
    message(WARNING "You should probably define a 'cmake-toolchain-prefix' variable as well")
endif()


if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")

    set(CMAKE_FIND_ROOT_PATH  ${cmake-toolchain-root})
    set(ext-exe ".exe")

elseif(
       (${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Linux")
    OR (${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Datwin")
)

    set(CMAKE_FIND_ROOT_PATH  ${cmake-toolchain-root})
    set(ext-exe "")

else()

    message(FATAL_ERROR "Unknown host system name: ${CMAKE_HOST_SYSTEM_NAME}")

endif()


# Set some helper variables, I'll get rid of them later with 'unset'
set(ar      ${cmake-toolchain-prefix}ar${ext-exe})
set(ccomp   ${cmake-toolchain-prefix}gcc${ext-exe})
set(cxxcomp ${cmake-toolchain-prefix}g++${ext-exe})
set(cxxfilt ${cmake-toolchain-prefix}c++filt${ext-exe})
set(gdb     ${cmake-toolchain-prefix}gdb${ext-exe})
set(nm      ${cmake-toolchain-prefix}nm${ext-exe})
set(objcopy ${cmake-toolchain-prefix}objcopy${ext-exe})
set(objdump ${cmake-toolchain-prefix}objdump${ext-exe})
set(readelf ${cmake-toolchain-prefix}readelf${ext-exe})
set(size    ${cmake-toolchain-prefix}size${ext-exe})


#set(CMAKE_CROSSCOMPILING   TRUE)
# this is a name of a target system,
# not a host on which the cmake and build takes place
set(CMAKE_SYSTEM_NAME      Generic)


# without setting CMAKE_TRY_COMPILE_TARGET_TYPE to STATIC_LIBRARY
# the CMake try_compile the none 'main' function will fail on
# a linking error like 'undefined reference to '_exit'
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)


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


# Cleanup
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

