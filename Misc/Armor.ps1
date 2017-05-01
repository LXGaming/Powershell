Clear-Host;
$Data = @{name="Armor";version="0.0.1-ALPHA";uniqueId="0000-000000-000-0000"}
Invoke-RestMethod -Uri https://lxgaming.ddns.net/analytics/armor.php -ContentType "application/x-www-form-urlencoded" -Method POST -Body $Data