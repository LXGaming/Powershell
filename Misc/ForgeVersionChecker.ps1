Clear-Host;
ForEach ($File in Get-ChildItem -Path "" -Depth 10 -File) {
  if ($File.Name -ne "build.gradle") {
    continue;
  }

  $Content = Get-Content -Path $File.FullName -Raw;
  if (!$Content.Contains("minecraft") -and !$Content.Contains("ForgeGradle")) {
    continue;
  }

  $Minecraft = $False;
  ForEach ($Line in Get-Content -Path $File.FullName) {
    if ($Line.StartsWith("minecraft")) {
      $Minecraft = $True;
      continue;
    }

    if ($Minecraft -and $Line.Contains("version = ")) {
      Write-Host "$($File.FullName) ($Line)" -ForegroundColor Cyan;
      if (!$Line.Contains("1.10.2-12.18.3.2511") -and !$Line.Contains("1.12.2-14.23.2.2611")) {
        Write-Host "Bad Forge version" -ForegroundColor Red;
      }

      if ($Line.Contains("1.10.2") -and !$Content.Contains("ForgeGradle:2.2-SNAPSHOT")) {
        Write-Host "Incorrect ForgeGradle" -ForegroundColor Red;
      }

      if ($Line.Contains("1.12.2") -and !$Content.Contains("ForgeGradle:2.3-SNAPSHOT")) {
        Write-Host "Incorrect ForgeGradle" -ForegroundColor Red;
      }

      if (!$Content.Contains("makeObfSourceJar")) {
        Write-Host "Missing 'makeObfSourceJar'" -ForegroundColor Red;
      }

    }
  }
}