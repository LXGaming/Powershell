Clear-Host
$Base = Get-ChildItem -File "" -Depth 3

ForEach ($File in $Base) {
  if ($File.Name -eq "README.md") {
    $Content = Get-Content $File.FullName -Raw;

    if (!$Content.Contains("")) {
      Write-Host ("Not Processing - " + $File.FullName)
      continue;
    }

    Write-Host ("Processing - " + $File.FullName);
    $Parent = Get-Item $File.PSParentPath;
    $Content = (Get-Content $File.FullName -Raw).Replace("","");
    Set-Content $File.FullName $Content.Trim() -NoNewline
  }
}