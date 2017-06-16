Clear-Host;
Write-Host("LX's Multi-Build PowerShell Script.");

if (!$PSCommandPath) {
  Write-Host("Unable to find script execution path!");
  return;
}

$Path = Get-ChildItem -Directory (Split-Path -Parent $PSCommandPath);

ForEach ($Folder in $Path) {
  Write-Host("Checking '" + $Folder.Name + "'...");
  if (!(Test-Path -Path (Join-Path -Path $Folder.FullName -ChildPath "gradlew"))) {
    Write-Host("Cannot find 'gradlew' in '" + $Folder.Name + "'!");
    continue;
  }

  if (!(Test-Path -Path (Join-Path -Path $Folder.FullName -ChildPath "build.gradle"))) {
    Write-Host("Cannot find 'build.gradle' in '" + $Folder.Name + "'!");
    continue;
  }
  Write-Host("Building '" + $Folder.Name + "'...");
  $ProcessStartInfo = New-Object System.Diagnostics.ProcessStartInfo;
  $ProcessStartInfo.FileName = ($Folder.FullName + "\gradlew.bat");
  $ProcessStartInfo.RedirectStandardError = $True
  $ProcessStartInfo.RedirectStandardOutput = $True
  $ProcessStartInfo.UseShellExecute = $False
  $ProcessStartInfo.CreateNoWindow = $True
  $ProcessStartInfo.Arguments = ("-p "  + $Folder.FullName + " clean build");
  $Process = New-Object System.Diagnostics.Process;
  $Process.StartInfo = $ProcessStartInfo;
  $Process.Start() | Out-Null;
  $Process.WaitForExit();
  $Output = $Process.StandardOutput.ReadToEnd();
  $Output += $Process.StandardError.ReadToEnd();
  Write-Host $Output;
}

Pause;