Clear-Host
$Base = Get-ChildItem "" -Depth 3

ForEach ($Folder in $Base) {
  $Parent = Get-Item $Folder.PSParentPath;
  if ($Parent.Name -eq ".gradle") {
    #Write-Host("Process " + $Parent.FullName);
    if ($Folder.Name -ne "4.0" -and $Folder.Name -ne "buildOutputCleanup" -and $Folder.PSIsContainer) {
      Write-Host("Found - " + $Folder.FullName);
    }
  }
}