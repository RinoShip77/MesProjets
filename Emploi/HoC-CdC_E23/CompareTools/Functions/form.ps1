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
  param (
    $context,
    $applications,
    $environments
  )

  #region Declare some variables to use inside the function
  $formTitle = $context.Name.Replace("C", " c") + " script"
  $title = $context.Name.Split("C")[0].toLower()
  #endregion Declare some variables to use inside the function

  #region Generic form for all the scipt
  #region Form window
  $form = [Form] @{
    Width         = 975
    Height        = 550
    StartPosition = [FormStartPosition]::WindowsDefaultLocation
    Text          = $formTitle
  }
  #endregion Form window

  #region Title of the page
  $titleLbl = [Label] @{
    Size      = [Size]::new(950, 70)
    Font      = [Font]::new("Arial", 36, [FontStyle]::Bold)
    BackColor = [Color]::Blue
    ForeColor = [Color]::White
    TextAlign = [ContentAlignment]::MiddleCenter
    Text      = "Which $title should be compare"
  }
  #endregion Title of the page
  
  #region Navigations buttons
  $okButton = [Button] @{
    Location     = [Point]::new(400, 450)
    AutoSize     = $true
    DialogResult = [DialogResult]::OK
    BackColor    = [Color]::Green
    ForeColor    = [Color]::White
    Text         = "OK"
  }
  $form.AcceptButton = $okButton

  $cancelButton = [Button] @{
    Location     = [Point]::new(475, 450)
    AutoSize     = $true
    DialogResult = [DialogResult]::Cancel
    BackColor    = [Color]::Red
    ForeColor    = [Color]::White
    Text         = "Cancel"
  }
  $form.CancelButton = $cancelButton
  #endregion Navigations buttons
  
  #region Add all the control to the form
  $form.Controls.AddRange(@(
      $titleLbl,
      $okButton,
      $cancelButton))
  #endregion Add all the control to the form
  #endregion Generic form for all the scipt
    
  switch ($context) {
    ApplicationComparison {
      #region Main application
      $mainAppLbl = [Label] @{
        Location = [Point]::new(400, 120)
        Size     = [Size]::new(175, 25)
        Font     = [Font]::new("Microsoft Sans Serif", 16)
        Text     = "Main application:"
      }

      $mainAppCbo = [ComboBox] @{
        Location      = [Point]::new(330, 150)
        DropDownStyle = [ComboBoxStyle]::DropDownList
        Font          = [Font]::new("Microsoft Sans Serif", 20)
        Width         = 300
      }
      $mainAppCbo.Items.AddRange($applications)
      $mainAppCbo.SelectedIndex = 0
      #endregion Main application

      #region First environment
      $firstEnvLbl = [Label] @{
        Location = [Point]::new(150, 300)
        Size     = [Size]::new(200, 25)
        Font     = [Font]::new("Microsoft Sans Serif", 18)
        Text     = "First environment:"
      }

      $firstEnvCbo = [ComboBox] @{
        Location      = [Point]::new(125, 330)
        DropDownStyle = [ComboBoxStyle]::DropDownList
        Font          = [Font]::new("Microsoft Sans Serif", 15)
        Width         = 250
      }
      $firstEnvCbo.Items.AddRange($environments)
      $firstEnvCbo.SelectedIndex = 0
      #endregion First environment

      #region Second environment
      $secondEnvLbl = [Label] @{
        Location = [Point]::new(610, 300)
        Size     = [Size]::new(240, 25)
        Font     = [Font]::new("Microsoft Sans Serif", 18)
        Text     = "Second environment:"
      }

      $secondEnvCbo = [ComboBox] @{
        Location      = [Point]::new(600, 330)
        DropDownStyle = [ComboBoxStyle]::DropDownList
        Font          = [Font]::new("Microsoft Sans Serif", 15)
        Width         = 250
      }
      $secondEnvCbo.Items.AddRange($environments)
      $secondEnvCbo.SelectedIndex = 1
      #endregion Second environment

      #region Add all the control to the form
      $form.Controls.AddRange(@(
          $mainAppLbl,
          $mainAppCbo,
          $appServerLbl,
          $appServerCbo,
          $firstEnvLbl,
          $firstEnvCbo,
          $secondEnvLbl,
          $secondEnvCbo))
      #endregion Add all the control to the form
    }
    FolderComparison {
      #region First path
      $firstPathLbl = [Label] @{
        Location = [Point]::new(425, 125)
        Size     = [Size]::new(275, 25)
        Font     = [Font]::new("Microsoft Sans Serif", 14)
        Text     = "First path:"
      }

      $firstPathInfoLbl = [Label] @{
        Location  = [Point]::new(300, 150)
        Size      = [Size]::new(350, 40)
        Font      = [Font]::new("Microsoft Sans Serif", 10)
        ForeColor = [Color]::DodgerBlue
        TextAlign = [ContentAlignment]::MiddleCenter
        Text      = "Please provide a valid first path (absolute or relative).`nIt must not be empty and it must exist:"
      }

      $firstPathTbo = [TextBox] @{
        Location = [Point]::new(125, 200)
        Size     = [Size]::new(750, 50)
        Font     = [Font]::new("Microsoft Sans Serif", 15)
      }
      #endregion First path
  
      #region Second path
      $secondPathLbl = [Label] @{
        Location = [Point]::new(415, 300)
        Size     = [Size]::new(275, 25)
        Font     = [Font]::new("Microsoft Sans Serif", 14)
        Text     = "Second path:"
      }

      $secondPathInfoLbl = [Label] @{
        Location  = [Point]::new(300, 325)
        Size      = [Size]::new(350, 40)
        Font      = [Font]::new("Microsoft Sans Serif", 10)
        ForeColor = [Color]::DodgerBlue
        TextAlign = [ContentAlignment]::MiddleCenter
        Text      = "Please provide a valid second path (absolute or relative). It must not be empty and it must exist:"
      }

      $secondPathTbo = [TextBox] @{
        Location = [Point]::new(125, 375)
        Size     = [Size]::new(750, 50)
        Font     = [Font]::new("Microsoft Sans Serif", 15)
      }
      #endregion Second path
  
      #region Add all the control to the form
      $form.Controls.AddRange(@(
          $firstPathLbl,
          $firstPathInfoLbl,
          $firstPathTbo,
          $secondPathLbl,
          $secondPathInfoLbl,
          $secondPathTbo))
      #endregion Add all the control to the form
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
    result       = $form.ShowDialog()
    firstPath    = $firstPathTbo.Text
    secondPath   = $secondPathTbo.Text
    mainAppIndex = $mainAppCbo.SelectedIndex
    mainApp      = $mainAppCbo.SelectedItem
    firstEnv     = $firstEnvCbo.SelectedItem
    secondEnv    = $secondEnvCbo.SelectedItem
  }
}