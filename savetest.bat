cls
@echo off
echo:
Echo ##########################################################
Echo #                                                        #
Echo #         NEP User State Migration Tool                  #
Echo #                                                        #
Echo #          Backup User State Function                    #
Echo #                                                        #
Echo ##########################################################
echo: 

#Sets date 
SET DMY=%DATE%

#Checks permissions are allowed
goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...
	echo:
	echo:
    
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed. Proceeding with script.
    ) else (
        echo Failure: Administrator privileges are required to run this tool.
		exit /b
    )
    
#Verifying if save location exists for data being saved
IF exist \\NEPNZFS01.nepbroadcasting.com\userdata$\%computername% (echo Please check the existing backup before proceeding) else (md \\NEPNZFS01\userdata$\%computername%)



echo This may take some time depending on how much data the user has
echo:
#Calling for USMT to run backup and attempt to save log file at \\NEPNZFS01\usmtf$
echo Attempting to backup %computername% to \\NEPNZFS01\userdata$\%computername%
cd amd64
scanstate z:\%computername% /uel:7 /ue:%computername%\* /i:migdocs.xml /i:migapp.xml /o /c /l:\\NEPNZFS01\usmtf$\scanstate_%computername%.log /progress:\\NEPNZFS01\usmtf$\scanstate_progress_%computername%.log /v:5 /vsc /efs:copyraw
cd ..