Clear-Host
$Base = Get-ChildItem -File "" -Depth 10

ForEach ($File in $Base) {
  $Content = Get-Content $File.FullName -Raw;
  if ($Content.Contains("")) {
    Write-Host($File.FullName + " Contains Code.");
  }
}