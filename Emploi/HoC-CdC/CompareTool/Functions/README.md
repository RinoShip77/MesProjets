
# Directory: Functions
## Functions for the comparison scripts

    SHORT DESCRIPTION:
        Contains all functions.
    LONG DESCRIPTION:
        It hold all the functions for the good execution of both algorithm scripts
        ('folderComparison.ps1' and 'applicationCoparison.ps1').
    NOTES:
        Name: Olivier Bourgault
        Author: BourgOl
        Last edit: 2023-08-17

1.1 For each function of each scripts, I add some comments to help understand how the functions works. Unfortunately, you can't lauch any of these scripts just by calling them in the command promt <font color="red">(...\comparison.ps1)</font>. It's just dependencies for the main scripts (***'folderComparison.ps1'*** and ***'applicationCoparison.ps1'***).

1.2 To allow the script to work as expected, you will need this file architecture:
```
[RootDirectory]:.
│
└───CompareTool
    │
    ├───'FoldersComparison' and/or 'ApplicationsComparison'
    │   ├───...                    ├───...
    │   └───README.md              └───README.md
    │
    └───Functions
        ├───comparisons.ps1
        ├───errors.ps1
        ├───form.ps1
        ├───format.ps1
        └───README.md