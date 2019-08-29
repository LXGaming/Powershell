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

        if (-not ($_.Extension -eq ".tsrg" -or $_.Extension -eq ".srg")) {
            throw "Unsupported extension: $($_.Extension)";
        }

        return $true;
    })]
    [System.IO.FileInfo]
    $MappingPath,
    [Parameter()]
    [System.IO.FileInfo]
    $OutputPath
)

function ConvertFrom-TSRG($Lines) {
    $Mappings = @{};
    foreach ($Line in $Lines) {
        if ($Line -notmatch "^[a-z]") {
            continue;
        }

        $Mapping = $Line.Split(" ");
        if ($Mapping.Count -ne 2) {
            Write-Host "Invalid Mapping: $Line" -ForegroundColor Red;
        }

        $Mappings.Add($Mapping[0], $Mapping[1]);
    }

    return $Mappings;
}

function ConvertFrom-SRG($Lines) {
    $Mappings = @{};
    foreach ($Line in $Lines) {
        if ($Line -notmatch "^CL:") {
            continue;
        }

        $Mapping = $Line.Split(" ");
        if ($Mapping.Count -ne 3) {
            Write-Host "Invalid Mapping: $Line" -ForegroundColor Red;
        }

        $Mappings.Add($Mapping[1], $Mapping[2]);
    }

    return $Mappings;
}

$Content = Get-Content -Path $MappingPath;
if ($MappingPath.Extension -eq ".tsrg") {
    $Mappings = ConvertFrom-TSRG($Content);
} elseif ($MappingPath.Extension -eq ".srg") {
    $Mappings = ConvertFrom-SRG($Content);
} else {
    throw "Unsupported extension: $($MappingPath.Extension)";
}

$Output = @{
    "classes" = $Mappings
} | ConvertTo-Json -Depth 100;

if ($OutputPath) {
    Set-Content -Path $OutputPath -Value $Output;
} else {
    Write-Host $Output;
}