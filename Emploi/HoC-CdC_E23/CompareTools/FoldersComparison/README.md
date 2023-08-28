
# Directory: FoldersComparison
## Folders comparison algorithm

    SHORT DESCRIPTION:
        Compare two folders.
    LONG DESCRIPTION:
        This script compare the content of two folders
        inside or outside the current directory
        and it will generate an HTML file to see the
        report of the process.
    NOTES:
        Name: Olivier Bourgault
        Author: BourgOl
        Last edit: 2023-08-17
    EXAMPLE:
        ...\folderComparison.ps1

1.1 In addition to the preveious version (still with an .HTML report), I add a form (a WinForm) to facilitate the user experience. You can also see each error that happen during the execution in the ***'error'*** directory.

1.2 Plus, I add the possibility to see each differences in a separate file. The program will add them in the ***'differences'*** folder under the ***'reports'*** directory. Each of these files are organized by folder with the name of the file concern by the comparison. The comparison that generate those files will read a ***'differenceCriteria.csv'*** to filter is result. The correct format to fill your values is indicate in the ***'configuration'*** directory in the dedicated ***'README.md'*** file.

1.3 For the main function, I add some comments to help understand how the functions works.

1.4 To allow the script to work as expected, you will need this file architecture:
```
[RootDirectory]:.
│
└───CompareTool
    │
    ├───FoldersComparison
    │   └───configuration
    │       ├───differencesCriteria.csv
    │       └───README.md
    │
    └───Functions
        ├───comparisons.ps1
        ├───errors.ps1
        ├───form.ps1
        └───format.ps1