@echo off
rem ************************************************************************
rem * SGGame Batch File
rem * Created by ejlee. ���� 3:30 2013-11-10
rem * Updated by ejlee. ���� 9:54 2014-07-17
rem ************************************************************************

rem // sg.game ��Ʈ ���� ��ġ
Set SGDir=D:\M\ejlee-D\sg.game
Set GameName="SGGame Win32"
Set Gears="d:\Epic\GearsOfWar3\GearsOfWar3\Gears of War 3\Binaries\Win32"
rem mode con cols=260 lines=80


rem ************************************************************************ 
if "%1" == "-uc"          goto ProjUC
if "%1" == "-gears"      goto Gears
if "%1" == "-ue3"        goto ProjNative
if "%1" == "-kill" 	      goto KillProcess
if "%1" == "-pve"        goto pve
if "%1" == "-tdm"        goto tdm
if "%1" == "-setup"      goto setup
if "%1" == "-info"        goto info
if "%1" == "-c"           goto compile
if "%1" == "-build"      goto build
if "%1" == "-starter"    goto Starter
if "%1" == "-rc"          goto RemoteControl
if "%1" == "-?"           goto Help
if "%1" == "-h"           goto Help
if "%1" == "-help?"      goto Help
if "%1" == "-help"       goto Help

goto standalone 

rem * Help Page
rem ************************************************************************ 
:Help
echo ���� - ���� []��ȣ ��ȣ�� ����
echo  sg -uc        	          	:  �𸮾� ��ũ��Ʈ�ڵ� ������Ʈ (��� Ȯ�� �ʿ�)
echo  sg -gears   			:  �����3 ������ ����
echo  sg -ue3     			:  �𸮾� ����Ƽ�� ������Ʈ 
echo  sg -kill 	  		:  �������� sgXXXX,exe ��� ���μ��� ����
echo  sg -s ["�� �̸�"]  		:  ���𼭹� ����,  ������ �� �̸����� ������ ����
echo  sg -s ["�� �̸�"] n 		:  ���𼭹� ����,  ������ �ʱ� n���� Ŭ���̾�Ʈ�� ���ÿ� ����
echo  sg -setup   			:  ���� ��ġ ���� �������� ����
echo  sg -compile 			:  ��ũ��Ʈ ����
echo  sg -starter 			:  ���ϸ� �׽�Ʈ ��Ÿ�� ����
echo  sg -wx ["�� �̸�"]    		:  ����� ��Ʈ�� ����
echo  sg [���̸� or 127.0.0.1] 	:  �ܼ� ���� ���� or ������ �����Ҷ�
echo:
echo ex^)
echo �� ^= pve-cover-test.udk
echo:
echo �̱۸��, ������^:	
echo 	c:\^> sg pve-cover-test
echo 	c:\^> sg editor
echo:
echo:
echo ��Ƽ���, ����1,Ŭ��2^:	
echo 	c:\^> sg -s pve-cover-test 2
echo:
echo:
echo ����Ʈ��Ʈ�� ���� ����^:	
echo 	c:\^> sg -wx pve-cover-test
echo:
echo:
echo ��ġ���Ͽ�%NL% ���� �ڼ��� ������ "sg -setup"���� ��� Ȯ���Ͻʽÿ�.
echo:
pause
goto end


rem ************************************************************************ 
:Starter
start \\s087_sv1\SUCCLogs\GameStarter\SGGameStarter.application
goto end


rem ************************************************************************ 
:ProjUC
start %SGDir%\Development\Src\SGGameUC.sln
goto end



rem ************************************************************************ 
:ProjNative
start %SGDir%\Development\Src\UE3.sln
goto end


rem ************************************************************************ 
rem * PVE ���� ȯ�� ����, ����3�� ������ŭ Ŭ���̾�Ʈ ���
rem ************************************************************************ 
:pve
title ���� ȯ�� ����
echo Server
start %SGDir%\Binaries\Win32\SgGame.exe server %2 ?game=SGGame.SGGameInfoPVE
sleep 1
set /a count=%3
if %count leq 0 (echo No client
goto end
)
goto client


rem ************************************************************************ 
rem * TDM ���� ȯ�� ����, ����3�� ������ŭ Ŭ���̾�Ʈ ���
rem ************************************************************************ 
:tdm
title ���� ȯ�� ����
echo Server
start %SGDir%\Binaries\Win32\SgGame.exe server %2 ?game=SGGame.SGGameInfoTDM
sleep 1
set /a count=%3
if %count leq 0 (echo No client
goto end
)
goto client



rem ************************************************************************ 
rem * server->client �б� ���� ��� �̾���                                     
rem * 3��° �Ķ���� ���ڰ� 0�� �ƴҰ�� ������ �� ��ŭ Ŭ���̾�Ʈ�� ���      
rem ************************************************************************ 



rem ************************************************************************
rem * Ŭ���̾�Ʈ 1, �������� ��� 
rem ************************************************************************
:client
if %count% leq 0 goto end
echo Client
start %SGDir%\Binaries\Win32\SgGame.exe 127.0.0.1
set /a count = count - 1
goto client


rem ************************************************************************ 
rem * ����1�� ���� ���� �÷���
rem ************************************************************************ 
:standalone
title ȥ�� �ϱ� ���
start %SGDir%\Binaries\Win32\SgGame.exe %1
goto end


rem ************************************************************************ 
rem * ���� ��� SGGame ���μ��� ���� ����
rem ************************************************************************ 
:KillProcess
title sg ���� ���μ��� ����
taskkill /IM sggame.exe
taskkill /IM SGGame-Win32-Debug.exe
goto end


rem ************************************************************************ 
rem * ��ũ��Ʈ ����� ������
rem ************************************************************************ 
:compile
title ������: �ָܼ��
echo �𸮾� ��ũ��Ʈ ���� ����:
set files="a.txt"
%SGDir%\Binaries\Win32\sggame.com make -debug
rem %SGDir%\Binaries\Win32\sggame.com make -debug > a.txt
rem mode con cols=160 lines=60
rem type a.txt
pause
goto end


rem ************************************************************************ 
rem * ����Ƽ�� ������ ����
rem ************************************************************************ 
:build
title ���̳ʸ� ����: �ָܼ��
echo �𸮾� ���� ����:
set files="a.txt"
d:
cd %SGDir%\Development\Src
%SGDir%\Development\Src\Targets\Build.bat SGGame Win32 Release -ouput "../../Binaries/Win32/SGGame.exe"
rem mode con cols=160 lines=60
pause
goto end


rem ************************************************************************
rem * ��ġ ���� ����
rem ************************************************************************
:setup
start notepad d:\sg.bat
goto end

rem ************************************************************************
rem * gvim���� ��ġ ���� ����
rem ************************************************************************
:info
start gvim d:\sg.bat
goto end

rem ************************************************************************
rem * �����3 ������ ����
rem ************************************************************************
:Gears
cd "d:\Epic\GearsOfWar3\GearsOfWar3\Gears of War 3\Binaries\Win32"
d:
start Geargame editor
goto end


rem ************************************************************************
rem * ����Ʈ ��Ʈ�� �ɼ�
rem ************************************************************************
:RemoteControl
title ����Ʈ ��Ʈ��
start %SGDir%\Binaries\Win32\SgGame.exe %2 -wxwindows
goto end


rem ************************************************************************
:end
exit