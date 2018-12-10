Clear-Host;

$Variables = @(
  "GradleDirectory",
  "GradlePath",
  "GradleCurrentRelease",
  "GradleVersion",
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

try {
  $GradleCurrentRelease = Invoke-RestMethod -Method Get -Uri "https://services.gradle.org/versions/current" -ErrorAction Stop;
  Write-Host "Enter Gradle version [" -ForegroundColor White -NoNewline;
  Write-Host "$($GradleCurrentRelease.version)" -ForegroundColor Yellow -NoNewline;
  Write-Host "]: " -ForegroundColor White -NoNewline;
} catch {
  Write-Host "Enter Gradle version: " -ForegroundColor White -NoNewline;
}

$GradleVersion = Read-Host;
if (!$GradleCurrentRelease -and !$GradleVersion) {
  Write-Host "No Gradle version provided." -ForegroundColor Red;
  pause;
  return;
}

if ($GradleCurrentRelease -and !$GradleVersion) {
  $GradleVersion = $GradleCurrentRelease.version;
}

Write-Host "Are you sure you want to update to Gradle " -ForegroundColor White -NoNewline;
Write-Host "$($GradleVersion)" -ForegroundColor Yellow -NoNewline;
Write-Host "?: " -ForegroundColor White -NoNewline;
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

  & $GradlePath "wrapper" "--gradle-version" $GradleVersion "--console" "verbose" "--project-dir" $Directory.FullName;

  Write-Host "$($Directory.Name) -> Gradle $($GradleVersion)" -ForegroundColor Cyan;
  Remove-Item -Path $GradleDirectory -Recurse -ErrorAction SilentlyContinue;
}

Write-Host "Script completed." -ForegroundColor Cyan;
pause;