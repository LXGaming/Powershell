PowerShell.exe -windowstyle hidden {
# Script Start

# Assembly Start
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
# Assembly End

# Reference Start
$LXKsTimer = New-Object 'System.Windows.Forms.Timer'
$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
$LXKsForm = New-Object 'System.Windows.Forms.Form'
$LXKsIcon = [System.Drawing.Icon]::ExtractAssociatedIcon($PSHOME + "\powershell.exe")
$LXKsFont = New-Object System.Drawing.Font("Microsoft Sans Serif","10",[System.Drawing.FontStyle]::Regular)
$LXKsNumLockLabel = New-Object System.Windows.Forms.Label
$LXKsCapsLockLabel = New-Object System.Windows.Forms.Label
$LXKsLine = New-Object Drawing.Pen "#0783C3"
# Reference End

# EventLoad Start
$FormEvent_Load={
If([Console]::CapsLock -match "True")
{$LXKsCapsLockLabel.ForeColor = "Green";$LXKsCapsLockLabel.Text = "CapsLock On"}
Else{$LXKsCapsLockLabel.ForeColor = "Red";$LXKsCapsLockLabel.Text = "CapsLock Off"}
If([Console]::NumberLock -match "True")
{$LXKsNumLockLabel.ForeColor = "Green";$LXKsNumLockLabel.Text = "NumLock On"}
Else{$LXKsNumLockLabel.ForeColor = "Red";$LXKsNumLockLabel.Text = "NumLock Off"}
}
# EventLoad End

# TimerTick Start
$LXKsTimer_Tick={
If([Console]::CapsLock -match "True")
{$LXKsCapsLockLabel.ForeColor = "Green";$LXKsCapsLockLabel.Text = "CapsLock On"}
Else{$LXKsCapsLockLabel.ForeColor = "Red";$LXKsCapsLockLabel.Text = "CapsLock Off"}
If([Console]::NumberLock -match "True")
{$LXKsNumLockLabel.ForeColor = "Green";$LXKsNumLockLabel.Text = "NumLock On"}
Else{$LXKsNumLockLabel.ForeColor = "Red";$LXKsNumLockLabel.Text = "NumLock Off"}
}
# TimerTick End

# StateCorrection Start
$Form_StateCorrection_Load=
{
#Correct the initial state of the form to prevent the .Net maximized form issue
$LXKsForm.WindowState = $InitialFormWindowState
}
# StateCorrection End

# Cleanup Start
$Form_Cleanup_FormClosed=
{
try
{
$LXKsForm.remove_Load($FormEvent_Load)
$LXKsTimer.remove_Tick($LXKsTimer_Tick)
$LXKsForm.remove_Load($Form_StateCorrection_Load)
$LXKsForm.remove_FormClosed($Form_Cleanup_FormClosed)
}
catch [Exception]
{ }
}
# Cleanup End

# LXWebForm Start
$LXKsForm.Text = "LX Key Status"
$LXKsForm.Icon = $LXKsIcon
$LXKsForm.Font = $LXKsFont
$LXKsForm.ClientSize = '200, 25'
$LXKsForm.StartPosition = "CenterScreen"
$LXKsForm.FormBorderStyle = "FixedDialog"
$LXKsForm.MaximizeBox = $False
$LXKsForm.MinimizeBox = $False
$LXKsForm.TopMost = $True
$LXKsForm.add_Load($FormEvent_Load)
# LXWebForm End

# KeyEvent Start
$LXKsForm.KeyPreview = $True
$LXKsForm.Add_KeyDown({if($_.KeyCode -eq "Escape"){$LXKsForm.Close()}})
# KeyEvent End

# LXKSLabel Start
$LXKsNumLockLabel.Location = New-Object System.Drawing.Size(5,5)
$LXKsNumLockLabel.Width = "90"
$LXKsNumLockLabel.Height = "15"
$LXKsNumLockLabel.ForeColor = "Blue"
$LXKsNumLockLabel.Text = "Waiting"
# LXKSLabel End

# LXKSLabel Start
$LXKsCapsLockLabel.Location = New-Object System.Drawing.Size(105,5)
$LXKsCapsLockLabel.Width = "90"
$LXKsCapsLockLabel.Height = "15"
$LXKsCapsLockLabel.ForeColor = "Blue"
$LXKsCapsLockLabel.Text = "Waiting"
# LXKSLabel End

# LXKsLine Start
$LXKsGraphics = $LXKsForm.CreateGraphics()
$LXKsLine.Width = 5
$LXKsForm.Add_Paint({$LXKsGraphics.DrawLine($LXKsLine,100,0,100,25)})
# LXKsLine End

# Control Start
$LXKsForm.Controls.Add($LXKsNumLockLabel)
$LXKsForm.Controls.Add($LXKsCapsLockLabel)
# Control End

# Timer Start
$LXKsTimer.Enabled = $True
$LXKsTimer.Interval = 1
$LXKsTimer.add_Tick($LXKsTimer_Tick)
# Timer End

# ShowDialog Start
$InitialFormWindowState = $LXKsForm.WindowState
# Init the OnLoad event to correct the initial state of the form
$LXKsForm.add_Load($Form_StateCorrection_Load)
# Clean up the control events
$LXKsForm.add_FormClosed($Form_Cleanup_FormClosed)
# Show the Form
return $LXKsForm.ShowDialog()
# ShowDialog End

# Script End
}