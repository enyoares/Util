@echo off
rem ************************************************************************
rem * SGGame Batch File
rem * Created by ejlee. 오후 3:30 2013-11-10
rem * Updated by ejlee. 오전 9:54 2014-07-17
rem ************************************************************************

rem // sg.game 루트 폴더 위치
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
echo 사용법 - 주의 []괄호 부호는 생략
echo  sg -uc        	          	:  언리얼 스크립트코드 프로젝트 (경로 확인 필요)
echo  sg -gears   			:  기어즈3 에디터 열기
echo  sg -ue3     			:  언리얼 네이티브 프로젝트 
echo  sg -kill 	  		:  구동중인 sgXXXX,exe 모든 프로세스 종료
echo  sg -s ["맵 이름"]  		:  데디서버 구동,  지정된 맵 이름으로 서버만 실행
echo  sg -s ["맵 이름"] n 		:  데디서버 구동,  지정된 맵구 n개의 클라이언트를 동시에 실행
echo  sg -setup   			:  현재 배치 파일 설정파일 열기
echo  sg -compile 			:  스크립트 빌드
echo  sg -starter 			:  데일리 테스트 스타터 시작
echo  sg -wx ["맵 이름"]    		:  리모드 콘트롤 시작
echo  sg [맵이름 or 127.0.0.1] 	:  단순 레벨 시작 or 서버에 접속할때
echo:
echo ex^)
echo 맵 ^= pve-cover-test.udk
echo:
echo 싱글모드, 에디터^:	
echo 	c:\^> sg pve-cover-test
echo 	c:\^> sg editor
echo:
echo:
echo 멀티모드, 서버1,클라2^:	
echo 	c:\^> sg -s pve-cover-test 2
echo:
echo:
echo 리모트컨트롤 같이 띄우기^:	
echo 	c:\^> sg -wx pve-cover-test
echo:
echo:
echo 배치파일에%NL% 대한 자세한 사항은 "sg -setup"으로 열어서 확인하십시오.
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
rem * PVE 서버 환경 구동, 인자3의 개수만큼 클라이언트 띄움
rem ************************************************************************ 
:pve
title 서버 환경 구동
echo Server
start %SGDir%\Binaries\Win32\SgGame.exe server %2 ?game=SGGame.SGGameInfoPVE
sleep 1
set /a count=%3
if %count leq 0 (echo No client
goto end
)
goto client


rem ************************************************************************ 
rem * TDM 서버 환경 구동, 인자3의 개수만큼 클라이언트 띄움
rem ************************************************************************ 
:tdm
title 서버 환경 구동
echo Server
start %SGDir%\Binaries\Win32\SgGame.exe server %2 ?game=SGGame.SGGameInfoTDM
sleep 1
set /a count=%3
if %count leq 0 (echo No client
goto end
)
goto client



rem ************************************************************************ 
rem * server->client 분기 없이 계속 이어짐                                     
rem * 3번째 파라미터 숫자가 0이 아닐경우 지정된 수 만큼 클라이언트를 띄움      
rem ************************************************************************ 



rem ************************************************************************
rem * 클라이언트 1, 서버접속 모드 
rem ************************************************************************
:client
if %count% leq 0 goto end
echo Client
start %SGDir%\Binaries\Win32\SgGame.exe 127.0.0.1
set /a count = count - 1
goto client


rem ************************************************************************ 
rem * 인자1에 대한 레벨 플레이
rem ************************************************************************ 
:standalone
title 혼자 하기 모드
start %SGDir%\Binaries\Win32\SgGame.exe %1
goto end


rem ************************************************************************ 
rem * 현재 모든 SGGame 프로세스 강제 종료
rem ************************************************************************ 
:KillProcess
title sg 게임 프로세스 종료
taskkill /IM sggame.exe
taskkill /IM SGGame-Win32-Debug.exe
goto end


rem ************************************************************************ 
rem * 스크립트 디버그 컴파일
rem ************************************************************************ 
:compile
title 컴파일: 콘솔모드
echo 언리얼 스크립트 빌드 시작:
set files="a.txt"
%SGDir%\Binaries\Win32\sggame.com make -debug
rem %SGDir%\Binaries\Win32\sggame.com make -debug > a.txt
rem mode con cols=160 lines=60
rem type a.txt
pause
goto end


rem ************************************************************************ 
rem * 네이티브 릴리즈 빌드
rem ************************************************************************ 
:build
title 바이너리 빌드: 콘솔모드
echo 언리얼 빌드 시작:
set files="a.txt"
d:
cd %SGDir%\Development\Src
%SGDir%\Development\Src\Targets\Build.bat SGGame Win32 Release -ouput "../../Binaries/Win32/SGGame.exe"
rem mode con cols=160 lines=60
pause
goto end


rem ************************************************************************
rem * 배치 파일 설정
rem ************************************************************************
:setup
start notepad d:\sg.bat
goto end

rem ************************************************************************
rem * gvim으로 배치 파일 열기
rem ************************************************************************
:info
start gvim d:\sg.bat
goto end

rem ************************************************************************
rem * 기어즈3 에디터 실행
rem ************************************************************************
:Gears
cd "d:\Epic\GearsOfWar3\GearsOfWar3\Gears of War 3\Binaries\Win32"
d:
start Geargame editor
goto end


rem ************************************************************************
rem * 리모트 컨트롤 옵션
rem ************************************************************************
:RemoteControl
title 리모트 콘트롤
start %SGDir%\Binaries\Win32\SgGame.exe %2 -wxwindows
goto end


rem ************************************************************************
:end
exit