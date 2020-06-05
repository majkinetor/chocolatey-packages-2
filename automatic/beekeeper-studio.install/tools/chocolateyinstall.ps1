﻿$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Beekeeper Studio*'
  file64         = "$toolsDir\Beekeeper-Studio-Setup-1.4.1.exe"
  checksum64     = '4395CA7BC05233855E2266DA4C9A9F2866AAB1C4B8A08A5126E906966218FD12'
  checksumType64 = 'sha256'
  silentArgs     = @('/S')
  validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs

$files = Get-ChildItem $toolsDir -include *.exe -recurse

foreach ($file in $files) {
  New-Item "$file.ignore" -type file -force | Out-Null
}