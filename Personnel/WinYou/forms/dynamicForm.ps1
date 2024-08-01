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

function DynamicForm {
   param (
      $config,
      $width,
      $height,
      $gap = 70
   )

   . (".\configs\$($config).ps1")

   return GetConfig -width $width -height $height -gap $gap -config $config.Substring($config.IndexOf('g') + 1) 
}