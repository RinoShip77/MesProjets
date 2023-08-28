<#
.DESCRIPTION
  This function take both paths, the result of the content comparison and of the
  hash comparison. It will include them in a HTML and CSS code. It will return
  the HTML content.
#>
function FormatComparison {
  param (
    $firstPath,
    $secondPath,
    $contentComparison,
    $hashesFilesComparison
  )
  
  return $(
    "<p style=`"text-align: center; font-weight: bold; margin-bottom: 5%`"><span style=`"font-size: 5em`">Report</span><br>
        (Generate at `"$(Get-Date -Format "HH:mm")`" between `"$firstPath`" and `"$secondPath`")</p>
        <table border 1 style=`"background-color: cornFlowerBlue; border: 2px solid black; border-radius: 1%; box-shadow: 10px 10px 10px 10px gray; width: 95%; margin: auto`">
          <tr>
            <td style=`"padding: 2%`">
              <center>
                <p style=`"font-size: 2em; font-weight: bold`">Content comparison</p><hr><br>
                " + $contentComparison + "
                <div style=`"margin: 2%`">
                  <p style=`"margin-top: 5%; margin-bottom: 0`">Meaning:</p> 
                    <table border 1>
                      <tr>
                        <td style=`"text-align: center`"> <= </td>
                        <td>Appeared only in the reference object ($firstPath).</td>
                      </tr>
                      <tr>
                        <td style=`"text-align: center`"> => </td>
                        <td>Is only in the difference object ($secondPath).</td>
                      </tr>
                      <tr>
                        <td style=`"text-align: center`"> == </td>
                        <td>Is present in both objects (equal).</td>
                      </tr>
                    </table>
                </div>
              </center>
            </td>
          </tr>
          <tr>
            <td style=`"padding: 2%`">
              <p style=`"font-size: 2em; font-weight: bold; text-align: center`">Hash Comparison</p><hr><br>
              " + $hashesFilesComparison + "
            </td>
          </tr>
        </table>"
  )
}

<#
.DESCRIPTION
  This function take the index of the application selected, the name of the
  application, the environment selected in the ComboBox and the lists of
  addresses of each environment. It will find the corresponding address
  to the selected environment.It will return the associated address.
#>
function DefineAddress {
  param (
    $applicationIndex,
    $application,
    $environment,
    $environmentsAddresses
  )
  
  #region Give the rigth address depending on the environment name
  switch ($environment) {
    ProdServer {
      $address = '\\' + $environmentsAddresses.prodServerList[$applicationIndex] + '\d$\' + $application
    }
    ProdTestServer {
      $address = '\\' + $environmentsAddresses.prodTestServerList[$applicationIndex] + '\d$\' + $application
    }
    DevServer {
      $address = '\\' + $environmentsAddresses.devServerList[$applicationIndex] + '\d$\' + $application
    }
    DevTestServer {
      $address = '\\' + $environmentsAddresses.devTestServerList[$applicationIndex] + '\d$\' + $application
    }
    ProdLoc {
      $address = $environmentsAddresses.prodLocList[$applicationIndex]
    }
    ProdTestLoc {
      $address = '\\' + $environmentsAddresses.prodTestLocList[$applicationIndex] + '\d$\' + $application
    }
    DevLoc {
      $address = '\\' + $environmentsAddresses.devLocList[$applicationIndex] + '\d$\' + $application
    }
    DevTestLoc {
      $address = '\\' + $environmentsAddresses.devTestLocList[$applicationIndex] + '\d$\' + $application
    }
  }
  #endregion Give the rigth address depending on the environment name
  
  #region If the address is 'default' or 'null', the address will be the one associated to 'ProdLoc'
  if ($address.ToLower().Contains('default') -or $null -eq $address) {  
    $address = $environmentsAddresses.prodLocList[$applicationIndex]
  }
  #endregion If the address is 'default' or 'null', the address will be the one associated to 'ProdLoc'
  
  #region If the giving address contain a dash ('-'), it will just take the part before the dash ('-')
  if ($address.Contains('-')) {
    $address = $address.Split('-').Trim()[0]
  }
  #endregion If the giving address contain a dash ('-'), it will just take the part before the dash ('-')

  return $address
}

<#
.DESCRIPTION
  This function doesn't take any parameters. It will take the content of a CSV
  file and use those data's to populate multiple lists. It will return an
  object that contains the applications names, the environments names and
  an inner object that contains the lists for the environments addresses.
