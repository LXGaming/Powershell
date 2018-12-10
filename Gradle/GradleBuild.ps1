Clear-Host;

$Variables = @(
  "GradleDirectory",
  "GradlePath",
  "Result",
  "TargetDirectory",
  "Variables");

Remove-Variable -Name $Variables -ErrorAction SilentlyContinue;

try {
  Write-Host "Enter target directory: " -ForegroundColor White -NoNewline;
  $TargetDirectory = Resolve-Path -Path (Read-Host) -ErrorAction Stop;
} catch {
  Write-Host $_ -ForegroundColor Red;
  pause;
  return;
}

Write-Host "Are you sure you want to build Gradle projects?: " -ForegroundColor White -NoNewline;
$Result = Read-Host;
if ($Result -ne "y" -and $Result -ne "yes") {
  Write-Host "Script cancelled." -ForegroundColor Red;
  pause;
  return;
}

ForEach ($Directory in Get-ChildItem -Directory $TargetDirectory -Depth 10) {
  $GradleDirectory = Join-Path -Path $Directory.FullName -ChildPath ".gradle";
  $GradlePath = Join-Path -Path $Directory.FullName -ChildPath "gradlew.bat";
  if (!(Test-Path -Path $GradlePath)) {
    continue;
  }

  & $GradlePath "clean" "build" "--console" "verbose" "--project-dir" $Directory.FullName;

  Write-Host "$($Directory.Name) -> Built" -ForegroundColor Cyan;
}

Write-Host "Script completed." -ForegroundColor Cyan;
pause;