Clear-Host;

Write-Host("Microsoft Package Remover.");
Write-Host("Author - LX_Gaming");
Write-Host("License - https://www.apache.org/licenses/LICENSE-2.0");
Write-Host("Website - https://lxgaming.github.io");
Write-Host("Script Idea - https://www.youtube.com/watch?v=gnAzCnbDNr8");

Write-Host("");
$Result = Read-Host("By typing 'Confirm' you agree that you are running this script AT YOUR OWN RISK!");
if (!($Result -ieq "confirm")) {
  return;
}

ForEach ($Item in Get-AppxPackage) {
  if (!$Item.PackageFullName.StartsWith("Microsoft") -or $Item.PackageFullName.StartsWith("Microsoft.WindowsStore") -or $Item.IsFramework) {
    continue;
  }

  Write-Host("");

  $Result = Read-Host("Do you want to remove '" + $Item.Name + "'?");
  if ($Result -ieq "quit" -or $Result -ieq "q" -or $Result -ieq "exit" -or $Result -ieq "escape") {
    Write-Host("Exiting...");
    break;
  }

  if ($Result -ieq "no" -or $Result -ieq "n") {
    Write-Host("Not removing '" + $Item.Name + "'.");
    continue;
  }
  
  if ($Result -ieq "yes" -or $Result -ieq "y") {
    Write-Host("Removing '" + $Item.Name + "'...");
    Remove-AppxPackage -Package $Item.PackageFullName;
    continue;
  }

  Write-Host("'" + $Result + "' is not a valid input, Skipping '" + $Item.Name + "'.");
}

Write-Host("");
Write-Host("Finished.");