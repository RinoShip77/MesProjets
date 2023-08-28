# ###################
# Retirer les tables.
# ###################

DROP TABLE IF EXISTS ObjectifsVisites;
DROP TABLE IF EXISTS Objectifs;

DROP TABLE IF EXISTS IntervenantsVisites;
DROP TABLE IF EXISTS Intervenants;
DROP TABLE IF EXISTS CategoriesEmploi;

DROP TABLE IF EXISTS Visites;
DROP TABLE IF EXISTS Personnes;

# #####################
# Créations des tables.
# #####################

# Table PERSONNES
#
CREATE TABLE IF NOT EXISTS Personnes 
( idPersonne INT AUTO_INCREMENT PRIMARY KEY
, prenom VARCHAR(40) NOT NULL
, nom VARCHAR(40) NOT NULL
, dateNaissance DATE NOT NULL
, noAssuranceMaladie VARCHAR(12) NOT NULL
, NAS VARCHAR(9) NOT NULL
);

ALTER TABLE Personnes
ADD CONSTRAINT Personnes_NAS_UK
UNIQUE (NAS);

ALTER TABLE Personnes
ADD CONSTRAINT Personnes_noAssuranceMaladie_UK
UNIQUE (noAssuranceMaladie);

# Table VISITES
#
CREATE TABLE IF NOT EXISTS Visites
( idVisite INT AUTO_INCREMENT PRIMARY KEY
, idPersonne INT NOT NULL
, dateVisite DATETIME NOT NULL
);

ALTER TABLE Visites
ADD CONSTRAINT Visites_Personnes_FK
FOREIGN KEY (idPersonne) REFERENCES Personnes(idPersonne);

ALTER TABLE Visites
ADD CONSTRAINT Visites_dateVisite_idPersonne_UK
UNIQUE (dateVisite, idPersonne);

# Table OBJECTIFS
# 
CREATE TABLE IF NOT EXISTS Objectifs
( idObjectif INT AUTO_INCREMENT PRIMARY KEY
, nom VARCHAR(50) NOT NULL
);

ALTER TABLE Objectifs 
ADD CONSTRAINT Objectifs_nom_UK
UNIQUE (nom);

# Table d'association OBJECTIFS / VISITES
#
CREATE TABLE IF NOT EXISTS ObjectifsVisites
( idObjectifVisite INT AUTO_INCREMENT PRIMARY KEY
, idObjectif INT NOT NULL
, idVisite INT NOT NULL
);

ALTER TABLE ObjectifsVisites
ADD CONSTRAINT ObjectifsVisites_Objectifs_FK
FOREIGN KEY (idObjectif) REFERENCES Objectifs(idObjectif);

ALTER TABLE ObjectifsVisites
ADD CONSTRAINT ObjectifsVisites_Visites_FK
FOREIGN KEY (idVisite) REFERENCES Visites(idVisite);

ALTER TABLE ObjectifsVisites
ADD CONSTRAINT ObjectifsVisites_UK
UNIQUE (idObjectif, idVisite);

# Table CATEGORIESEMPLOI
#
CREATE TABLE IF NOT EXISTS CategoriesEmploi
( idCategorieEmploi INT AUTO_INCREMENT PRIMARY KEY
, titre VARCHAR(75) NOT NULL
);

ALTER TABLE CategoriesEmploi
ADD CONSTRAINT CategoriesEmploi_titre_UK
UNIQUE (titre);

# Table INTERVENANTS
#
CREATE TABLE IF NOT EXISTS Intervenants
( idIntervenant INT AUTO_INCREMENT PRIMARY KEY
, idCategorieEmploi INT NOT NULL
, prenom VARCHAR(40) NOT NULL
, nom VARCHAR(40) NOT NULL
, noEmploye VARCHAR(5) NOT NULL
);

ALTER TABLE Intervenants
ADD CONSTRAINT Intervenants_CategoriesEmploi_FK
FOREIGN KEY (idCategorieEmploi) REFERENCES CategoriesEmploi(idCategorieEmploi);

ALTER TABLE Intervenants
ADD CONSTRAINT Intervenants_noEmploye_UK
UNIQUE (noEmploye);

