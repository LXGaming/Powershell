Write-Host "LX's School Wallpaper Chnage Script Has Been Started" -foregroundcolor green
Write-Host ""
Write-Host "This Script Bypass Group Policys, RUN AT YOUR OWN RISK" -foregroundcolor red 
Write-Host ""

$A = "D:\Wallpaper\1.jpg"
$B = "D:\Wallpaper\2.jpg"
$C = "D:\Wallpaper\3.jpg"
$D = "D:\Wallpaper\4.jpg"
$E = "D:\Wallpaper\5.jpg"


while($true)
{

Function Set-WallPaper($Value)
{
 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value
 rundll32.exe user32.dll, UpdatePerUserSystemParameters
}
Set-WallPaper -value $A
Set-WallPaper -value $A
Set-WallPaper -value $A
Set-WallPaper -value $A
Set-WallPaper -value $A
Write-Host "Wallpaper A Has Been Changed" -foregroundcolor green
Start-Sleep -s 10

Function Set-WallPaper($Value)
{
 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value
 rundll32.exe user32.dll, UpdatePerUserSystemParameters
}
Set-WallPaper -value $B
Set-WallPaper -value $B
Set-WallPaper -value $B
Set-WallPaper -value $B
Set-WallPaper -value $B
Write-Host "Wallpaper B Has Been Changed" -foregroundcolor green
Start-Sleep -s 10

Function Set-WallPaper($Value)
{
 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value
 rundll32.exe user32.dll, UpdatePerUserSystemParameters
}
Set-WallPaper -value $C
Set-WallPaper -value $C
Set-WallPaper -value $C
Set-WallPaper -value $C
Set-WallPaper -value $C
Write-Host "Wallpaper C Has Been Changed" -foregroundcolor green
Start-Sleep -s 10

Function Set-WallPaper($Value)
{
 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value
 rundll32.exe user32.dll, UpdatePerUserSystemParameters
}
Set-WallPaper -value $D
Set-WallPaper -value $D
Set-WallPaper -value $D
Set-WallPaper -value $D
Set-WallPaper -value $D
Write-Host "Wallpaper D Has Been Changed" -foregroundcolor green
Start-Sleep -s 10

Function Set-WallPaper($Value)
{
 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value
 rundll32.exe user32.dll, UpdatePerUserSystemParameters
}
Set-WallPaper -value $E
Set-WallPaper -value $E
Set-WallPaper -value $E
Set-WallPaper -value $E
Set-WallPaper -value $E
Write-Host "Wallpaper E Has Been Changed" -foregroundcolor green
Start-Sleep -s 10
Write-Host "Loop" -foregroundcolor red
}