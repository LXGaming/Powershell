Clear-Host
$Base = Get-ChildItem -File "" -Depth 2
$Decompiler = "";

ForEach ($File in $Base) {
  if ($File.Extension -ieq "jar") {
    continue;
  }

  if (Test-Path -Path $File.FullName.Replace(".jar", "")) {
    continue;
  }

  Write-Host ("Processing '" + $File.Name + "'...");
  $ProcessStartInfo = New-Object System.Diagnostics.ProcessStartInfo;
  $ProcessStartInfo.FileName = ("java");
  $ProcessStartInfo.RedirectStandardError = $True
  $ProcessStartInfo.RedirectStandardOutput = $True
  $ProcessStartInfo.UseShellExecute = $False
  $ProcessStartInfo.CreateNoWindow = $True
  $ProcessStartInfo.Arguments = ("-jar " + $Decompiler + " -jar " + $File.FullName);
  $Process = New-Object System.Diagnostics.Process;
  $Process.StartInfo = $ProcessStartInfo;
  $Process.Start() | Out-Null;

  while (!$Process.HasExited) {
    $Line = $Process.StandardOutput.ReadLine();
    if (!$Line) {
      continue;
    }

    if ($Line.Contains("NetworkRegistry.INSTANCE.") -or $Line.Contains("FMLNetworkEvent.ClientCustomPacketEvent") -or $Line.Contains("FMLNetworkEvent.ServerCustomPacketEvent")) {
      Write-Host ("Found target code in '" + $File.Name + "'");
      $Process.Kill();
    }
  }
}