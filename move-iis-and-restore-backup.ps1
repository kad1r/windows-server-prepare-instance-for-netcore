# Move IIS to D drive
# If you have EBS Volume you can download that script from "https://gallery.technet.microsoft.com/scriptcenter/Move-IIS-to-another-drive-99f9f741"
& "D:\PowerShell\move_iss.ps1" "D"

# Copy backup to InetSrv
Copy-Item "D:\IISBackups\BackupName" "C:\Windows\system32\inetsrv\backup\"

# Restore backup
C:\Windows\system32\inetsrv\appcmd.exe restore backup BackupName
