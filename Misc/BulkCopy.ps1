$Directory = Get-ChildItem -File "" -Depth 3

foreach ($File in $Directory) {
  
  if ($File.Name -eq "build.bat") {
    Write-Host("Processing - " + $File.FullName);
    Copy-Item -Path "" -Destination $File.FullName;
  }
}