#>
function RetrieveApplications {
  #region Get data from CSV file
  $dataFile = Import-Csv "$(Split-Path $PSScriptRoot -Parent)\ApplicationsComparison\configuration\applications.csv"
  #endregion Get data from CSV file

  #region Create multiple lists
  $ApplicationsList = @()
  $ProdServerList = @()
  $ProdTestServerList = @()
  $DevTestServerList = @()
  $DevServerList = @()
  $ProdLocList = @()
  $ProdTestLocList = @()
  $DevTestLocList = @()
  $DevLocList = @()
  $EnvironmentsList = @(
    "ProdServer",
    "ProdTestServer",
    "DevServer",
    "DevTestServer",
    "ProdLoc",
    "ProdTestLoc",
    "DevLoc",
    "DevTestLoc"
  )
  #endregion Create multiple lists

  #region Populate the lists
  foreach ($line in $dataFile) {
    $ApplicationsList += $line.product + ' - ' + $line.serverType
    $ProdServerList += $line.prodServer
    $ProdTestServerList += $line.prodTestServer
    $DevTestServerList += $line.devTestServer
    $DevServerList += $line.devServer
    $ProdLocList += $line.prodLoc
    $ProdTestLocList += $line.prodTestLoc
    $DevTestLocList += $line.devTestLoc
    $DevLocList += $line.devLoc
  }
  #endregion Populate the lists

  return [PSCustomObject]@{
    applicationsNames     = $ApplicationsList
    environmentsNames     = $EnvironmentsList
    environmentsAddresses = [PSCustomObject]@{
      prodServerList     = $ProdServerList
      prodTestServerList = $ProdTestServerList
      devTestServerList  = $DevTestServerList
      devServerList      = $DevServerList
      prodLocList        = $ProdLocList
      prodTestLocList    = $ProdTestLocList
      devTestLocList     = $DevTestLocList
      devLocList         = $DevLocList
    }
  }
}

<#
.DESCRIPTION
  This function take the context (where it's call) and the two folders to
  compare. It will take the content of a CSV file and use those data's
  to populate multiple lists. It will also format each data to have a
  better representation. Finally, it create a separate file to show
  each differences. This function doesn't return a value.
#>
function RetrieveDifferences {
  param (
    $context,
    $firstFolder,
    $secondFolder
  )
  
  #region Get data from CSV file
  $exceptionsFile = Import-Csv "$(Split-Path $PSScriptRoot -Parent)\$context\configuration\differencesCriteria.csv"
  #endregion Get data from CSV file

  #region Create two lists
  $folderToAvoidList = @()
  $extensionToAvoidList = @()
  #endregion Create two lists
  
  #region Populate the lists of exceptions
  foreach ($line in $exceptionsFile) {   
    $folderToAvoidList += $line.folderToAvoid
    $extensionToAvoidList += $line.fileExtensionToAvoid
  }
  #endregion Populate the lists of exceptions

  #region Give each files some custom properties
  $firstFile = $firstFolder | ForEach-Object { Get-Content $_.FullName -ErrorAction SilentlyContinue | ForEach-Object { $directoryName = ($_ | Split-Path -Parent); $fileName = $_.Name; $index = 1 } { New-Object PSObject -Property @{ DirectoryName = $directoryName; FileName = $fileName; LineNumber = $index; Content = $_ }; $index++ } }
  $secondFile = $secondFolder | ForEach-Object { Get-Content $_.FullName -ErrorAction SilentlyContinue | ForEach-Object { $directoryName = ($_ | Split-Path -Parent); $fileName = $_.Name; $index = 1 } { New-Object PSObject -Property @{ DirectoryName = $directoryName; FileName = $fileName; LineNumber = $index; Content = $_ }; $index++ } }
  #endregion Give each files some custom properties

  #region Populate the lists of differences
  $differencesList += Compare-Object $firstFile $secondFile -Property Content -IncludeEqual -CaseSensitive -PassThru |
  Select-Object DirectoryName, FileName, LineNumber, Content
  #region Populate the lists of differences

  #region Create a file for each differences
  New-Item -Path ".\reports" -Name "differences" -ItemType Directory -Force | Out-Null
  $differencesList | ForEach-Object {
    if (-Not ($folderToAvoidList.Contains($_.DirectoryName))) {
      if (-Not ($extensionToAvoidList.Contains(".$($_.FileName.Split(".")[1])"))) {
        New-Item -Name "reports\differences\$($_.FileName)" -ItemType Directory -Force | Out-Null
        New-Item -Name "reports\differences\$($_.FileName)\line-$($_.LineNumber)" -ItemType Directory -Force | Out-Null
        $_ | Export-Csv -NoTypeInformation ".\reports\differences\$($_.FileName)\line-$($_.LineNumber)\($($_.FileName))_.csv" -Force
      }
    }
  }
  #endregion Create a file for each differences
}