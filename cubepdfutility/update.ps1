# Taken over from https://github.com/KageShiron/chocolatey-packages/blob/9604eafb1b63c34978ac78f1ec17a68c1d4661c2/cubepdfutility/update.ps1
# by KageShiron licensed under MIT License

$ErrorActionPreference = 'Stop'

$VersionFilePath = 'Applications/Editor/Main/Cube.Pdf.Editor.csproj'

function New-GitHubHeaders {
    param([switch]$Api)

    $headers = @{
        'User-Agent' = 'chocolatey-au (cubepdfutility-chocolatey)'
    }

    if ($Api) {
        $headers['Accept'] = 'application/vnd.github+json'
    }

    return $headers
}

function Get-VersionFromCsprojText {
    param([Parameter(Mandatory = $true)][string]$CsprojText)

    # raw.githubusercontent.com often serves UTF-8 with BOM. When decoded into a string,
    # the BOM becomes a literal U+FEFF char that can break [xml] casting in Windows PowerShell.
    $clean = $CsprojText.TrimStart([char[]]@(0xFEFF, 0x200B))  # FEFF=BOM/ZWNBSP, 200B=ZWSP (defensive)
    $clean = $clean.Trim()

    try { [xml]$xml = $clean }
    catch { throw "Failed to parse csproj as XML: $($_.Exception.Message)" }

    # First <Version> under any <PropertyGroup>
    $node = $xml.SelectSingleNode('//Project/PropertyGroup/Version')
    if (-not $node -or [string]::IsNullOrWhiteSpace($node.InnerText)) {
        throw "No <Version>...</Version> element found in csproj."
    }

    $version = $node.InnerText.Trim()

    # Basic sanity check: 1–4 numeric components.
    if ($version -notmatch '^\d+(\.\d+){1,3}$') {
        throw "Unexpected version format in csproj: '$version'"
    }

    return $version
}

function Get-LatestVersionFromRepo {
    $rawUrl = "https://raw.githubusercontent.com/cube-soft/cube.pdf/master/$VersionFilePath"
    try {
        $text = (Invoke-WebRequest -UseBasicParsing -Uri $rawUrl -Headers (New-GitHubHeaders)).Content
        return (Get-VersionFromCsprojText -CsprojText $text)
    }
    catch {
        Write-Error $_
        throw "Could not read a version from '$VersionFilePath'"
    }
}

function global:au_GetLatest {
    $version = Get-LatestVersionFromRepo

    return @{
        Version        = $version;
        URL32          = ("https://dl.cube-soft.jp/archive/cubepdf-utility-{0}.exe" -F $version);
        URL64          = ("https://dl.cube-soft.jp/archive/cubepdf-utility-{0}-x64.exe" -F $version);
        ChecksumType32 = 'sha256';
        ChecksumType64 = 'sha256';
    }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"           #1
            "(?i)(^\s*checksum\s*=\s*)'.*'"   = "`$1'$($Latest.Checksum32)'"      #2
            "(^[$]url64\s*=\s*)('.*')"        = "`$1'$($Latest.URL64)'"           #1
            "(?i)(^\s*checksum64\s*=\s*)'.*'" = "`$1'$($Latest.Checksum64)'"      #2
        }
    }
}

Update-Package
