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
Get-ChildItem -Path ".\Functions" -Filter *.ps1 |
ForEach-Object {
  . $_.FullName
}
#endregion Include all the functions for the good execution of the script

function AnalyseAccessibility {
  #region Declare some variables to use inside the function
  $formData = MainForm
  #endregion Declare some variables to use inside the function

  try {
    if ($formData.result -eq [DialogResult]::Cancel) {
      #region Call a function (with the context from where it's call) that display a box with the possibility to retry the execution
      ErrorBox -context $MyInvocation.MyCommand
      #endregion Call a function (with the context from where it's call) that display a box with the possibility to retry the execution
    }
    else {
      if (-Not (Test-Path ".\reports")) {
        New-Item -Name ".\reports" -ItemType Directory -Force | Out-Null
        New-Item -Name ".\reports\$(Get-Date -Format "yyyy-MM-dd")" -ItemType Directory -Force | Out-Null
      }
      
      switch ($formData.criteria) {
        'WCAG (Level A)' {
          $images = ((Invoke-WebRequest -Uri $formData.url).Images) | Where-Object {
            $null -ne $_.Alt
          }
        }
        'Wcag (Level AA)' {
        }
      }
      
      $images | Out-File -FilePath ".\reports\$(Get-Date -Format "yyyy-MM-dd")\$($formData.criteria -replace '\s','').html"
    }
  }
  catch {
    #region Call a function (with the exception, today's date and the context from where it's call) that display a box with the error message
    WarningBox -exception $_ -date $date -context $MyInvocation.MyCommand
    #endregion Call a function (with the exception, today's date and the context from where it's call) that display a box with the error message
  }
}

#region Call the main function to start the comparison
AnalyseAccessibility
#endregion Call the main function to start the comparison