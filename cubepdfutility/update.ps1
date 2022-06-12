# Taken over from https://github.com/KageShiron/chocolatey-packages/blob/9604eafb1b63c34978ac78f1ec17a68c1d4661c2/cubepdfutility/update.ps1
# by KageShiron licensed under MIT License

function GetLatestFromReleases($releases) {
    foreach ($r in $releases[0]) {
        if (($r.body -match "### CubePDF Utility (\d.\d.\d)") -Or ($r.name -match "CubePDF Utility (\d.\d.\d)")) {
            return $Matches[1]
        }
    }
}

function global:au_GetLatest {
    $releases = @(Invoke-WebRequest https://api.github.com/repos/cube-soft/Cube.Pdf/releases -UseBasicParsing | ConvertFrom-Json)
    $version = (GetLatestFromReleases $releases)

    return @{ 
        Version        = $version;
        URL32          = ("https://dl.cube-soft.jp/archive/cubepdf-utility-{0}.exe" -F $version);
        URL64          = ("https://dl.cube-soft.jp/archive/cubepdf-utility-{0}-x64.exe" -F $version);
        ChecksumType32 = 'sha256'
    }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"           #1
            "(?i)(^\s*checksum\s*=\s*)'.*'"   = "`$1'$($Latest.Checksum32)'"      #2
            "(^[$]url64\s*=\s*)('.*')"        = "`$1'$($Latest.URL64)'"           #1
            "(?i)(^\s*checksum64\s*=\s*)'.*'" = "`$1'$($Latest.Checksum64)'"      #2
        }
    }
}


Update-Package
