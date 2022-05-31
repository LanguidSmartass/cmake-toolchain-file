#include(doxygen.cmake)

function (toolchain_check)
    message(
        STATUS
"toolchain_check():
 Detected compilers and tools:
 C        : ${CMAKE_C_COMPILER}
 C++      : ${CMAKE_CXX_COMPILER}
 Archiver : ${CMAKE_AR}
 Objcopy  : ${CMAKE_OBJCOPY}
 Objdump  : ${CMAKE_OBJDUMP}
 Size tool: ${CMAKE_SIZE}
 GDB      : ${CMAKE_GDB}
"
    )
endfunction ()
