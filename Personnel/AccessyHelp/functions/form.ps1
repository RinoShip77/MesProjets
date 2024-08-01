<#
.DESCRIPTION
  This function take the context (where it's call) and two lists to populate
  the ComboBox of the form. It will display one WindowsForm instance
  (depending on the context). It will return an object that contains
  the result of the dialog box and all the values enter by the user
  in the controls.
#>

#region Include all the code libraries necessary for the function
using namespace System.Windows.Forms
using namespace System.Drawing
using assembly System.Windows.Forms
#endregion Include all the code libraries necessary for the function

function MainForm {
   #region Form window
   $form = [Form] @{
      Size            = [Size]::new(950, 550)
      StartPosition   = [FormStartPosition]::CenterParent
      Text            = 'Accessy'
      FormBorderStyle = [FormBorderStyle]::None
   }
   #endregion Form window

   #region Title of the page
   $titleLbl = [Label] @{
      Size      = [Size]::new(950, 70)
      Font      = [Font]::new("Arial", 36, [FontStyle]::Bold)
      BackColor = [Color]::Blue
      ForeColor = [Color]::White
      TextAlign = [ContentAlignment]::MiddleCenter
      Text      = "Which site should we analyse"
   }
   #endregion Title of the page

   #region Credentials group
   $credentialsGrp = [GroupBox] @{
      Location  = [Point]::new(155, 100)
      Size      = [Size]::new(320, 150)
      FlatStyle = [FlatStyle]::Flat
   }

   #region Username group
   $usernameGrp = [GroupBox] @{
      Size      = [Size]::new(320, 75)
      FlatStyle = [FlatStyle]::Flat
   }

   #region Username label
   $usernameLbl = [Label] @{
      Location = [Point]::new(20, 35)
      Size     = [Size]::new(100, 20)
      Font     = [Font]::new("Microsoft Sans Serif", 12)
      Text     = "Username:"
   }
   #endregion Username label

   #region Username textbox
   $usernameTbo = [TextBox] @{
      Location = [Point]::new(140, 30)
      Size     = [Size]::new(150, 50)
      Font     = [Font]::new("Microsoft Sans Serif", 15)
   }
   #endregion Username textbox

   $usernameGrp.Controls.AddRange(@(
         $usernameLbl,
         $usernameTbo
      ))
   #endregion Username group
    
   #region Password group
   $passwordGrp = [GroupBox] @{
      Size      = [Size]::new(320, 80)
      Top       = 70
      FlatStyle = [FlatStyle]::Flat
   }

   #region Password label
   $passwordLbl = [Label] @{
      Location = [Point]::new(20, 35)
      Size     = [Size]::new(100, 20)
      Font     = [Font]::new("Microsoft Sans Serif", 12)
      Text     = "Password:"
   }
   #endregion Password label

   #region Password textbox
   $passwordTbo = [TextBox] @{
      Location     = [Point]::new(140, 30)
      Size         = [Size]::new(150, 50)
      Font         = [Font]::new("Microsoft Sans Serif", 15)
      PasswordChar = '*'
   }
   #endregion Password textbox

   $passwordGrp.Controls.AddRange(@(
         $passwordLbl,
         $passwordTbo
      ))
   #endregion Password group

   $credentialsGrp.Controls.AddRange(@(
         $usernameGrp,
         $passwordGrp
      ))
   #endregion Credentials group

   #region Criteria group
   $criteriaGrp = [GroupBox] @{
      Location  = [Point]::new(475, 100)
      Size      = [Size]::new(320, 150)
      FlatStyle = [FlatStyle]::Flat
   }

   #region Criteria label
   $criteriaLbl = [Label] @{
      Location = [Point]::new(40, 10)
      Size     = [Size]::new(260, 20)
      Font     = [Font]::new("Microsoft Sans Serif", 12)
      Text     = 'Which criteria should should we test:'
   }
   #endregion Criteria label

   #region Criteria info label
   $criteriaInfoLbl = [Label] @{
      Location  = [Point]::new(75, 30)
      Size      = [Size]::new(140, 25)
      Font      = [Font]::new("Microsoft Sans Serif", 10)
      ForeColor = [Color]::DodgerBlue
      TextAlign = [ContentAlignment]::MiddleCenter
      Text      = "WCAG (Level A) is the default:"
   }
   #endregion Criteria info label

   #region Criteria combobox
   $criteriaCbo = [ComboBox] @{
      Location      = [Point]::new(40, 75)
      DropDownStyle = [ComboBoxStyle]::DropDownList
      Font          = [Font]::new("Microsoft Sans Serif", 15)
      Width         = 250
   }
   $criteriaCbo.Items.Add('WCAG (Level A)')
   $criteriaCbo.Items.Add('WCAG (Level AA)')
   $criteriaCbo.SelectedIndex = 0
   #endregion Criteria combobox

   $criteriaGrp.Controls.AddRange(@(
         $criteriaLbl,
         $criteriaInfoLbl
         $criteriaCbo
      ))
   #endregion Criteria group

   #region URL label
   $urlLbl = [Label] @{
      Location = [Point]::new(300, 325)
      Size     = [Size]::new(400, 25)
      Font     = [Font]::new("Microsoft Sans Serif", 14)
      Text     = "Enter the website URL that you want to check:"
   }
   #endregion URL label

   #region URL textbox
   $urlTbo = [TextBox] @{
      Location = [Point]::new(100, 375)
      Size     = [Size]::new(750, 50)
      Font     = [Font]::new("Microsoft Sans Serif", 15)
   }
   #region URL textbox

   #region Navigations buttons
   $okButton = [Button] @{
      Location     = [Point]::new(400, 450)
      AutoSize     = $true
      DialogResult = [DialogResult]::OK
      BackColor    = [Color]::Green
      ForeColor    = [Color]::White
      Text         = 'Analyse'
   }
   $form.AcceptButton = $okButton

   $cancelButton = [Button] @{
      Location     = [Point]::new(475, 450)
      AutoSize     = $true
      DialogResult = [DialogResult]::Cancel
      BackColor    = [Color]::Red
      ForeColor    = [Color]::White
      Text         = 'Cancel'
   }
   $form.CancelButton = $cancelButton
   #endregion Navigations buttons

   #region Add all the control to the form
   $form.Controls.AddRange(@(
         $titleLbl,
         $credentialsGrp,
         $criteriaGrp,
         $urlLbl,
         $urlTbo,
         $okButton,
         $cancelButton
      ))
   #endregion Add all the control to the form

   #region Rounded border
   $code = @"
[System.Runtime.InteropServices.DllImport("gdi32.dll")]
public static extern IntPtr CreateRoundRectRgn(int nLeftRect, int nTopRect,
int nRightRect, int nBottomRect, int nWidthEllipse, int nHeightEllipse);
"@
   $Win32Helpers = Add-Type -MemberDefinition $code -Name "Win32Helpers" -PassThru
   $form.add_Load({
         $hrgn = $Win32Helpers::CreateRoundRectRgn(0, 0, $form.Width, $form.Height, 20, 20)
         $form.Region = [Region]::FromHrgn($hrgn)
      })
   #endregion Rounded border

   return [PSCustomObject]@{
      result      = $form.ShowDialog()
      credentials = [PSCustomObject]@{
         username = $usernameTbo.Text
         password = $passwordTbo.Text
      }
      criteria   = $criteriaCbo.SelectedItem
      url         = $urlTbo.Text
   }
}