# Table d'association INTERVENANTS / VISITES
#
CREATE TABLE IF NOT EXISTS IntervenantsVisites
( idIntervenantVisite INT AUTO_INCREMENT PRIMARY KEY
, idIntervenant INT NOT NULL
, idVisite INT NOT NULL
);

ALTER TABLE IntervenantsVisites
ADD CONSTRAINT IntervenantsVisites_Intervenants_FK
FOREIGN KEY (idIntervenant) REFERENCES Intervenants(idIntervenant);

ALTER TABLE IntervenantsVisites
ADD CONSTRAINT IntervenantsVisites_Visites_FK
FOREIGN KEY (idVisite) REFERENCES Visites(idVisite);

ALTER TABLE IntervenantsVisites
ADD CONSTRAINT IntervenantsVisites_UK
UNIQUE (idIntervenant, idVisite);

# ######################
# Insertion des données.
# ######################

# Categories d'emploi
#
INSERT INTO CategoriesEmploi
( titre )
VALUES
( 'Infirmier.ère' )
, 
( 'Omnipraticien.enne' )
, 
( 'Gynécologue' )
, 
( 'Travailleur.euse sociale' )
, 
( 'Obstétricien.enne' )
, 
( 'Psychoéducateur.trice' )
, 
( 'Dentiste' )
, 
( 'Nutritionniste' )
, 
( 'Gériatre' );

# Intervenants (membres du personnel)
#

# Le personne infirmier ...
INSERT INTO Intervenants
( idCategorieEmploi, prenom, nom, noEmploye )
VALUES
( (SELECT idCategorieEmploi FROM CategoriesEmploi WHERE titre = 'Infirmier.ère')
, 'Catherine'
, 'Mann'
, '1933'
);

INSERT INTO Intervenants
( idCategorieEmploi, prenom, nom, noEmploye )
VALUES
( (SELECT idCategorieEmploi FROM CategoriesEmploi WHERE titre = 'Infirmier.ère')
, 'Adrian'
, 'Krawczyk'
, '3331'
);

INSERT INTO Intervenants
( idCategorieEmploi, prenom, nom, noEmploye )
VALUES
( (SELECT idCategorieEmploi FROM CategoriesEmploi WHERE titre = 'Infirmier.ère')
, 'Fannie'
, 'Element'
, '2411'
);

INSERT INTO Intervenants
( idCategorieEmploi, prenom, nom, noEmploye )
VALUES
( (SELECT idCategorieEmploi FROM CategoriesEmploi WHERE titre = 'Infirmier.ère')
, 'Aliane'
, 'Yates'
, '2327'
);

INSERT INTO Intervenants
( idCategorieEmploi, prenom, nom, noEmploye )
VALUES
( (SELECT idCategorieEmploi FROM CategoriesEmploi WHERE titre = 'Infirmier.ère')
, 'Bethany'
, 'Gagnon'
, '1544'
);

# Les omnipraticiens ...
INSERT INTO Intervenants
( idCategorieEmploi, prenom, nom, noEmploye )
VALUES
( (SELECT idCategorieEmploi FROM CategoriesEmploi WHERE titre = 'Omnipraticien.enne')
, 'Frédérique'
, 'Vallée'
, '0698'
);

INSERT INTO Intervenants
( idCategorieEmploi, prenom, nom, noEmploye )
VALUES
( (SELECT idCategorieEmploi FROM CategoriesEmploi WHERE titre = 'Omnipraticien.enne')
, 'Frédéric'
, 'Viscardi'
, '0794'
);

# Les autres spécialistes ...
INSERT INTO Intervenants
( idCategorieEmploi, prenom, nom, noEmploye )
VALUES
( (SELECT idCategorieEmploi FROM CategoriesEmploi WHERE titre = 'Gynécologue')
, 'Manuella'
, 'Desrosiers'
, '5466'
);

INSERT INTO Intervenants
( idCategorieEmploi, prenom, nom, noEmploye )
VALUES
( (SELECT idCategorieEmploi FROM CategoriesEmploi WHERE titre = 'Travailleur.euse sociale')
, 'Vincent'
, 'Laverdière'
, '5810'
);

