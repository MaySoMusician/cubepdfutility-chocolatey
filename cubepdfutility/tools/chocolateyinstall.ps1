# Taken over from https://github.com/KageShiron/chocolatey-packages/blob/9604eafb1b63c34978ac78f1ec17a68c1d4661c2/cubepdfutility/tools/chocolateyinstall.ps1
# by KageShiron licensed under MIT License

$ErrorActionPreference = 'Stop';

$packageName= 'cubepdfutility'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.cube-soft.jp/archive/cubepdf-utility-1.6.7.exe'
$url64      = 'https://dl.cube-soft.jp/archive/cubepdf-utility-1.6.7-x64.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'cubepdfutility*'

  # Checksums are calculated with the binaries downloaded from the official website, not the GitHub repository
  checksum      = '6ac88c086bc97a14f50969c91f1d7a69744c96e526d6cd654c5bbe4a45669a6a'
  checksumType  = 'sha256'
  checksum64    = 'ebf426dc048c7f4703a70506a2f1005ba05abff775866eef7e948ced5bd852f6'
  checksumType64= 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs


















