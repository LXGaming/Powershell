#Requires -PSEdition Core
#Requires -Version 6.0

# For https://github.com/LXGaming/Location
$Classes = @(
    # 1.8 - 1.13.x
    "CPacketPlayer`$Rotation", "CPacketPlayer`$Position", "CPacketPlayer`$PositionRotation", "SPacketJoinGame", "SPacketPlayerPosLook", "SPacketRespawn",
    # 1.14.x 
    "CPlayerPacket`$RotationPacket", "CPlayerPacket`$PositionPacket", "CPlayerPacket`$PositionRotationPacket", "SJoinGamePacket", "SPlayerPositionLookPacket", "SRespawnPacket"
);
foreach ($File in Get-ChildItem -Path ".\versions" -Filter "*-mapped.json") {

    $Version = Get-Content -Path $File.FullName | ConvertFrom-Json -AsHashtable;
    Write-Host "Processing $($Version.version.name) ($($Version.version.protocol))";

    $Packets = @{};
    foreach ($Key in $Version.packets.packet.Keys) {
        $Packet = $Version.packets.packet.$Key;
        $Class = $Packet.class.Split("/");
        if ($Classes.Contains($Class[$Class.Count - 1])) {
            $Packets.Add($Packet.class, $Packet.id);
        }
    }

    # Ordering
    foreach ($Class in $Classes) {
        foreach ($Packet in $Packets.Keys) {
            if ($Packet.EndsWith($Class)) {
                Write-Host "$($Class): " -ForegroundColor Cyan -NoNewline;
                Write-Host "$($Packets.$Packet)" -ForegroundColor Green;
            }
        }
    }
}