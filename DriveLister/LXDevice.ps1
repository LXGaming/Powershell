# Script Start

# Assembly Start
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
# Assembly End

# Reference Start
$LXDeviceForm = New-Object System.Windows.Forms.Form
$LXDeviceIcon = [System.Drawing.Icon]::ExtractAssociatedIcon($PSHOME + "\powershell.exe")
$LXDeviceFont = New-Object System.Drawing.Font("Times New Roman","10",[System.Drawing.FontStyle]::Regular)
$LXDeviceOKButton = New-Object System.Windows.Forms.Button
$LXDeviceCancelButton = New-Object System.Windows.Forms.Button
$LXDeviceLabel = New-Object System.Windows.Forms.Label
$LXDeviceListBox = New-Object System.Windows.Forms.ListBox
$LXDevices = Get-PSDrive -PSProvider FileSystem
# Reference End

# LXDeviceForm Start
$LXDeviceForm.Text = "LX Device"
$LXDeviceForm.Icon = $LXDeviceIcon
$LXDeviceForm.Font = $LXDeviceFont
$LXDeviceForm.Size = New-Object System.Drawing.Size(300,200) 
$LXDeviceForm.StartPosition = "CenterScreen"
$LXDeviceForm.FormBorderStyle = "FixedDialog"
$LXDeviceForm.Topmost = $True
$LXDeviceForm.MaximizeBox = $False
$LXDeviceForm.MinimizeBox = $False
# LXDeviceForm End

# KeyEvent Start
$LXDeviceForm.KeyPreview = $True
$LXDeviceForm.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
    {Invoke-Item $LXDeviceListBox.SelectedItem;$LXDeviceForm.Close()}})
$LXDeviceForm.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
    {$LXDeviceForm.Close()}})
# KeyEvent End

# LXDeviceOKButton Start
$LXDeviceOKButton.Location = New-Object System.Drawing.Size(75,120)
$LXDeviceOKButton.Size = New-Object System.Drawing.Size(75,23)
$LXDeviceOKButton.Text = "OK"
$LXDeviceOKButton.Add_Click({Invoke-Item $LXDeviceListBox.SelectedItem;$LXDeviceForm.Close()})
$LXDeviceForm.Controls.Add($LXDeviceOKButton)
# LXDeviceOKButton End

# LXDeviceCancelButton Start
$LXDeviceCancelButton.Location = New-Object System.Drawing.Size(150,120)
$LXDeviceCancelButton.Size = New-Object System.Drawing.Size(75,23)
$LXDeviceCancelButton.Text = "Cancel"
$LXDeviceCancelButton.Add_Click({$LXDeviceForm.Close()})
$LXDeviceForm.Controls.Add($LXDeviceCancelButton)
# LXDeviceCancelButton End

# LXDeviceLabel Start
$LXDeviceLabel.Location = New-Object System.Drawing.Size(10,20) 
$LXDeviceLabel.Size = New-Object System.Drawing.Size(280,20) 
$LXDeviceLabel.Text = "Please select a device:"
# LXDeviceLabel End

# LXDeviceListbox Start
$LXDeviceListBox.Location = New-Object System.Drawing.Size(10,40) 
$LXDeviceListBox.Size = New-Object System.Drawing.Size(260,20) 
$LXDeviceListBox.Height = 80
# LXDeviceListbox End

# Device Start
 foreach ($Device in $LXDevices) {
   $LXDeviceListBox.Items.Add("$Device" + ":\")
 }
# Device Start

# Control Start
$LXDeviceForm.Controls.Add($LXDeviceLabel) 
$LXDeviceForm.Controls.Add($LXDeviceListBox) 
# Control End

# ShowDialog Start
$LXDeviceForm.ShowDialog()
# ShowDialog End

#Script End