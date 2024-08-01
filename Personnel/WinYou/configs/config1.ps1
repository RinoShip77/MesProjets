#region Include all the code libraries necessary for the function
using namespace System.Windows.Forms
using namespace System.Drawing
using assembly System.Windows.Forms
#endregion Include all the code libraries necessary for the function

function GetConfig {
   param (
      $width,
      $height,
      $gap,
      $config
   )
   
   #region Create the form
   #region Form window
   $form = [Form] @{
      Size            = [Size]::new($width, $height)
      StartPosition   = [FormStartPosition]::CenterParent
      Text            = 'WinYou'
      FormBorderStyle = [FormBorderStyle]::Sizable
   }
   #endregion Form window
   
   #region Title of the page
   $titleLbl = [Label] @{
      Size      = [Size]::new($form.Width, $gap)
      Font      = [Font]::new("Arial", 22, [FontStyle]::Bold)
      BackColor = [Color]::Blue
      ForeColor = [Color]::White
      TextAlign = [ContentAlignment]::MiddleCenter
      Text      = "Your dynamic window"
   }
   #endregion Title of the page

   #region OK button
   $okButton = [Button] @{
      Location     = [Point]::new((($form.Width / 2) - $gap), ($form.Height - ($gap * 1.5)))
      AutoSize     = $true
      DialogResult = [DialogResult]::OK
      Font         = [Font]::new("Microsoft Sans Serif", 12, [FontStyle]::Bold)
      BackColor    = [Color]::Green
      ForeColor    = [Color]::White
      Text         = 'Create'
   }
   $form.AcceptButton = $okButton
   
   $cancelButton = [Button] @{
      Location     = [Point]::new(($form.Width / 2), ($okButton.Location.Y))
      AutoSize     = $true
      DialogResult = [DialogResult]::Abort
      Font         = [Font]::new("Microsoft Sans Serif", 12, [FontStyle]::Bold)
      BackColor    = [Color]::Red
      ForeColor    = [Color]::White
      Text         = 'Abort'
   }
   $form.CancelButton = $cancelButton
   #endregion Cancel button
   
   #region Add all the control to the form
   $form.Controls.AddRange(@(
         $titleLbl,
         $okButton,
         $cancelButton
      ))
   #endregion Add all the control to the form
   
   switch ($config) {
      1 { 
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
            Location  = [Point]::new(95, 30)
            Size      = [Size]::new(140, 35)
            Font      = [Font]::new("Microsoft Sans Serif", 10)
            ForeColor = [Color]::DodgerBlue
            TextAlign = [ContentAlignment]::MiddleCenter
            Text      = "WCAG (Level A) is the default:"
         }
         #endregion Criteria info label

         #region Criteria combobox
         $criteriaCbo = [ComboBox] @{
            Location      = [Point]::new(40, 90)
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

         #region Add all the control to the form
         $form.Controls.AddRange(@(
               $credentialsGrp,
               $criteriaGrp,
               $urlLbl,
               $urlTbo
            ))
         #endregion Add all the control to the form
      }
      2 {

      }
      3 {

      }
   }
      
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
      result = $form.ShowDialog()
   }
   #endregion Create the form
}