cls
echo off
Echo ##########################################################
Echo #                                                        #
Echo #         NEP User State Migration Tool                  #
Echo #                                                        #
Echo #          Restore User State Function                   #
Echo #                                                        #
Echo ##########################################################
echo: 
echo 
echo Please note that you should not logon to the computer under a new user before migrating their profile via loadstate.exe. 
echo:
echo If this user already exists on the computer, then when restoring the profile, the LoadState error return code: 71 will appear.
echo: 
echo In this case, you need to delete the user's profile in the registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList
echo:
echo Enter the computer name to restore from:
set /P oldpc=
echo:
echo Attempting to restore data from %oldpc%
cd amd64
rem loadstate \\NEPNZFS01\userdata$\%oldpc% /i:miguser.xml /i:migapp.xml /c /v:5 /l:\\NEPNZFS01\usmtf$\loadstate_%computername%.log /progress:\\NEPNZFS01\usmtf$\loadstate_progress_%computername%.log
loadstate z:\%oldpc% /i:miguser.xml /i:migapp.xml /c /v:5 /l:\\NEPNZFS01\usmtf$\loadstate_%computername%.log /progress:\\NEPNZFS01\usmtf$\loadstate_progress_%computername%.log
cd ..

