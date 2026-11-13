
# Format my differences criteria

In the 'differenceCteria.csv' file, your can specify the parameters for the filter when retriving the differences of the comparison (each field mustbe separated by a comma ',' in the '.csv').

1.1 In the file, you got two columns:    
| FolderToAvoid | FileExtensionToAvoid |
| :---: | :---: |
| ... | ... |

1.2 For each row that you add, it must respect this pattern:
  
    Folder,Extension

1.3 For example:
| FolderToAvoid |FileExtensionToAvoid |
| :---: | :---: |
| testFolder | .ps1 |