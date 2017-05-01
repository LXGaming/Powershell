Clear-Host
$GradleVersion = "3.5"
$Base = Get-ChildItem -Directory "" -Depth 4

ForEach ($Folder in $Base) {
  if ($Folder.Parent.Name -eq ".gradle" -and $Folder.Name.Length -eq 3 -and $Folder.Name -ne $GradleVersion) {
    Write-Host ("Removing - " + $Folder.FullName);
    Remove-Item ($Folder.FullName) -Recurse
  }
}