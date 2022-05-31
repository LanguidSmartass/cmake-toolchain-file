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
-Dcmake-toolchain-root:PATH="/path/to/your/toolchain"
# Also, '--toolchain' and '-DCMAKE_TOOLCHAIN_FILE=' are equivalent
# cmake option expressions
```
