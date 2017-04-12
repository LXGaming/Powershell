Clear-Host
$Base = Get-ChildItem -File "" -Depth 3

ForEach ($File in $Base) {
  if ($File.Name -eq "") {
    Write-Host ("Processing - " + $File.FullName);

    $Content = (Get-Content $File.FullName).Replace("", "");
    Set-Content $File.FullName $Content

  }
}