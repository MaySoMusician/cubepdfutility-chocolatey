# Taken over from https://github.com/KageShiron/chocolatey-packages/blob/9604eafb1b63c34978ac78f1ec17a68c1d4661c2/cubepdfutility/tools/chocolateyinstall.ps1
# by KageShiron licensed under MIT License

$ErrorActionPreference = 'Stop';

$packageName= 'cubepdfutility'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.cube-soft.jp/archive/cubepdf-utility-4.5.2.exe'
$url64      = 'https://dl.cube-soft.jp/archive/cubepdf-utility-4.5.2-x64.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'cubepdfutility*'

  # Checksums are calculated with the binaries downloaded from the official website, not the GitHub repository
  checksum      = 'bfe45bd8c7c43d41122ce89fbb7599d89b22208f6440c6c649246ea0863b10a5'
  checksumType  = 'sha256'
  checksum64    = 'e031196b65df579d026c3f5d906c16a16e833e1764aebf9b23d5fcb5f2e2e7fa'
  checksumType64= 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs


















