@echo off
setlocal ENABLEEXTENSIONS
set mypath=%cd%
set ProjectName=[Your Project Name]
copy %ProjectName%.uproject %ProjectName%.generated.uproject /Y
attrib nm.generated.uproject -R

FOR /F "usebackq tokens=3*" %%A IN (`REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Unreal.ProjectFile\DefaultIcon" /s`) DO (
    set appdir=%%A %%B
    )
ECHO %appdir%

%appdir% /switchversion %mypath%\%ProjectName%.generated.uproject


