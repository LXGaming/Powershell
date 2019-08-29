#Requires -PSEdition Core
#Requires -Version 6.0

param (
    [Parameter(Mandatory=$true)]
    [ValidateScript({
        if (-not ($_ | Test-Path)) {
            throw "File doesn't exist";
        }

        if (-not ($_ | Test-Path -PathType Leaf)) {
            throw "The Mapping argument must be a file.";
        }

        if (-not ($_.Extension -eq ".json")) {
            throw "Unsupported extension: $($_.Extension)";
        }

        return $true;
    })]
    [System.IO.FileInfo]
    $MappingPath,
    [Parameter(Mandatory=$true)]
    [ValidateScript({
        if (-not ($_ | Test-Path)) {
            throw "File doesn't exist";
        }

        if (-not ($_ | Test-Path -PathType Leaf)) {
            throw "The Version argument must be a file.";
        }

        if (-not ($_.Extension -eq ".json")) {
            throw "Unsupported extension: $($_.Extension)";
        }

        return $true;
    })]
    [System.IO.FileInfo]
    $VersionPath,
    [Parameter()]
    [System.IO.FileInfo]
    $OutputPath
)

$Mapping = Get-Content -Path $MappingPath | ConvertFrom-Json -AsHashtable;
if (!$Mapping.classes -or $Mapping.version) {
    throw "Invalid mapping file";
}

$Version = Get-Content -Path $VersionPath | ConvertFrom-Json -AsHashtable;
if (!$Version.version) {
    throw "Invalid version file";
}

function ConvertFrom-Notch($Object) {
    foreach ($Key in $($Object.Keys)) {
        $Value = $Object.$Key;
        if ($Value -is [System.Collections.Hashtable]) {
            ConvertFrom-Notch($Value);
            continue;
        }

        if ($Value -is [System.String] -and $Key -eq "class") {
            $Class = $Value.Replace(".class", "");
            if (!$Mapping.classes.ContainsKey($Class)) {
                Write-Host "Missing Mapping for $Value" -ForegroundColor Red;
                continue;
            }

            $Object.$Key = $Mapping.classes[$Class];
        }
    }
}

ConvertFrom-Notch($Version);

$Output = $Version | ConvertTo-Json -Depth 100 -AsArray;

if ($OutputPath) {
    Set-Content -Path $OutputPath -Value $Output;
} else {
    Write-Host $Output;
}