<#
.DESCRIPTION
  This function take the text to display inside the form and the caption of it.
  It will display one MessageBox instance with all the parameters. It will
  return that MessageBox and all the values enter by the user in the
  controls.
#>
function PopUpBox {
  param (
    $body,
    $title
  )

  #region Give the rigth buttons and icon depending on the title name
  switch ($title) {
    Question {
      $button = [MessageBoxButtons]::YesNo
      $icon = [MessageBoxIcon]::Exclamation
    }
    Information {
      $button = [MessageBoxButtons]::OK
      $icon = [MessageBoxIcon]::Information
    }
    Warning {
      $button = [MessageBoxButtons]::OK
      $icon = [MessageBoxIcon]::Warning
    }
    Error {
      $button = [MessageBoxButtons]::RetryCancel
      $icon = [MessageBoxIcon]::Error
    }
  }
  #endregion Give the rigth buttons and icon depending on the title name

  return [MessageBox]::Show($body, $title, $button, $icon)
}

<#
.DESCRIPTION
  This function take the exception, today's date and the context (where it's
  call). It will call a function to create the error files and it will call
  another function to display one message box. This function doesn't return
  a value.
#>
function WarningBox {
  param (
    $exception,
    $date,
    $context
  )
  
  #region Call another function by giving the exception and the date as parameters
  CreateLogs -exception $exception -date $date
  #endregion Call another function by giving the exception and the date as parameters

  #region Take the result of another function (with the exception and a title as parameters) and call another function (the context) if that result is 'OK'
  $response = PopUpBox -body "$($exception)" -title "Warning"
  
  if ($response -eq [DialogResult]::OK) {
    . $context
  }
  #endregion Take the result of another function (with the exception and a title as parameters) and call another function (the context) if that result is 'OK'
}

<#
.DESCRIPTION
  This function take the context (where it's call). It will call a function to
  create the error files and it will call another function to display one
  message box. This function doesn't return a value.
#>
function ErrorBox {
  param (
    $context
  )
  
  #region Take the result of another function (with the exception and a title as parameters) and call another function (the context) if that result is 'RETRY'
  $response = PopUpBox -body "You exit the script." -title "Error"
  
  if ($response -eq [DialogResult]::Retry) {
    . $context
  }
  #endregion Take the result of another function (with the exception and a title as parameters) and call another function (the context) if that result is 'RETRY'
}

<#
.DESCRIPTION
  This function take the exception and today's date. It will create a file with
  all the errors during the execution. This function doesn't return a value.
#>
function CreateLogs {
  param (
    $exception,
    $date
  )
  
  #region Create a file (under the folder of the date of today that is also under the folder 'errors') that contains all the error during the execution
  if (-Not (Test-Path ".\errors")) {
    New-Item -Name ".\errors" -ItemType Directory -Force | Out-Null
  }
  New-Item -Name ".\errors\$date" -ItemType Directory -Force | Out-Null
  
  "[$(Get-Date -Format "HH:mm:ss")]`n$($exception | Out-String)`n" | Out-File ".\errors\$date\error.log" -Append
  #endregion Create a file (under the folder of the date of today that is also under the folder 'errors') that contains all the error during the execution
}