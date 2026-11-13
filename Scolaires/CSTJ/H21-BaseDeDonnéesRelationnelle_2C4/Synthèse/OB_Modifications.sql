######RETIRER BUT DES VISITES######
/*1*/
######ENLÈVE le "but des visites"######
/*ALTER TABLE ObjectifsVisites
DROP CONSTRAINT ObjectifsVisites_Objectifs_FK;

ALTER TABLE ObjectifsVisites
DROP COLUMN idObjectif;

DROP TABLE IF EXISTS Objectifs;*/

/*2*/
######SUPPRIME le catégorie "dentiste"######
DELETE
FROM CategoriesEmploi
WHERE titre = "Dentiste";

/*3*/
######"Béatrice Fauteux" devient "Stéphane Fauteux" avec un nouveau numéro d'assurance maladie######
UPDATE Personnes
SET prenom = "Stéphane", nom = "Fauteux", noAssuranceMaladie = "STEF90091916"
WHERE noAssuranceMaladie = "BEAF90591909";

/*4*/
######TABLE Personnes######
ALTER TABLE Personnes
MODIFY prenom VARCHAR(25),
MODIFY nom VARCHAR(25);

###TABLE Intervenants######
ALTER TABLE Intervenants
MODIFY prenom VARCHAR(25),
MODIFY nom VARCHAR(25);