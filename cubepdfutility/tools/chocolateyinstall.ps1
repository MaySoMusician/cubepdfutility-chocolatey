# Taken over from https://github.com/KageShiron/chocolatey-packages/blob/9604eafb1b63c34978ac78f1ec17a68c1d4661c2/cubepdfutility/tools/chocolateyinstall.ps1
# by KageShiron licensed under MIT License

$ErrorActionPreference = 'Stop';

$packageName= 'cubepdfutility'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.cube-soft.jp/archive/cubepdf-utility-4.5.1.exe'
$url64      = 'https://dl.cube-soft.jp/archive/cubepdf-utility-4.5.1-x64.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'cubepdfutility*'

  # Checksums are calculated with the binaries downloaded from the official website, not the GitHub repository
  checksum      = '1424042edcf41de015b4eb125d1f700cc031f0d73e4642c368f739e212ae52f6'
  checksumType  = 'sha256'
  checksum64    = '7ba100965706ec05247999ea9735291b5c6c9c2d00c8eac58a85033f5898e7b6'
  checksumType64= 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs


















