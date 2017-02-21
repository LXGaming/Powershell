Clear-Host
$Base = Get-ChildItem -Directory "" -Depth 1

ForEach ($Folder in $Base) {
  if ((Test-Path ($Folder.FullName + "\.gradle")) -And (Test-Path ($Folder.FullName + "\build.gradle")) -And (Test-Path ($Folder.FullName + "\gradlew"))) {
    Write-Host ("Processing: " + $Folder.Name)
    Remove-Item ($Folder.FullName + "\.gradle") -Recurse
    Write-Host ("Removed: " + $Folder.FullName + "\.gradle");

    $ProcessStartInfo = New-Object System.Diagnostics.ProcessStartInfo;
    $ProcessStartInfo.FileName = ($Folder.FullName + "\gradlew.bat");
    $ProcessStartInfo.RedirectStandardError = $True
    $ProcessStartInfo.RedirectStandardOutput = $True
    $ProcessStartInfo.UseShellExecute = $False
    $ProcessStartInfo.CreateNoWindow = $True
    $ProcessStartInfo.Arguments = ("-p "  + $Folder.FullName + " clean build");
    Write-Host ("Process Arguments: " + $ProcessStartInfo.Arguments);
    $Process = New-Object System.Diagnostics.Process;
    $Process.StartInfo = $ProcessStartInfo;
    $Process.Start() | Out-Null;
    $Process.WaitForExit();
    $Output = $Process.StandardOutput.ReadToEnd();
    $Output += $Process.StandardError.ReadToEnd();
    Write-Host $Output;
  }
}