INSERT INTO Intervenants
( idCategorieEmploi, prenom, nom, noEmploye )
VALUES
( (SELECT idCategorieEmploi FROM CategoriesEmploi WHERE titre = 'Nutritionniste')
, 'Sophy'
, 'Troy'
, '6574'
);

INSERT INTO Intervenants
( idCategorieEmploi, prenom, nom, noEmploye )
VALUES
( (SELECT idCategorieEmploi FROM CategoriesEmploi WHERE titre = 'Gériatre')
, 'Eric'
, 'Parent'
, '7020'
);

# Objectifs
# 

INSERT INTO Objectifs
( nom )
VALUES
( 'Vaccin' )
,
( 'Consultation' )
, 
( 'Examen' )
, 
( 'Évaluation' )
, 
( 'Soins' );

# Personnes et leurs visites détaillées.
#

# Isabelle Chapleau
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Isabelle'
, 'Chapleau'
, '2019-05-20'
, 'ISAC19552010'
, '234616167'
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ISAC19552010')
, '2019-08-15 13:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Vaccin')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-08-15 13:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ISAC19552010')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '0698')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-08-15 13:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ISAC19552010')
  )
);

# Sylvie Chapleau
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Sylvie'
, 'Chapleau'
, '2000-09-21'
, 'SYLC00592110'
, '256634487'
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
, '2019-05-01 09:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Examen')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-05-01 09:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '0698')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-05-01 09:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
, '2019-04-03 09:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Examen')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-04-03 09:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '0698')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-04-03 09:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
, '2019-03-15 09:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Examen')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-03-15 09:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '0698')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-03-15 09:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
, '2019-02-15 12:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Examen')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-02-15 12:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '0698')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-02-15 12:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
, '2019-12-21 15:15'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Examen')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-12-21 15:15'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '5466')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-12-21 15:15'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
, '2019-10-10 12:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Examen')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-10-10 12:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '0698')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-10-10 12:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
, '2014-01-12 18:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Vaccin')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2014-01-12 18:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '0698')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2014-01-12 18:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'SYLC00592110')
  )
);

# Ernest Constantin
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Ernest'
, 'Constantin'
, '1940-11-02'
, 'ERNC40110203'
, '219987346'
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
, '2020-02-05 11:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2020-02-05 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '7020')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2020-02-05 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
, '2019-02-28 11:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-02-28 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '7020')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-02-28 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
, '2018-02-05 11:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-02-05 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '7020')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-02-05 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
, '2017-03-01 11:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2017-03-01 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '7020')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2017-03-01 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
, '2016-02-18 11:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2016-02-18 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '7020')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2016-02-18 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
, '2015-02-22 11:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2015-02-22 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '7020')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2015-02-22 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ERNC40110203')
  )
);

# Maude Alix
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Maude'
, 'Alix'
, '1995-07-07'
, 'MAUA95570715'
, '276354410'
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MAUA95570715')
, '2019-11-27 08:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Soins')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-11-27 08:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MAUA95570715')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '1933')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-11-27 08:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MAUA95570715')
  )
);

# Mélanie Carpentier
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Mélanie'
, 'Carpentier'
, '1987-01-28'
, 'MELC87512803'
, '264985310'
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MELC87512803')
, '2018-11-01 08:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Soins')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-11-01 08:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MELC87512803')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '1933')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-11-01 08:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MELC87512803')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MELC87512803')
, '2019-11-01 10:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Soins')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-11-01 10:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MELC87512803')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '3331')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-11-01 10:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MELC87512803')
  )
);

# Peter Esposito
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Peter'
, 'Esposito'
, '1975-11-09'
, 'PETE75110907'
, '206544321'
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
, '2019-03-10 17:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-03-10 17:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '5810')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-03-10 17:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
, '2019-03-24 17:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-03-24 17:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '5810')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-03-24 17:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
, '2019-04-07 18:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-04-07 18:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '5810')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-04-07 18:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
, '2019-04-14 18:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-04-14 18:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '5810')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-04-14 18:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
, '2019-04-21 18:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-04-21 18:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '5810')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-04-21 18:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
, '2019-04-28 18:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-04-28 18:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '5810')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-04-28 18:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
, '2019-05-05 18:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-05-05 18:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '5810')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-05-05 18:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
, '2019-05-12 18:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-05-12 18:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '5810')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-05-12 18:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'PETE75110907')
  )
);

