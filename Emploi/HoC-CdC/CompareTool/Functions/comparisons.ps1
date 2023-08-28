<#
.DESCRIPTION
  This function take the first and second path to compare, the application
  concern by the comparison (if necessary), today's date and the path for
  the report (if necessary). It will call multiple functions to complete
  the comparison. This function doesn't return a value.
#>
function FoldersComparison {
  param (
    $firstPath,
    $secondPath,
    $mainApp = "",
    $date,
    $reportPath = ".\reports"
  )

  #region Delete and create (to assure a fresh execution) the directory that will contains the reports
  Remove-Item ".\reports\differences" -Force -Recurse -ErrorAction SilentlyContinue
  New-Item -Name "reports" -ItemType Directory -Force | Out-Null
  #region Delete and create (to assure a fresh execution) the directory that will contains the reports
  
  #region Assign the correct name to the report file depending on if the name of the application is empty or not
  if ($mainApp -eq "") {
    $reportFile = "comparisonReport_" + $date
  }
  else {
    $reportFile = $mainApp + '(' + $(Resolve-Path $firstPath -Relative) + "-" + $(Resolve-Path $secondPath -Relative) + ")_" + $date
  }
  #endregion Assign the correct name to the report file depending on if the name of the application is empty or not
  
  #region Do all the verification for the good execution of the function. If it fails, it will throw an exception
  if ($firstPath -eq $secondPath) {
    Throw "You have enter the same path for both directories, please enter two different path."
  }
  elseif ($firstPath -eq "") {
    Throw "The first path is empty."
  }
  elseif ($secondPath -eq "") {
    Throw "The second path is empty."
  }
  elseif ((-Not (Test-Path $firstPath)) -and (-Not (Test-Path $secondPath))) {
    Throw "Both sources directories doesn't exist, please specify two existing directories."
  }
  elseif (-Not (Test-Path $firstPath)) {
    Throw "The first source directory doesn't exist, please specify an existing directory."
  }
  elseif (-Not (Test-Path $secondPath)) {
    Throw "The second source directory doesn't exist, please specify an existing directory."
  }
  elseif (($(Get-ChildItem -Path $firstPath -Recurse | Measure-Object).Count -eq 0) -and ($(Get-ChildItem -Path $secondPath -Recurse | Measure-Object).Count -eq 0)) {
    Throw "Both sources directories are empty."
  }
  elseif ($(Get-ChildItem $firstPath -Recurse | Measure-Object).Count -eq 0) {
    Throw "The first source directory is empty."
  }
  elseif ($(Get-ChildItem $secondPath -Recurse | Measure-Object).Count -eq 0) {
    Throw "The second source directory is empty."
  }
  #endregion Do all the verification for the good execution of the function. If it fails, it will throw an exception
  else {
    #region The verifications were a success. So we proceed to complete the comparison
    Write-Host "Beginning comparison`n..."

    #region Display a progress bar in the line prompt to inform the user on the percent of completion of the comparison
    for ($index = 0; $index -le 100; $index += 5) {
      Write-Progress -Activity "Comparison in Progress" -Status "$index% Complete:" -PercentComplete $index
      Start-Sleep -Milliseconds 75
    }
    #endregion Display a progress bar in the line prompt to inform the user on the percent of completion of the comparison

    #region Declare variables for the content comparison
    $firstFolder = Get-ChildItem $firstPath -Recurse
    $secondFolder = Get-ChildItem $secondPath -Recurse
    #region Declare variables for the content comparison
    
    #region Declare variables for the hash comparison
    $firstHash = Get-ChildItem $firstPath -Recurse -File | Get-FileHash
    $secondHash = Get-ChildItem  $secondPath -Recurse -File | Get-FileHash
    $hashesFiles = $firstHash.Path + $secondHash.Path
    #region Declare variables for the hash comparison

    #region Create an object that contains the comparisons result
    $comparison = [PSCustomObject]@{
      #region Call a function (by passing the both folders to compare) that will return the content comparison result
      contentComparison     = ContentComparison -firstFolder $firstFolder -secondFolder $secondFolder
      #endregion Call a function (by passing both folders to compare) that will return the content comparison result
      
      #region Call a function (by passing both paths, both hashes collection plus the complete hash) that will return the hash comparison result
      hashesFilesComparison = HashesFilesComparison -firstPath $firstPath -secondPath $secondPath -firstHash $firstHash -secondHash $secondHash -hashesFiles $hashesFiles
      #endregion Call a function (by passing both paths, both hashes collection plus the complete hash) that will return the hash comparison result
    }
    #endregion Create an object that contains the comparisons result

    #region Call a function (that take both paths plus the result of the content and the hash comparison) that will return an object
    $body = FormatComparison -firstPath $firstPath -secondPath $secondPath -contentComparison $comparison.contentComparison -hashesFilesComparison $comparison.hashesFilesComparison
    #endregion Call a function (that take both paths plus the result of the content and the hash comparison) that will return an object
    
    
    #region Call a function that take the context plus both folders and that will create the differences files 
    RetrieveDifferences -context $MyInvocation.MyCommand -firstFolder $firstFolder -secondFolder $secondFolder
    #endregion Call a function that take the context plus both folders and that will create the differences files 
    #region The verifications were a success. So we proceed to complete the comparison

    #region Check if today's report already exist
    if (Test-Path "$($reportPath)/$($reportFile).html") {
      #region Take the result of a function that display a message box with two buttons
      $confirmation = PopUpBox -body "Today's report already exists.`nDo you want to replace the previous report [y] or create a new file [n]?" -title "Question"
      
      while ($confirmation -ne [DialogResult]::YES) {
        #region Will continue add a random number to the name of the report file
        if ($confirmation -eq [DialogResult]::NO) {
          $reportFile = $reportFile + " ($(Get-Random -Maximum 100))"
          break
        }
        #endregion Will continue add a random number to the name of the report file
        
        $confirmation = PopUpBox -body "Today's report already exists.`nDo you want to replace the previous report [y] or create a new file [n]? [y/n]:" -title "Question"
      }
      #region Take the result of a function that display a message box with two buttons
    }
    #endregion Check if today's report already exist
  
    #region Export the report to an HTML file that you can open with your web browser
    ConvertTo-HTML -Title $("Comparison report (" + $date + ")") -Body $body |
    Out-File "$($reportPath)\$($reportFile).html" -Force
    
    PopUpBox -body "Complete! Created report as `"$($reportFile + ".html")`" in the reports directory ($reportPath)." -title "Information" | Out-Null
    Write-Host -ForegroundColor Green "`nComplete! Created report as `"$($reportFile + ".html")`" in the reports directory ($reportPath)."
    #endregion Export the report to an HTML file that you can open with your web browser
  }
}

