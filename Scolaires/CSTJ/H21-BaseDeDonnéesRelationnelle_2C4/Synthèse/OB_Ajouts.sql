######RETIRER LES TABLES######
DROP TABLE IF EXISTS VaccinsPersonnes;
DROP TABLE IF EXISTS Vaccins;
DROP TABLE IF EXISTS Cliniques;

######CRÉATIONS DES TABLES######
CREATE TABLE IF NOT EXISTS VaccinsPersonnes
(
idVaccinPersonne INT PRIMARY KEY AUTO_INCREMENT,
idVaccin INT,
idPersonne INT,
dateDerniereInjection DATE
);

CREATE TABLE IF NOT EXISTS Vaccins
(
idVaccin INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Cliniques
(
idClinique INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(75)
);

######LIENS######
ALTER TABLE VaccinsPersonnes
ADD CONSTRAINT VaccinsPersonnes_Personnes_FK
FOREIGN KEY (idPersonne) REFERENCES Personnes(idPersonne);

ALTER TABLE VaccinsPersonnes
ADD CONSTRAINT VaccinsPersonnes_Vaccins_FK
FOREIGN KEY (idVaccin) REFERENCES Vaccins(idVaccin);

ALTER TABLE Visites
ADD COLUMN idClinique INT,
ADD CONSTRAINT Visites_Cliniques_FK
FOREIGN KEY (idClinique) REFERENCES Cliniques(idClinique);

######INSERTIONS######
INSERT INTO Cliniques
(nom)
VALUE
("CLSC des Moulins"),
("CLSC des Grands Chemins"),
("CLSC Latulippe");

INSERT INTO Vaccins
(nom)
VALUE
("Repevax"),
("RRO"),
("Engerix-B");

INSERT INTO VaccinsPersonnes
(idVaccin, idPersonne, dateDerniereInjection)
VALUE
((SELECT idVaccin FROM Vaccins WHERE nom = "Repevax"), (SELECT idPersonne FROM Personnes WHERE NAS = "234616167"), "2019-08-15"),
((SELECT idVaccin FROM Vaccins WHERE nom = "RRO"), (SELECT idPersonne FROM Personnes WHERE NAS = "234616167"), "2019-08-15"),
((SELECT idVaccin FROM Vaccins WHERE nom = "Repevax"), (SELECT idPersonne FROM Personnes WHERE NAS = "256634487"), NULL),
((SELECT idVaccin FROM Vaccins WHERE nom = "RRO"), (SELECT idPersonne FROM Personnes WHERE NAS = "256634487"), NULL),
(NULL, (SELECT idPersonne FROM Personnes WHERE NAS = "219987346"), NULL),
((SELECT idVaccin FROM Vaccins WHERE nom = "Repevax"), (SELECT idPersonne FROM Personnes WHERE NAS = "276354410"), NULL),
((SELECT idVaccin FROM Vaccins WHERE nom = "RRO"), (SELECT idPersonne FROM Personnes WHERE NAS = "276354410"), NULL),
((SELECT idVaccin FROM Vaccins WHERE nom = "Repevax"), (SELECT idPersonne FROM Personnes WHERE NAS = "264985310"), "2018-09-01"),
((SELECT idVaccin FROM Vaccins WHERE nom = "Repevax"), (SELECT idPersonne FROM Personnes WHERE NAS = "206544321"), NULL),
((SELECT idVaccin FROM Vaccins WHERE nom = "Engerix-B"), (SELECT idPersonne FROM Personnes WHERE NAS = "206544321"), "2019-04-28"),
((SELECT idVaccin FROM Vaccins WHERE nom = "Repevax"), (SELECT idPersonne FROM Personnes WHERE NAS = "246312401"), NULL),
(NULL, (SELECT idPersonne FROM Personnes WHERE NAS = "254663318"), NULL),
((SELECT idVaccin FROM Vaccins WHERE nom = "Repevax"), (SELECT idPersonne FROM Personnes WHERE NAS = "246413114"), NULL),
((SELECT idVaccin FROM Vaccins WHERE nom = "RRO"), (SELECT idPersonne FROM Personnes WHERE NAS = "205579431"), "2018-06-18"),
((SELECT idVaccin FROM Vaccins WHERE nom = "Repevax"), (SELECT idPersonne FROM Personnes WHERE NAS = "263315482"), "2019-01-05"),
((SELECT idVaccin FROM Vaccins WHERE nom = "Engerix-B"), (SELECT idPersonne FROM Personnes WHERE NAS = "263315482"), "2019-01-06"),
((SELECT idVaccin FROM Vaccins WHERE nom = "Engerix-B"), (SELECT idPersonne FROM Personnes WHERE NAS = "285574632"), NULL),
((SELECT idVaccin FROM Vaccins WHERE nom = "Repevax"), (SELECT idPersonne FROM Personnes WHERE NAS = "264788451"), NULL);

######ANCIENNES TABLES######
UPDATE Visites
SET idClinique = (SELECT idClinique FROM Cliniques WHERE nom = "CLSC des Moulins")