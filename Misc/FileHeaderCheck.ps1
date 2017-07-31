Clear-Host
$Base = Get-ChildItem -File "" -Depth 10
$Header = Get-Content -Path "" -Raw;

ForEach ($File in $Base) {
  $Content = Get-Content -Path $File.FullName -Raw;
  if (!$Content.StartsWith($Header)) {
    Write-Host("'" + $File.FullName + "' doesn't start with provided header!");
  }
}