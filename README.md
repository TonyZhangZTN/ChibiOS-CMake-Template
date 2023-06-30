# Change 1
Change compile_options.cmake:
```cmake 
set(DEFS "-DCORTEX_USE_FPU=FALSE -DSHELL_CONFIG_FILE")
```
to 
```cmake 
set(DEFS "-DCORTEX_USE_FPU=FALSE")
```
# Change 2
`shell_cmd.h` in os directory
```cpp 
#define SHELL_CMD_TEST_ENABLED              FALSE
```