#region Include all the functions for the good execution of the script
Get-ChildItem -Path .\forms\dynamicForm.ps1 | Out-Null
#endregion Include all the functions for the good execution of the script
#region Include all the functions for the good execution of the script
. ('.\forms\dynamicForm.ps1')
#endregion Include all the functions for the good execution of the script

#region Include all the differents configurations possible
$configs = Get-ChildItem -Path .\configs\*.ps1 | ForEach-Object { $_.BaseName }
#endregion Include all the differents configurations possible

function Main {
   $response = StaticForm -configs $configs

   if ($response.result -ne [DialogResult]::OK) {
      $response = [MessageBox]::Show('You exit the script.', 'Error', [MessageBoxButtons]::RetryCancel, [MessageBoxIcon]::Error)
  
      if ($response -eq [DialogResult]::Retry) {
         Main
      }   
   }
   else {
      if ([String]::IsNullOrEmpty($response.config)) {
         [MessageBox]::Show('You must select a configuration to continue', 'Empty selection', [MessageBoxButtons]::OK, [MessageBoxIcon]::Warning)
         Main
      }
      else {
         $width = 950 #1500
         $height = 550 #750

         $dynamic = DynamicForm -config $response.config -width $width -height $height
         if ($dynamic.result -eq [DialogResult]::Abort) {
            Main
         }
      }
   }
}

Main