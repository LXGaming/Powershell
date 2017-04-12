Clear-Host;
$BaseAmount = 150;

$Array = @{}

For ($Index = 0; $Index -le 10000; $Index++) {
  $Lolcoins = [Math]::Floor($BaseAmount * (($Index + 0.5) / 365));
  if ($Array.Count -ne 0 -and $Array.ContainsValue($Lolcoins)) {
    continue;
  }

  $Array.Add($Index, $Lolcoins);
}

$Array.GetEnumerator() | Sort-Object Name