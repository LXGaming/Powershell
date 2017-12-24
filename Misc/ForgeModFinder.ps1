Clear-Host
$Base = Get-ChildItem -File "" -Depth 3

ForEach ($File in $Base) {
  if ($File.Name -eq "build.gradle") {
    $IsForgeMod = $False;
    foreach ($Line in Get-Content $File.FullName) {
      if ($IsForgeMod -eq $True) {
        break;
      }
      if ($Line.Contains('apply plugin: "net.minecraftforge.gradle.forge"')) {
        $IsForgeMod = $True;
      }
    }
    if ($IsForgeMod -eq $True) {
      Write-Host "Forge Mod -" (Get-Item $File.PSParentPath).FullName;
    }
  }
}