Clear-Host;
$Files = Get-ChildItem "" -Depth 100;

$Array = @{};
ForEach ($File in $Files) {
  if ($File.Extension.Equals("")) {
    continue;
  }

  if ($Array.ContainsKey($File.Extension)) {
    $Amount = $Array[$File.Extension];
    $Array.Remove($File.Extension);
    $Array.Add($File.Extension, ($Amount + 1));
  } else {
    $Array.Add($File.Extension, 1);
  }
}

$Array.GetEnumerator() | Sort-Object Name;