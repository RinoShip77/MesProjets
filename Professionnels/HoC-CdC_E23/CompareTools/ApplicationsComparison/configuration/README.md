
# Format my server data

In the 'applications.csv' file, your can specify the parameters for the servers when executing the comparison (each field mustbe separated by a comma ',' in the '.csv').

1.1 In the file, you got two primary columns (that precise the application and his server):
| Product | ServerType |
| :---: | :---: |
| ... | ... |
    
1.2 And heigth other columns (that preciser the differents environments for the application):
| ProdServer | ProdTestServer | DevTestServer | DevServer | ProdLoc | ProdTestLoc | DevTestLoc | DevLoc |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| ... | ... | ... | ... | ... | ... | ... | ... |

1.3 For each row that you add, it must respect this pattern:
    
    Product,ServerType,ProdServer,ProdTestServer,DevTestServer,DevServer,ProdLoc,ProdTestLoc,DevTestLoc,DevLoc

1.4 For example:
| Product | ServerType | ProdServer | ProdTestServer | DevTestServer | DevServer | ProdLoc | ProdTestLoc | DevTestLoc | DevLoc |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Assyst | Web Server1 | WVM0PPWBIASYST1 | WVM0PTWBIASYST1 | WVM0DTWBIASYST1 | WVM0TTWBIASYST1 | ,\\Wvm0ppwbiasyst1\d$\Apps\Assyst\assystEnterprise | Default | Default | Default |