<#
.DESCRIPTION
  This function take the first and the second folder to compare. It will list
  all the files and the subfolders in those primary folders. It will also
  format each comparison to have a better visual representation and
  convert it to an HTML table. It will return the result of the
  comparison (with the rigth format).
#>
function ContentComparison {
  param (
    $firstFolder,
    $secondFolder
  )
  
  return $(Compare-Object $firstFolder $secondFolder -CaseSensitive -IncludeEqual -PassThru |
    Select-Object Directory, Name, Extension, Length, @{l = 'Result'; e = { $_.SideIndicator } }, Mode, Attributes ) |
  ConvertTo-Html -Fragment
}

<#
.DESCRIPTION
  This function take the first and the second path, the first and second hash
  collection plus the complete hash. It will compare each file by using their
  hash to tell if they are equal or unique. It will also format each
  comparison to have a better visual representation and convert it
  to an HTML table. It will return the result of the comparison
  (with the rigth format).
#>
function HashesFilesComparison {
  param (
    $firstPath,
    $secondPath,
    $firstHash,
    $secondHash,
    $hashesFiles
  )
  
  return $("
        <h3 style=`"margin-bottom: 0`">Identical files:</h3>
          From:<br>
            <table border 1>
              <tr>
                <th>" + $firstPath + "</th>
                <th>Match</th>
                <th>" + $secondPath + "</th>
              </tr>"
    #region Go trough in the collection of hashes and compare each of them
    foreach ($firstHashFile in $firstHash) {
      foreach ($secondHashFile in $secondHash) {
        if ($firstHashFile.Hash -eq $secondHashFile.Hash) {
          "<tr>
          <td>" + $firstHashFile.Path + "</td>
                <td style=`"text-align: center`">==</td>
                <td>" + $secondHashFile.Path + "</td>
                </tr>"
            
          $hashesFiles = $hashesFiles -ne $firstHashFile.Path
          $hashesFiles = $hashesFiles -ne $secondHashFile.Path
        }
      }
    }
    #endregion Go trough in the collection of hashes and compare each of them
    "</table>
            <h3 style=`"margin-top: 5%; margin-bottom: 0`">Unique files:</h3>"
    $hashesFiles
  )
}