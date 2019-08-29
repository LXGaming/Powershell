#Requires -PSEdition Core
#Requires -Version 6.0

foreach ($File in Get-ChildItem -Path ".\mappings" -File) {
    if (-not ($File.Extension -eq ".tsrg" -or $File.Extension -eq ".srg")) {
        continue;
    }

    $Name = $File.Name.Substring(0, $File.Name.Length - $File.Extension.Length);
    
    Write-Host "Processing $($File.Name)" -ForegroundColor Cyan;
    & .\mcp_mapper ".\mappings\$($File.Name)" ".\mappings\$($Name + ".json")";
}