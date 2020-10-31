# Taken over from https://github.com/KageShiron/chocolatey-packages/blob/9604eafb1b63c34978ac78f1ec17a68c1d4661c2/cubepdfutility/tools/chocolateyinstall.ps1
# by KageShiron licensed under MIT License

$ErrorActionPreference = 'Stop';

$packageName= 'cubepdfutility'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.cube-soft.jp/archive/cubepdf-utility-0.6.3b.exe'
$url64      = 'https://dl.cube-soft.jp/archive/cubepdf-utility-0.6.3b-x64.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'cubepdfutility*'

  # Checksums are calculated with the binaries downloaded from the official website, not the GitHub repository
  checksum      = 'e8be455b1afe3d32d88679fc0c5188047e29189ac37c10c5ebbd1e8419243ddf'
  checksumType  = 'sha256'
  checksum64    = '826eabf72b31513197b3d94c16244aa5d04156b025aa3d06a24db87375b68818'
  checksumType64= 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs


















