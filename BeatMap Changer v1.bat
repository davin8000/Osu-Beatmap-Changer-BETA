@echo off
setlocal enabledelayedexpansion
set /a max_file=0
for /r %%m in (*.osu) do (
	set fi[!max_file!]=%%~nxm
	set /a max_file=max_file + 1
)
for /l %%m in (0,1,!max_file!) do (	
	set /a max_lines=0
	for /f "tokens=*" %%i in (!fi[%%m]!) do (
		set line[!max_lines!]=%%i
		set  temps=%%i
		set let=!temps:~0,1!
		set let2=!temps:~0,2!
		if !let! == [ (				
			set line[!max_lines!]=.
			set /a max_lines=max_lines + 1		
			set line[!max_lines!]=%%i
		)
		if !let2! == [C (	
			set line[!max_lines!]=.
			set /a max_lines=max_lines + 1		
			set line[!max_lines!]=%%i
		)	
		set /a max_lines=max_lines + 1
	)
	for /l %%n in (0,1,!max_lines!) do (
		set let=!line[%%n]:~0,13!
		if !let! == ApproachRate: (
			set line[%%n]=!let!5
		)
	)
	set /a max_lines=max_lines - 1
	for /l %%n in (0,1,!max_lines!) do (
		set file=MOD!fi[%%m]!
		if !line[%%n]! NEQ . (echo !line[%%n]!>> !file!)
		if !line[%%n]! EQU . (echo!line[%%n]!>> !file!)
	)
	echo !file! created.....
)
pause