Param(
    [string]$Arch="amd64"
)

$VsInstallRoot = "C:\Program Files (x86)\Microsoft Visual Studio"
$VsWhereExe = Join-Path $VsInstallRoot "Installer\vswhere.exe"
$VsInstall = &$VsWhereExe -nologo -latest -property installationpath
$VsDevShellDll = Join-Path $VsInstall "Common7\Tools\Microsoft.VisualStudio.DevShell.dll"

Import-Module $VsDevShellDll
Enter-VsDevShell `
    -VsInstallPath $VsInstall `
    -SkipAutomaticLocation `
    -StartInPath "." `
    -HostArch "amd64" `
    -Arch $Arch
