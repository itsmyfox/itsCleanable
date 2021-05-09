@echo off
set Version=1.0.6
title ����������� � �������������� ��������� ������ "itsDiagnostic | Version: %Version%

echo ����� 7 ������ ����������� ������ 'itsDiagnostic.bat / Version %Version% / ���������� �� 09.05.2021' ���� �� ������ ����� ������, ������� ���������� 'ctrl + c'

echo ===
echo ========================= ������������ ������� =========================

echo ===
echo ���������� ���������.
timeout 2
gpupdate /force

echo ===
echo ����� ��������� ������, ������������� ������� � �������� ����� ����������� ��� ������������� ����������� ���������� �������� ������ �� ������ ���������� Windows.
timeout 2
DISM /Online /Cleanup-Image /RestoreHealth

echo ===
echo ������������ ������� �� ������.
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
timeout 2
sfc /scannow

echo ===
echo ���������� ������...
echo itsCleanable Version: %Version%
echo �����: ������� ���� ����������.
echo ����� ������ github.com/itsmyfox � ������� 'itsCleanable'
echo ���� ���� �� ������ ���������� � ������� 'pull requests'
echo ===
echo ������ ������������� ����������� ����� 10 ������ � ������� ���������� � ��� ����.
echo ���� �� ������ �����, ������� ����� �������.
echo ===

timeout 10
