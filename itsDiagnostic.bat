@echo off
set Version=1.0.6
title �������⨪� � ����⠭������� ��⥬��� 䠩��� "itsDiagnostic | Version: %Version%

echo ��१ 7 ᥪ㭤 ���������� �ਯ� 'itsDiagnostic.bat / Version %Version% / ���������� �� 09.05.2021' �᫨ �� ��� �⮣� ������, ������ ��������� 'ctrl + c'

echo ===
echo ========================= �����஢���� ��⥬� =========================

echo ===
echo ���������� ����⨪��.
timeout 2
gpupdate /force

echo ===
echo �⮡� ��ࠢ��� �訡��, ��⮬���᪨ ᪠��� � �������� 䠩�� ���०���� ��� ����������� ��������⮢ �⠫���묨 ����ﬨ 䠩��� �� 業�� ���������� Windows.
timeout 2
DISM /Online /Cleanup-Image /RestoreHealth

echo ===
echo �����஢���� ��⥬� �� �訡��.
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
timeout 2
sfc /scannow

echo ===
echo �����襭�� ࠡ���...
echo itsCleanable Version: %Version%
echo ����: ���஢ ���� ����ᥥ���.
echo ����� ����� github.com/itsmyfox � ࠧ���� 'itsCleanable'
echo ���� ���� �� ����� �।������ � ࠧ���� 'pull requests'
echo ===
echo ��ਯ� ��⮬���᪨ ���������� �१ 10 ᥪ㭤 � ������ १����� � ��� 䠨�.
echo �᫨ �� ��� �����, ������ ���� �������.
echo ===

timeout 10
