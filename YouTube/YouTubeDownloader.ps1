Clear-Host;

$Variables = @(
  "DownloadPath",
  "ProjectDirectory",
  "ProvidedPath",
  "Result",
  "Variables",
  "YouTubeFile");

Remove-Variable -Name $Variables -ErrorAction SilentlyContinue;

try {
  $ProjectDirectory = Resolve-Path -Path (Split-Path -Path $PSCommandPath) -ErrorAction Stop;
  Write-Host "Enter the project path [" -ForegroundColor White -NoNewline;
  Write-Host "$($ProjectDirectory.Path)" -ForegroundColor Yellow -NoNewline;
  Write-Host "]: " -ForegroundColor White -NoNewline;
} catch {
  Write-Host "Enter the project path: " -ForegroundColor White -NoNewline;
}

$ProvidedPath = Read-Host;
if (!$ProjectDirectory -and !$ProvidedPath) {
  Write-Host "No path provided." -ForegroundColor Red;
  pause;
  return;
}

if ($ProjectDirectory -and !$ProvidedPath) {
  $ProvidedPath = $ProjectDirectory.Path;
}

try {
  $ProjectDirectory = Resolve-Path -Path $ProvidedPath -ErrorAction Stop;
} catch {
  Write-Host $_ -ForegroundColor Red;
  pause;
  return;
}

try {
  $DownloadPath = Join-Path -Path $ProjectDirectory -ChildPath "Downloads/%(title)s.%(ext)s" -ErrorAction Stop;
  # https://rg3.github.io/youtube-dl/download.html
  $YouTubeFile = Resolve-Path -Path (Join-Path -Path $ProjectDirectory -ChildPath "youtube-dl.exe") -ErrorAction Stop;
  # https://www.ffmpeg.org/download.html#build-windows 
  Resolve-Path -Path (Join-Path -Path $ProjectDirectory -ChildPath "ffmpeg.exe") -ErrorAction Stop;
  Resolve-Path -Path (Join-Path -Path $ProjectDirectory -ChildPath "ffplay.exe") -ErrorAction Stop;
  Resolve-Path -Path (Join-Path -Path $ProjectDirectory -ChildPath "ffprobe.exe") -ErrorAction Stop;
} catch {
  Write-Host $_ -ForegroundColor Red;
  pause;
  return;
}

while ($True) {
  Write-Host "Enter YouTube URL: " -ForegroundColor White -NoNewline;
  $Result = Read-Host;
  if ($Result -eq "exit" -or $Result -eq "stop" -or $Result -eq "quit") {
    Write-Host "Script cancelled." -ForegroundColor Red;
    pause;
    return;
  }

  Write-Host "Executing..." -ForegroundColor Cyan;
  & $YouTubeFile.Path "--extract-audio" "--audio-format" "mp3" "-o" $DownloadPath $Result | Write-Host -ForegroundColor White;
  Clear-Variable -Name Result -ErrorAction Stop;
}