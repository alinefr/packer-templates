call winrm set winrm/config/service/auth @{Basic="true"}
call winrm set winrm/config/service @{AllowUnencrypted="true"}

C:/windows/system32/sysprep/sysprep.exe /generalize /oobe /unattend:C:/Windows/Panther/Unattend/unattend.xml /quiet /shutdown
