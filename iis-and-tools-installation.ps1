# This script installs IIS and the features required to run asp.net core applications
# Make sure you run this script from an Admin Prompt!

Set-ExecutionPolicy Bypass -Scope Process

Set-ExecutionPolicy Bypass -Scope Process

Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionDynamic -n
Disable-WindowsOptionalFeature -Online -FeatureName IIS-DirectoryBrowsing -n

Enable-WindowsOptionalFeature -Online -FeatureName IIS-HealthAndDiagnostics -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpLogging -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibraries -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestMonitor -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpTracing -n

Enable-WindowsOptionalFeature -Online -FeatureName IIS-Performance -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent -n

Enable-WindowsOptionalFeature -Online -FeatureName IIS-Security -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestFiltering -n

Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment -n
Enable-WindowsOptionalFeature -online -FeatureName NetFx4Extended-ASPNET45 -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45 -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter -n

Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerManagementTools -n
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole -n

#
# Installing choco to install .net core hosting bundle
#
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install dotnetcore-windowshosting -y
choco install urlrewrite -y
choco install isapirewrite -y
choco install iis-arr -y
choco install webdeploy -y
choco install dotnet4.6 -y
choco install firefox -y
choco install pgadmin4 -y
choco install notepadplusplus -y
choco install awscli -y
choco install 7zip.install -y

# Move IIS to D drive
# If you have EBS Volume you can download that script from "https://gallery.technet.microsoft.com/scriptcenter/Move-IIS-to-another-drive-99f9f741"
& "D:\PowerShell\move_iss.ps1" "D"

# Copy backup to InetSrv
Copy-Item "D:\IISBackups\BackupName" "C:\Windows\system32\inetsrv\backup\"

# Restore backup
C:\Windows\system32\inetsrv\appcmd.exe restore backup BackupName

# Restart IIS
net stop w3svc
net start w3svc
