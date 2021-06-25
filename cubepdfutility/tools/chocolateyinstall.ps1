# Taken over from https://github.com/KageShiron/chocolatey-packages/blob/9604eafb1b63c34978ac78f1ec17a68c1d4661c2/cubepdfutility/tools/chocolateyinstall.ps1
# by KageShiron licensed under MIT License

$ErrorActionPreference = 'Stop';

$packageName= 'cubepdfutility'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.cube-soft.jp/archive/cubepdf-utility-1.0.1.exe'
$url64      = 'https://dl.cube-soft.jp/archive/cubepdf-utility-1.0.1-x64.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'cubepdfutility*'

  # Checksums are calculated with the binaries downloaded from the official website, not the GitHub repository
  checksum      = 'a83c61e0abef6935dfbbda0350dc04f099e6b3c52d444c100d69b73c329ac2a7'
  checksumType  = 'sha256'
  checksum64    = '5597304ea026ef427f7ec4c022df4955e82a70e7d928f19e6f13108bf8243b0e'
  checksumType64= 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs


















