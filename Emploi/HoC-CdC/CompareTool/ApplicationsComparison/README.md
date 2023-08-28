
# Directory: ApplicationsComparison
## Applications comparison algorithm

    SHORT DESCRIPTION:
        Compare two applicatios (environments).
    LONG DESCRIPTION:
        Read the content of a CSV file (required) where
        the data must be delimited by a comma (,). Then
        create a form to facilitate the user experience
        to retrieve the information that was fill to 
        call a function script that compare two data. 
        This function will compare the content of this 
        two environments and it will generate an HTML 
        file to see the report of the process.
    NOTES:
        Name: Olivier Bourgault
        Author: BourgOl
        Last edit: 2023-08-17
    EXAMPLE:
        ...\applicationComparison.ps1

1.1 For the perfect execution of the script, you must fill the file ***'applications.csv'***. This file is use to populate the server names, the server versions, the server addresses, etc. The correct format to fill your values is indicate in the ***'configuration'*** directory in the dedicated ***'README.md'*** file.

1.2 In addition to the preveious version, you can now see each error that happen during the execution in the ***'error'*** directory.

1.3 Plus, I add the possibility to see each differences in a separate file. The program will add them in the ***'differences'*** folder under the ***'reports'*** directory. Each of these files are organized by folder with the name of the file concern by the comparison. The comparison that generate those files will read a ***'differenceCriteria.csv'*** to filter is result. The correct format to fill your values are indicate in the ***'configuration'*** directory in the dedicated ***'README.md'*** file.

1.4 For the main function, I add some comments to help understand how the functions works.

1.5 To allow the script to work as expected, you will need this file architecture:
```
[RootDirectory]:.
│
└───CompareTool
    │
    ├───ApplicationsComparison
    │   │
    │   └───configuration
    │       ├───folderComparison
    │       │   ├───differencesCriteria.csv
    │       │   └───README.md
    │       ├───applications.csv
    │       └───README.md
    │
    └───Functions
        ├───comparisons.ps1
        ├───errors.ps1
        ├───form.ps1
        └───format.ps1