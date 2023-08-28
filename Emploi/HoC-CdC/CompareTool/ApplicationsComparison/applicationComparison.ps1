<#
.SYNOPSIS
  This function doesn't take any parameters. Firstly, it will call a function
  to retrive the data from a CSV file. Secondly, it will call a function to
  display the main form to facilitate the user interactions. Thirdly, it
  will pass some informations from the form and pass it to a function.
  Finally, it will pass the result of that function to another
  function to do the comparison. This function doesn't return
  a value.
#>

#region Include all the functions for the good execution of the script
Get-ChildItem -Path "$(Split-Path $PSScriptRoot -Parent)\Functions" -Filter *.ps1 |
ForEach-Object {
  . $_.FullName
}
#endregion Include all the functions for the good execution of the script

function ApplicationComparison {
  #region Declare some variables to use inside the function
  $date = Get-Date -Format "yyyy-MM-dd"
  $csvData = RetrieveApplications
  $formData = MainForm -context $MyInvocation.MyCommand -applications $csvData.applicationsNames -environments $csvData.environmentsNames
  #endregion Declare some variables to use inside the function

  try {
    if ($formData.result -eq [DialogResult]::Cancel) {
      #region Call a function (with the context from where it's call) that display a box with the possibility to retry the execution
      ErrorBox -context $MyInvocation.MyCommand
      #endregion Call a function (with the context from where it's call) that display a box with the possibility to retry the execution
    }
    else {
      #region Assign values from the form and pass it to a function
      $firstAddress = DefineAddress -ApplicationIndex $formData.mainAppIndex -Application $formData.mainApp -Environment $formData.firstEnv -environments $csvData.environmentsAddresses
      $secondAddress = DefineAddress -ApplicationIndex $formData.mainAppIndex -Application $formData.mainApp -Environment $formData.secondEnv -environments $csvData.environmentsAddresses
      #endregion Assign values from the form and pass it to a function

      #region Call a fonction (with both values from the form and today's date) that will generate the comparison
      FoldersComparison -firstPath $firstAddress -secondPath $secondAddress -mainApp $mainAppCbo.SelectedItem -date $date
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
ApplicationComparison
#endregion Call the main function to start the comparison