#Requires -PSEdition Core
#Requires -Version 6.0

foreach ($File in Get-ChildItem -Path ".\versions" -File) {
    if (-not ($File.Extension -eq ".json")) {
        continue;
    }
    
    $Name = $File.Name.Substring(0, $File.Name.Length - $File.Extension.Length);

    Write-Host "Processing $($File.Name)" -ForegroundColor Cyan;
    & .\burger_mapper ".\mappings\$($File.Name)" ".\versions\$($File.Name)" ".\versions\$($Name + "-mapped.json")";
}