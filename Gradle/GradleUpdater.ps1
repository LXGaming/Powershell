﻿Clear-Host
$GradleVersion = "4.0"
$Base = Get-ChildItem -Directory "" -Depth 3

ForEach ($Folder in $Base) {
  if ((Test-Path ($Folder.FullName + "\.gradle")) -And (Test-Path ($Folder.FullName + "\build.gradle")) -And (Test-Path ($Folder.FullName + "\gradlew"))) {
    Write-Host ("Processing: " + $Folder.Name)
	
    $ProcessStartInfo = New-Object System.Diagnostics.ProcessStartInfo;
    $ProcessStartInfo.FileName = ($Folder.FullName + "\gradlew.bat");
    $ProcessStartInfo.RedirectStandardError = $True
    $ProcessStartInfo.RedirectStandardOutput = $True
    $ProcessStartInfo.UseShellExecute = $False
    $ProcessStartInfo.CreateNoWindow = $True
    $ProcessStartInfo.Arguments = ("-p "  + $Folder.FullName + " wrapper --gradle-version " + $GradleVersion);
    Write-Host ("Process Arguments: " + $ProcessStartInfo.Arguments);
    $Process = New-Object System.Diagnostics.Process;
    $Process.StartInfo = $ProcessStartInfo;
    $Process.Start() | Out-Null;
    $Process.WaitForExit();
    $Output = $Process.StandardOutput.ReadToEnd();
    $Output += $Process.StandardError.ReadToEnd();
    Write-Host $Output;
	
	Remove-Item ($Folder.FullName + "\.gradle") -Recurse
    Write-Host ("Removed: " + $Folder.FullName + "\.gradle");
  }
}