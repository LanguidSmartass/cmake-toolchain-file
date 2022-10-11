# cmake-toolchain-file

Configure custom C/C++ toolchain, particularly useful in embedded development

```shell
# Usage:
# Pass these three options to cmake options (through terminal/console/IDE)
# Setting them in scripts won't take effect you desire

# call to executable with arguments passed below:
cmake 
# arg, path to the toolchain file from this repo
--toolchain "cmake-toolchain-file/toolchain-file.cmake"
# arg, toolchain prefix like "avr-", "arm-none-eabi-", etc.
#      can be just an empty string ""
-Dcmake-toolchain-prefix="toolchain-prefix"
# arg, full path to your toolchain
-Dcmake-toolchain-root="/path/to/your/toolchain" # or
# name of the environment variable that contains the path mentioned
-Dcmake-toolchain-root="TOOLCHAIN_PATH"
# Target system name, sets CMAKE_SYSTEM_NAME variable -- Linux, Windows, Generic
-Dcmake-toolchain-system="TargetSystemName"
#
# Also, '--toolchain' and '-DCMAKE_TOOLCHAIN_FILE=' are equivalent
# cmake option expressions
```
