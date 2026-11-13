<#
.DESCRIPTION
  This function take a general form and two lists to populate
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

function StaticForm {
   param (
      $configs
   )
   
   #region Create the form
   #region Form window
   $form = [Form] @{
      Size            = [Size]::new(550, 300)
      StartPosition   = [FormStartPosition]::CenterParent
      Text            = 'Accessy'
      FormBorderStyle = [FormBorderStyle]::Sizable
   }
   #endregion Form window

   #region Title of the page
   $titleLbl = [Label] @{
      Size      = [Size]::new(550, 75)
      Font      = [Font]::new("Arial", 22, [FontStyle]::Bold)
      BackColor = [Color]::Blue
      ForeColor = [Color]::White
      TextAlign = [ContentAlignment]::MiddleCenter
      Text      = "WinYou: Create your custom WinForm"
   }
   #endregion Title of the page

   #region Config group
   $configGrp = [GroupBox] @{
      Top  = 70
      Size = [Size]::new(550, 125)
   }

   #region Config label
   $configLbl = [Label] @{
      Location = [Point]::new(140, 35)
      AutoSize = $true
      Font     = [Font]::new("Microsoft Sans Serif", 12)
      Text     = "Which configuration you want?"
   }
   #endregion Config label

   #region Config combobox
   $configCbo = [ComboBox] @{
      Location      = [Point]::new(100, 75)
      DropDownStyle = [ComboBoxStyle]::DropDownList
      Font          = [Font]::new("Microsoft Sans Serif", 15)
      Width         = 300
   }
   $configCbo.Items.AddRange($configs)
   #endregion Config combobox

   $configGrp.Controls.AddRange(@(
         $configLbl,
         $configCbo
      ))
   #endregion Config group
   
   #region Navigations buttons
   $okButton = [Button] @{
      Location     = [Point]::new(180, 225)
      AutoSize     = $true
      DialogResult = [DialogResult]::OK
      Font         = [Font]::new("Microsoft Sans Serif", 12, [FontStyle]::Bold)
      BackColor    = [Color]::Green
      ForeColor    = [Color]::White
      Text         = 'Create'
   }
   $form.AcceptButton = $okButton
   
   $cancelButton = [Button] @{
      Location     = [Point]::new(250, 225)
      AutoSize     = $true
      DialogResult = [DialogResult]::Abort
      Font         = [Font]::new("Microsoft Sans Serif", 12, [FontStyle]::Bold)
      BackColor    = [Color]::Red
      ForeColor    = [Color]::White
      Text         = 'Abort'
   }
   $form.CancelButton = $cancelButton
   #endregion Navigations buttons

   #region Add all the control to the form
   $form.Controls.AddRange(@(
         $titleLbl,
         $configGrp,
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
      result = $form.ShowDialog()
      config = $configCbo.SelectedItem
   }
   #endregion Create the form
}