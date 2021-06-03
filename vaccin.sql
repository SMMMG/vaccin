--
-- Structure de la table `specialite`
--

DROP TABLE IF EXISTS `avion`;
CREATE TABLE IF NOT EXISTS  IF NOT EXISTS `avion` (
  `AV_ID` int(11) NOT NULL,
  `AV_CONST` varchar(20) DEFAULT NULL,
  `AV_MODELE` varchar(10) DEFAULT NULL,
  `AV_CAPACITE` int(11) DEFAULT NULL,
  `AV_SITE` varchar(20) DEFAULT NULL,
  UNIQUE KEY `AV_ID` (`AV_ID`)
) ENGINE=In

DROP TABLE IF EXISTS `specialite`;
CREATE TABLE IF NOT EXISTS  IF NOT EXISTS `specialite`

DROP TABLE IF EXISTS `specialite`;
DROP TABLE IF EXISTS `ecole`;
DROP TABLE IF EXISTS `enfant`;
DROP TABLE IF EXISTS `departement`;
DROP TABLE IF EXISTS `taille`;
DROP TABLE IF EXISTS `poids`;
DROP TABLE IF EXISTS `categorie_vaccin`;
DROP TABLE IF EXISTS `centre_medical`;
DROP TABLE IF EXISTS `vaccin`;
DROP TABLE IF EXISTS `medecin`;
DROP TABLE IF EXISTS `vacination`;
DROP TABLE IF EXISTS `tab_specialite_medecin`;
DROP TABLE IF EXISTS `tab_ecole_medecin`;
DROP TABLE IF EXISTS `tab_ecole_enfant`;
DROP TABLE IF EXISTS `tab_enfant_taille`;
DROP TABLE IF EXISTS `tabe_enfant_poids`;
.

CREATE TABLE IF NOT EXISTS  specialite(
   code_specialite INT,
   description VARCHAR(50),
   PRIMARY KEY(code_specialite)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO specialite VALUES
(1, 'medecine de travail'),
(2, 'Chirorgie généaliste'),
(3,'Ophtalmo');




--
-- categorie_vaccin
--

CREATE TABLE IF NOT EXISTS  categorie_vaccin(
   nom VARCHAR(50),
   description VARCHAR(50),
   PRIMARY KEY(nom)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO categorie_vaccin VALUES
('Covid', 'Covid 19 et autres'),
('Grippe', 'toutes sorte de gripe');

CREATE TABLE IF NOT EXISTS  vaccin(
   code_vaccin INT,
   decsription VARCHAR(50),
   nom VARCHAR(50) NOT NULL,
   PRIMARY KEY(code_vaccin),
   FOREIGN KEY(nom) REFERENCES categorie_vaccin(nom)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO vaccin(code_vaccin, decsription, nom) VALUES
(100, 'Astra', 'covid'),
(101, 'Pfizer','covid'),
(50,  'grip21','Grippe');

CREATE TABLE IF NOT EXISTS  ecole(
   immatricule_ecole INT,
   nom VARCHAR(50),
   adresse VARCHAR(100),
   cp VARCHAR(8),
   ville VARCHAR(50),
   nombre_eleves INT,
   PRIMARY KEY(immatricule_ecole)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ecole VALUES
(92561,'Chirac', '55 av republic', '92170', 'Vanves', 450),
(93351,'chirac', '1 rue Gambeta', '93000', 'Montreuil');


CREATE TABLE IF NOT EXISTS  enfant(
   nom VARCHAR(50),
   prenom VARCHAR(50),
   dateNaissance DATE,
   sex VARCHAR(1),
   PRIMARY KEY(nom, prenom)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO enfant values
('most','meh','20010-07-21','M'),
('most','soph','2011-6-2','F');

CREATE TABLE IF NOT EXISTS  departement(
   code_dpt VARCHAR(50),
   nom VARCHAR(50) NOT NULL,
   PRIMARY KEY(code_dpt),
   UNIQUE(nom)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS  taille(
   id_taille INT,
   taille INT NOT NULL,
   date_taille DATE,
   PRIMARY KEY(id_taille)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS  poids(
   id_poids INT,
   date_poids VARCHAR(50),
   poids DOUBLE NOT NULL,
   PRIMARY KEY(id_poids)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS  centre_medical(
   immatricule_centre INT,
   nom VARCHAR(50),
   adresse VARCHAR(100),
   cp VARCHAR(8),
   ville VARCHAR(50),
   code_dpt VARCHAR(50) NOT NULL,
   PRIMARY KEY(immatricule_centre),
   FOREIGN KEY(code_dpt) REFERENCES departement(code_dpt)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS  medecin(
   code_complementaire_medecin CHAR(5),
   nom_medecin VARCHAR(50),
   prenom VARCHAR(50),
   immatricule_centre INT,
   PRIMARY KEY(code_complementaire_medecin, nom_medecin),
   FOREIGN KEY(immatricule_centre) REFERENCES centre_medical(immatricule_centre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS  vacination(
   code_complementaire_medecin CHAR(5),
   nom_medecin VARCHAR(50),
   code_vaccin INT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   date_vaccination DATE,
   PRIMARY KEY(code_complementaire_medecin, nom_medecin, code_vaccin, nom, prenom),
   FOREIGN KEY(code_complementaire_medecin, nom_medecin) REFERENCES medecin(code_complementaire_medecin, nom_medecin),
   FOREIGN KEY(code_vaccin) REFERENCES vaccin(code_vaccin),
   FOREIGN KEY(nom, prenom) REFERENCES enfant(nom, prenom)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS  tab_specialite_medecin(
   code_complementaire_medecin CHAR(5),
   nom_medecin VARCHAR(50),
   code_specialite INT,
   PRIMARY KEY(code_complementaire_medecin, nom_medecin, code_specialite),
   FOREIGN KEY(code_complementaire_medecin, nom_medecin) REFERENCES medecin(code_complementaire_medecin, nom_medecin),
   FOREIGN KEY(code_specialite) REFERENCES specialite(code_specialite)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS  tab_ecole_medecin(
   code_complementaire_medecin CHAR(5),
   nom_medecin VARCHAR(50),
   immatricule_ecole INT,
   PRIMARY KEY(code_complementaire_medecin, nom_medecin, immatricule_ecole),
   FOREIGN KEY(code_complementaire_medecin, nom_medecin) REFERENCES medecin(code_complementaire_medecin, nom_medecin),
   FOREIGN KEY(immatricule_ecole) REFERENCES ecole(immatricule_ecole)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS  tab_ecole_enfant(
   immatricule_ecole INT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   annee INT,
   PRIMARY KEY(immatricule_ecole, nom, prenom),
   FOREIGN KEY(immatricule_ecole) REFERENCES ecole(immatricule_ecole),
   FOREIGN KEY(nom, prenom) REFERENCES enfant(nom, prenom)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS  tab_enfant_taille(
   nom VARCHAR(50),
   prenom VARCHAR(50),
   id_taille INT,
   PRIMARY KEY(nom, prenom, id_taille),
   FOREIGN KEY(nom, prenom) REFERENCES enfant(nom, prenom),
   FOREIGN KEY(id_taille) REFERENCES taille(id_taille)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS  tabe_enfant_poids(
   nom VARCHAR(50),
   prenom VARCHAR(50),
   id_poids INT,
   PRIMARY KEY(nom, prenom, id_poids),
   FOREIGN KEY(nom, prenom) REFERENCES enfant(nom, prenom),
   FOREIGN KEY(id_poids) REFERENCES poids(id_poids)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
