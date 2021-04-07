@ECHO OFF
chcp 65001
cls
@SETLOCAL
echo "========请先参考README.md准备好编译环境========"
echo.

echo "========编译选项========"
echo "请注意：项目默认使用Release库，除非您自行编译Debug版的ncnn和Opencv，否则请不要选择Debug编译"
echo "请输入编译选项并回车: 1)Release, 2)Debug"
set BUILD_TYPE=Release
set /p flag=
if %flag% == 1 (set BUILD_TYPE=Release)^
else if %flag% == 2 (set BUILD_TYPE=Debug)^
else (echo 输入错误！Input Error!)
echo.

echo "请选择要使用的ncnn库选项并回车: 1)ncnn(CPU)，2)ncnn(vulkan)"
set BUILD_NCNN_VULKAN=OFF
set /p flag=
if %flag% == 1 (set BUILD_NCNN_VULKAN=OFF)^
else if %flag% == 2 (set BUILD_NCNN_VULKAN=ON)^
else (echo "输入错误！Input Error!")
echo.

echo "请注意：如果选择2)JNI动态库时，必须安装配置Oracle JDK"
echo "请选择编译输出类型并回车: 1)可执行文件，2)JNI动态库, 3)动态库(WIP), 4)静态库(WIP)"
set BUILD_OUTPUT="EXE"
set /p flag=
if %flag% == 1 (set BUILD_OUTPUT="EXE")^
else if %flag% == 2 (set BUILD_OUTPUT="JNI")^
else if %flag% == 3 (set BUILD_OUTPUT="SHARED")^
else if %flag% == 4 (set BUILD_OUTPUT="STATIC")^
else (echo 输入错误！Input Error!)
echo.

echo "VS版本: 1)vs2017-x64，2)vs2017-x86, 3)vs2019-x64, 4)vs2019-x86"
set BUILD_CMAKE_T="v141"
set BUILD_CMAKE_A="x64"
set /p flag=
if %flag% == 1 (
    set BUILD_CMAKE_T="v141"
    set BUILD_CMAKE_A="x64"
)^
else if %flag% == 2 (
    set BUILD_CMAKE_T="v141"
    set BUILD_CMAKE_A="Win32"
)^
else if %flag% == 3 (
    set BUILD_CMAKE_T="v142"
    set BUILD_CMAKE_A="x64"
)^
else if %flag% == 4 (
    set BUILD_CMAKE_T="v142"
    set BUILD_CMAKE_A="Win32"
)^
else (echo 输入错误！Input Error!)
echo.

mkdir build
pushd build
cmake -T "%BUILD_CMAKE_T%,host=x64" -A %BUILD_CMAKE_A% ^
  -DCMAKE_INSTALL_PREFIX=install ^
  -DCMAKE_BUILD_TYPE=%BUILD_TYPE% -DOCR_OUTPUT=%BUILD_OUTPUT% -DOCR_VULKAN=%BUILD_NCNN_VULKAN% ..
cmake --build . --config %BUILD_TYPE% -j %NUMBER_OF_PROCESSORS%
cmake --build . --config %BUILD_TYPE% --target install
popd
GOTO:EOF

@ENDLOCAL