# Alexandre Bernard
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Alexandre'
, 'Bernard'
, '1986-09-30'
, 'ALEB86093014'
, '246312401'
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
, '2016-04-08 20:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Évaluation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2016-04-08 20:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '6574')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2016-04-08 20:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
, '2016-04-12 20:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2016-04-12 20:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '6574')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2016-04-12 20:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
, '2016-05-13 20:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2016-05-13 20:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '6574')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2016-05-13 20:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
, '2016-08-31 20:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2016-08-31 20:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '6574')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2016-08-31 20:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
, '2016-11-20 20:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2016-11-20 20:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '6574')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2016-11-20 20:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
, '2017-10-15 20:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2017-10-15 20:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '6574')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2017-10-15 20:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALEB86093014')
  )
);

# Esperanza Valiquette
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Esperanza'
, 'Nantes'
, '1992-05-21'
, 'ESPN92552111'
, '254663318'
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
, '2017-07-12 15:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Évaluation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2017-07-12 15:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '6574')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2017-07-12 15:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
, '2017-07-20 15:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2017-07-20 15:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '6574')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2017-07-20 15:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
, '2018-01-15 15:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-01-15 15:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '6574')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-01-15 15:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
, '2018-07-01 15:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-07-01 15:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '6574')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-07-01 15:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
, '2019-01-21 15:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-01-21 15:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '6574')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-01-21 15:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ESPN92552111')
  )
);

# Béatrice Fauteux
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Béatrice'
, 'Fauteux'
, '1990-09-19'
, 'BEAF90591909'
, '246413114'
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'BEAF90591909')
, '2020-02-06 10:15'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Évaluation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2020-02-06 10:15'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'BEAF90591909')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '6574')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2020-02-06 10:15'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'BEAF90591909')
  )
);

# 
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Mayna'
, 'Mukete'
, '1997-03-29'
, 'MAYM975329'
, '205579431'
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MAYM975329')
, '2018-06-23 19:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-06-23 19:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MAYM975329')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '5466')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-06-23 19:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MAYM975329')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MAYM975329')
, '2018-06-26 11:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Soins')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-06-26 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MAYM975329')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '5466')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-06-26 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MAYM975329')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '2411')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2018-06-26 11:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'MAYM975329')
  )
);

# 
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Kenji'
, 'Tsumamoto'
, '1983-09-24'
, 'KENT830924'
, '263315482'
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'KENT830924')
, '2019-01-05 20:30'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-01-05 20:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'KENT830924')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '0794')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-01-05 20:30'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'KENT830924')
  )
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'KENT830924')
, '2019-01-06 10:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Soins')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-01-06 10:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'KENT830924')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '0794')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-01-06 10:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'KENT830924')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '2411')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2019-01-06 10:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'KENT830924')
  )
);

# Alberta Alix
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Alberta'
, 'Alix'
, '1929-05-15'
, 'ALBA29551501'
, '285574632'
);

INSERT INTO Visites
( idPersonne, dateVisite )
VALUES
( (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALBA29551501')
, '2017-06-01 14:00'
);

INSERT INTO ObjectifsVisites
( idObjectif, idVisite )
VALUES
( (SELECT idObjectif FROM Objectifs WHERE nom = 'Consultation')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2017-06-01 14:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALBA29551501')
  )
);

INSERT IntervenantsVisites
( idIntervenant, idVisite )
VALUES
( (SELECT idIntervenant FROM Intervenants WHERE noEmploye = '7020')
, (SELECT idVisite FROM Visites WHERE dateVisite = '2017-06-01 14:00'
                                  AND idPersonne = (SELECT idPersonne FROM Personnes WHERE noAssuranceMaladie = 'ALBA29551501')
  )
);

# 
INSERT INTO Personnes 
( prenom, nom, dateNaissance, noAssuranceMaladie, NAS )
VALUES
( 'Viggo'
, 'Morneau'
, '1958-10-20'
, 'VIGM58102004'
, '264788451'
);