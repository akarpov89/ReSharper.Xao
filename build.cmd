@echo off

set config=%1
if "%config%" == "" (
   set config=Release
)
 
set version=2016.1.0
if not "%PackageVersion%" == "" (
   set version=%PackageVersion%
)

set nuget=
if "%nuget%" == "" (
        set nuget=src\.nuget\nuget.exe
)

%nuget% restore src\ReSharper.Xao.sln
"%ProgramFiles(x86)%\MSBuild\14.0\Bin\msbuild" src\ReSharper.Xao.sln /t:Rebuild /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=Normal /nr:false

set package_id="ReSharper.Xao"
%nuget% pack "src\ReSharper.Xao.nuspec" -NoPackageAnalysis -Version %version% -Properties "Configuration=%config%;ReSharperDep=Wave;ReSharperVer=[5.0];PackageId=%package_id%"