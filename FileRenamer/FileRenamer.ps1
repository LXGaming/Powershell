$Files = Get-ChildItem ""

ForEach($File in $Files) {
  $Name = $File.CreationTime.Year.ToString() + "-";
  if ($File.CreationTime.Month.toString().length -eq 1) {
    $Name += "0" + $File.CreationTime.Month.ToString() + "-";
  } else {
    $Name += $File.CreationTime.Month.ToString() + "-";
  }

  if ($File.CreationTime.Day.toString().length -eq 1) {
    $Name += "0" + $File.CreationTime.Day.ToString() + "_";
  } else {
    $Name += $File.CreationTime.Day.ToString() + "_";
  }

  if ($File.CreationTime.Hour.toString().length -eq 1) {
    $Name += "0" + $File.CreationTime.Hour.ToString() + ".";
  } else {
    $Name += $File.CreationTime.Hour.ToString() + ".";
  }

  if ($File.CreationTime.Minute.toString().length -eq 1) {
    $Name += "0" + $File.CreationTime.Minute.ToString() + ".";
  } else {
    $Name += $File.CreationTime.Minute.ToString() + ".";
  }

  if ($File.CreationTime.Second.toString().length -eq 1) {
    $Name += "0" + $File.CreationTime.Second.ToString();
  } else {
    $Name += $File.CreationTime.Second.ToString();
  }

  $Name += $File.Extension.ToLower();
  Rename-Item $File.FullName $Name
  Write-Host $Name
}