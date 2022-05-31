# toolchain-file.cmake
#
# @brief toolchain file for cmake options
#
# @author Ivan Novoselov, jedi.orden@gmail.com
#
# @date Apr 10, 2019
#
# @details
# Configure custom C/C++ toolchain, particularly useful in embedded development
#
# Usage:
# Pass these three options to cmake options (through terminal/console/IDE)
# Setting them in scripts won't take effect you desire
#
# # call to executable with arguments passed below:
# cmake
# # arg, path to the toolchain file from this repo
# --toolchain "cmake-toolchain-file/toolchain-file.cmake"
# # arg, toolchain prefix like "avr-", "arm-none-eabi-", etc.
# #      can be just an empty string ""
# -Dcmake-toolchain-prefix="toolchain-prefix"
# # arg, full path to your toolchain
# -Dcmake-toolchain-root="/path/to/your/toolchain" # or
# # name of the environment variable that contains the path mentioned
# -Dcmake-toolchain-root="TOOLCHAIN_PATH"
#
# Also, '--toolchain' and '-DCMAKE_TOOLCHAIN_FILE=' are equivalent
# cmake option expressions
#
##

message (
    STATUS
"Configuring custom toolchain"
)


if (NOT cmake-toolchain-root)
    message (FATAL_ERROR "'-Dcmake-toolchain-root' option not passed to cmake")
endif()


if (DEFINED ENV{${cmake-toolchain-root}})
    message (STATUS "'-Dcmake-toolchain-root' is an environment variable name")
endif()


if (NOT EXISTS ${cmake-toolchain-root})
    # try interpret the 'toolchain-root' as an environment variable name
    set (cmake-toolchain-root $ENV{${cmake-toolchain-root}})
endif ()


# check again
if (NOT EXISTS ${cmake-toolchain-root})
    message (
        FATAL_ERROR
"cmake-toolchan-root expands to: '${cmake-toolchain-root}'
To use this toolchain file you must specify 'cmake-toolchain-root' variable:
it must be either a string containing a full path to the toolchain or
a name of an environment variable that contains the mentioned path"
    )
endif ()


if (NOT cmake-toolchain-prefix)
    message (
        WARNING
"You should probably define a 'cmake-toolchain-prefix' variable as well"
    )
endif ()


set (CMAKE_FIND_ROOT_PATH  ${cmake-toolchain-root})


if (${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")

    set (ext-exe ".exe")

elseif(
       (${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Linux")
    OR (${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Datwin")
)

    set (ext-exe "")

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


