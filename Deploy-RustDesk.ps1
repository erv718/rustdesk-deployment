param(
    [Parameter(Mandatory)][string]$ServerHost,
    [Parameter(Mandatory)][string]$ServerKey,
    [Parameter(Mandatory)][string]$Password
)

$ErrorActionPreference='Stop'
$exe = Join-Path $env:ProgramFiles 'RustDesk\rustdesk.exe'
if(!(Test-Path $exe)){$exe = Join-Path ([Environment]::GetEnvironmentVariable('ProgramFiles(x86)')) 'RustDesk\rustdesk.exe'}

Start-Process $exe -ArgumentList '--install-service' -Wait

$d = 'C:\Windows\ServiceProfiles\LocalService\AppData\Roaming\RustDesk\config'
New-Item -ItemType Directory -Force -Path $d | Out-Null
$f = Join-Path $d 'RustDesk2.toml'

@"
[options]
id-server = "${ServerHost}:21116"
key = "$ServerKey"
verification-method = "use-permanent-password"
access-mode = "custom"
enable-keyboard = "Y"
enable-clipboard = "Y"
enable-file-transfer = "Y"
enable-terminal = "Y"
enable-remote-printer = "Y"
enable-audio = "Y"
enable-tunnel = "Y"
enable-remote-restart = "Y"
enable-record-session = "Y"
enable-block-input = "Y"
allow-remote-config-modification = "Y"
"@ | Set-Content -Path $f -Encoding UTF8 -Force

& $exe --password $Password
Restart-Service -Name RustDesk -Force

$rdId = (& $exe --get-id | Out-String).Trim()
"RustDesk ID: $rdId"
