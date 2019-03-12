<#
    .SYNOPSIS
    	Windows Form Demonstration.
    
    .DESCRIPTION
        This script is a executable demonstration on some of the Windows Forms objects.
	The meaning behind this is for beginners to play around, change values and learn.

    .INFORMATION
        Version: 1.0.0
        Author: Givenname Surname
        Created: 1601-01-01
        
    .CHANGELOG
        1601-01-01: 
    	
#>

# Windows Form
Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Windows Form" # Text to display
$Form.StartPosition = "CenterScreen" # Start in center
$Form.KeyPreview = $true # Monitors key presses
$Form.TopMost = $false # Window does not overlap other windows all the time
$Form.FormBorderStyle = "FixedDialog" # Prevents resizing the window
$Form.Size = New-Object System.Drawing.Point(385,300) # Width, Height

# Tab Control
$tabcontroller = New-Object System.Windows.Forms.TabControl
$tabcontroller.Location = New-Object System.Drawing.Point(0,0) # Location in top left corner
$tabcontroller.Size = New-Object System.Drawing.Point(($Form.ClientSize.Width),($Form.ClientSize.Height)) # Dynamic size based on Form
$Form.Controls.Add($tabcontroller)

# Tab Page - Main
$tp_main = New-Object System.Windows.Forms.TabPage
$tp_main.DataBindings.DefaultDataSourceUpdateMode = 0
$tp_main.UseVisualStyleBackColor = $true
$tp_main.Text = "Main"
$tabcontroller.Controls.Add($tp_main) # Adding object to Tab Controller instead of Form

# Tab Page - Other
$tp_other = New-Object System.Windows.Forms.TabPage
$tp_other.DataBindings.DefaultDataSourceUpdateMode = 0
$tp_other.UseVisualStyleBackColor = $true
$tp_other.Text = "Other"
$tabcontroller.Controls.Add($tp_other)

# Label
$la_input = New-Object System.Windows.Forms.Label
$la_input.Location = New-Object System.Drawing.Point(15,15)
$la_input.AutoSize = $true # Change size depending on text
$la_input.Text = "Input:"
$la_input.Font = "Microsoft Sans Serif, 10"
$tp_main.Controls.Add($la_input)

# Textbox
$tb_input = New-Object System.Windows.Forms.TextBox
$tb_input.Location = New-Object System.Drawing.Point(60,15)
$tb_input.Size = New-Object System.Drawing.Point(200,23)
$tp_main.Controls.Add($tb_input)

# Button
$bt_confirm = New-Object System.Windows.Forms.Button
$bt_confirm.Size = New-Object System.Drawing.Point(100,25)
$bt_confirm.Location = New-Object System.Drawing.Point(265,13)
$bt_confirm.Text = "OK"
$tp_main.Controls.Add($bt_confirm)

# Groupbox
$gb_content = New-Object System.Windows.Forms.GroupBox
$gb_content.Location = New-Object System.Drawing.Point(15,50)
$gb_content.Size = New-Object System.Drawing.Point(340,180)
$gb_content.Text = "Displaying text:"
$tp_main.Controls.Add($gb_content)

# RichTextbox
$rtb_text = New-Object System.Windows.Forms.RichTextBox
$rtb_text.Location = New-Object System.Drawing.Point(15,15)
$rtb_text.Size = New-Object System.Drawing.Point(310,155)
$gb_content.Controls.Add($rtb_text)

# Listview
$lv_list = New-Object System.Windows.Forms.ListView
$lv_list.Size = New-Object System.Drawing.Point(370,245)
$lv_list.Location = New-Object System.Drawing.Point(0,0)
$lv_list.View = "Details"
$lv_list.GridLines = $true
$lv_list.FullRowSelect = $true
$tp_other.Controls.Add($lv_list)

# Column - Dummy (You can't align the first one, there for the solution is to have a dummy one)
$columnHeader1 = New-Object System.Windows.Forms.ColumnHeader
$columnHeader1.Width = 0
$lv_list.Columns.Add($columnHeader1) | Out-Null

# Column - Name
$columnHeader2 = New-Object System.Windows.Forms.ColumnHeader
$columnHeader2.TextAlign = "Center" # Align in center within grid
$columnHeader2.Width = ($lv_list.ClientSize.Width)/2 # Dynamic width based of Listview width
$columnHeader2.Text = "Date" # Text to display at top of column
$lv_list.Columns.Add($columnHeader2) | Out-Null # Adds column without displaying any code in terminal

# Column - Value
$columnHeader3 = New-Object System.Windows.Forms.ColumnHeader
$columnHeader3.TextAlign = "Center"
$columnHeader3.Width = ($lv_list.ClientSize.Width)/2
$columnHeader3.Text = "String"
$lv_list.Columns.Add($columnHeader3) | Out-Null

# Button was clicked
$bt_confirm.Add_Click(
{
    # Input is not empty
    if($tb_input.Text)
    {
        # Adding text to richtextbox
        $rtb_text.Text += ($tb_input.Text + "`r`n")

        # Logging in listview
        $item = New-Object System.Windows.Forms.ListViewItem("")
        $item.SubItems.Add((Get-Date).ToString("yyyy-MM-dd"))
        $item.SubItems.Add($tb_input.Text)
        $lv_list.Items.AddRange($item)
    }
    else
    {
        # Displaying popup
        [System.Windows.Forms.MessageBox]::Show(
	        "Your input is empty, try again.",
	        "null","OK","Warning"
        )
    }
})

# Key was pressed
$Form.Add_KeyDown(
{
    if($_.KeyCode -eq "Enter")
    {
        # Simulating button click
        $bt_confirm.PerformClick()
    }
    elseif($_.KeyCode -eq "Escape")
    {
        # Closing interface
        $Form.Dispose()
    }
})

[void]$Form.ShowDialog()
Write-Host "Interface was closed" -f yellow
$Form.Dispose()
