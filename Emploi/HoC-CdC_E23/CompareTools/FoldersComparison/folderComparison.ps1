<#
.SYNOPSIS
  This function doesn't take any parameters. Firstly, it will call a function
  to display the main form to facilitate the user interactions. Secondly, it
  will take both paths from the form and pass it to another function to do
  the comparison. This function doesn't return a value.
#>

#region Include all the functions for the good execution of the script
Get-ChildItem -Path "$(Split-Path $PSScriptRoot -Parent)\Functions" -Filter *.ps1 |
ForEach-Object {
  . $_.FullName
}
#endregion Include all the functions for the good execution of the script

function FolderComparison {
  #region Declare some variables to use inside the function
  $date = Get-Date -Format "yyyy-MM-dd"
  $formData = MainForm -context $MyInvocation.MyCommand
  #endregion Declare some variables to use inside the function
  
  try {
    if ($formData.result -eq [DialogResult]::Cancel) {
      #region Call a function (with the context from where it's call) that display a box with the possibility to retry the execution
      ErrorBox -context $MyInvocation.MyCommand
      #endregion Call a function (with the context from where it's call) that display a box with the possibility to retry the execution
    }
    else {
      #region Call a fonction (with both values from the form and today's date) that will generate the comparison
      FoldersComparison -firstPath $formData.firstPath -secondPath $formData.secondPath -date $date
      #endregion Call a fonction (with both values from the form and today's date) that will generate the comparison
    }
  }
  catch {
    #region Call a function (with the exception, today's date and the context from where it's call) that display a box with the error message
    WarningBox -exception $_ -date $date -context $MyInvocation.MyCommand
    #endregion Call a function (with the exception, today's date and the context from where it's call) that display a box with the error message
  }
}

#region Call the main function to start the comparison
FolderComparison
#endregion Call the main function to start the comparison