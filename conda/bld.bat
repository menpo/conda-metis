robocopy %RECIPE_DIR%\.. . /E /NFL /NDL

mkdir build
cd build

rem Need to handle Python 3.x case at some point (Visual Studio 2010)
if %ARCH%==32 (
  if %PY_VER% LSS 3 (
    set CMAKE_GENERATOR="Visual Studio 9 2008"
    set CMAKE_CONFIG="Release"
  )
)
if %ARCH%==64 (
  if %PY_VER% LSS 3 (
    set CMAKE_GENERATOR="Visual Studio 9 2008 Win64"
    set CMAKE_CONFIG="Release"
  )
)

rem STATIC LIBS
cmake .. -G%CMAKE_GENERATOR% ^
 -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
 -DGKLIB_PATH="..\GKlib" ^
 -DSHARED=0

cmake --build . --config %CMAKE_CONFIG% --target ALL_BUILD
copy "libmetis\Release\metis.lib" "%LIBRARY_LIB%\metis.lib"

rem SHARED LIBS
cmake .. -G%CMAKE_GENERATOR% ^
 -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
 -DGKLIB_PATH="..\GKlib" ^
 -DSHARED=1

cmake --build . --config %CMAKE_CONFIG% --target ALL_BUILD
copy "libmetis\Release\metis.dll" "%LIBRARY_BIN%\metis.dll"

rem Copy the header file
copy "..\include\metis.h" "%LIBRARY_INC%\metis.h"

if errorlevel 1 exit 1
