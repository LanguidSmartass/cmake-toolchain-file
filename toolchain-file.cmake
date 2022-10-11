# toolchain-file.cmake
#
# @brief toolchain file for cmake options
#
# @author Ivan Novoselov, jedi.orden@gmail.com
#
# @date Apr 10, 2019
#
# @details
#
# Multiple cmake toolchain file runs results in missing variables:
# https://cmake.org/cmake/help/latest/variable/CMAKE_TRY_COMPILE_PLATFORM_VARIABLES.html
# https://stackoverflow.com/questions/66700152/why-is-the-toolchain-file-executed-a-few-times-in-cmake
#
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
# @copyright MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


message (STATUS "Configuring custom toolchain")


# Use list(APPEND) rather than set() so that any variables added by CMake aren't lost!
#
# Here is the docs for this variable:
# https://cmake.org/cmake/help/latest/variable/CMAKE_TRY_COMPILE_PLATFORM_VARIABLES.html
list (
    APPEND
    CMAKE_TRY_COMPILE_PLATFORM_VARIABLES
    "${cmake-toolchain-root}"
    "${cmake-toolchain-prefix}"
)
# because the same variables might get into the list twice
#list (REMOVE_DUPLICATES CMAKE_TRY_COMPILE_PLATFORM_VARIABLES)
# then reassign the same variables with values by exactly the same indices
# as they were added to the list
list (GET CMAKE_TRY_COMPILE_PLATFORM_VARIABLES 0 cmake-toolchain-root)
list (GET CMAKE_TRY_COMPILE_PLATFORM_VARIABLES 1 cmake-toolchain-prefix)


# set shorter aliases
set (tc-path   "${cmake-toolchain-root}")
set (tc-prefix "${cmake-toolchain-prefix}")


# first check if 'cmake-toolchain-root' is an environment variable name
if (DEFINED ENV{${tc-path}})
    # if it is, expand it and use it as a path
    set (tc-path $ENV{${tc-path}})
endif()


# where is the target environment located
set (CMAKE_FIND_ROOT_PATH "${tc-path}")


if (${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")

    set (ext-exe ".exe")

elseif(
       (${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Linux")
    OR (${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Darwin")
)

    set (ext-exe "")

else()

    message(FATAL_ERROR "Unknown host system name: ${CMAKE_HOST_SYSTEM_NAME}")

endif()


# Set some helper variables, I'll get rid of them later with 'unset'
set(ar        ${tc-prefix}ar${ext-exe}        )#PARENT_SCOPE)
set(ccomp     ${tc-prefix}gcc${ext-exe}       )#PARENT_SCOPE)
set(cxxcomp   ${tc-prefix}g++${ext-exe}       )#PARENT_SCOPE)
set(cxxfilt   ${tc-prefix}c++filt${ext-exe}   )#PARENT_SCOPE)
set(gdb       ${tc-prefix}gdb${ext-exe}       )#PARENT_SCOPE)
set(nm        ${tc-prefix}nm${ext-exe}        )#PARENT_SCOPE)
set(objcopy   ${tc-prefix}objcopy${ext-exe}   )#PARENT_SCOPE)
set(objdump   ${tc-prefix}objdump${ext-exe}   )#PARENT_SCOPE)
set(readelf   ${tc-prefix}readelf${ext-exe}   )#PARENT_SCOPE)
set(size      ${tc-prefix}size${ext-exe}      )#PARENT_SCOPE)


#set(CMAKE_CROSSCOMPILING   TRUE)
# this is a name of a target system,
# not a host on which the cmake and build takes place
set (CMAKE_SYSTEM_NAME ${cmake-toolchain-system})#PARENT_SCOPE)


# without setting CMAKE_TRY_COMPILE_TARGET_TYPE to STATIC_LIBRARY
# the CMake try_compile the none 'main' function will fail on
# a linking error like 'undefined reference to '_exit'
set (CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY )#PARENT_SCOPE)


set (CMAKE_C_COMPILER      ${CMAKE_FIND_ROOT_PATH}/bin/${ccomp}   )#PARENT_SCOPE)
set (CMAKE_CXX_COMPILER    ${CMAKE_FIND_ROOT_PATH}/bin/${cxxcomp} )#PARENT_SCOPE)
set (CMAKE_ASM_COMPILER    ${CMAKE_C_COMPILER}                    )#PARENT_SCOPE)


set (CMAKE_AR        ${CMAKE_FIND_ROOT_PATH}/bin/${ar}       )#PARENT_SCOPE)
set (CMAKE_CXXFILT   ${CMAKE_FIND_ROOT_PATH}/bin/${cxxfilt}  )#PARENT_SCOPE)
set (CMAKE_GDB       ${CMAKE_FIND_ROOT_PATH}/bin/${gdb}      )#PARENT_SCOPE)
set (CMAKE_NM        ${CMAKE_FIND_ROOT_PATH}/bin/${nm}       )#PARENT_SCOPE)
set (CMAKE_OBJCOPY   ${CMAKE_FIND_ROOT_PATH}/bin/${objcopy}  )#PARENT_SCOPE)
set (CMAKE_OBJDUMP   ${CMAKE_FIND_ROOT_PATH}/bin/${objdump}  )#PARENT_SCOPE)
set (CMAKE_READELF   ${CMAKE_FIND_ROOT_PATH}/bin/${readelf}  )#PARENT_SCOPE)
set (CMAKE_SIZE      ${CMAKE_FIND_ROOT_PATH}/bin/${size}     )#PARENT_SCOPE)


# adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment
set (CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )#PARENT_SCOPE)
# search headers and libraries in the target environment
set (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY  )#PARENT_SCOPE)
set (CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY  )#PARENT_SCOPE)
set (CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY  )#PARENT_SCOPE)


#    # Cleanup
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


unset(tc-prefix)
unset(tc-path)

