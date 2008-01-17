-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `rubyparis`
-- 

-- ICI!!!!!!! Eventuellement créer tables club et selection nationale

DROP DATABASE IF EXISTS `rubyparis_production`;
CREATE DATABASE `rubyparis_production` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `rubyparis_production`;


CREATE TABLE `entraineur` (
	`idEntraineur` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`idEntraineur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `equipe` (
	`idEquipe` int unsigned NOT NULL auto_increment,
	`entraineur` int unsigned NOT NULL,
	`nom` varchar(32) NOT NULL,
	`provenanve` varchar(32) NOT NULL,
	`url` varchar(32) NOT NULL,
	`stade` varchar(32) NOT NULL,
	PRIMARY KEY (`idEquipe`),
	FOREIGN KEY (`entraineur`) REFERENCES `entraineur`(`idEntraineur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `arbitre` (
	`idArbitre` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`idArbitre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `administrateur` (
	`idAdministrateur` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`idAdministrateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `competition` (
	`idCompetition` int unsigned NOT NULL auto_increment,
	`administrateur` int unsigned NOT NULL,
	`nom` varchar(32) NOT NULL,
	`description` varchar(128) NOT NULL,
	`dateDebut` date NOT NULL,
	`dateFin` date NOT NULL,
	PRIMARY KEY (`idCompetition`),
	FOREIGN KEY (`administrateur`) REFERENCES `administrateur`(`idAdministrateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `groupe` (
	`idGroupe` int unsigned NOT NULL auto_increment,
	`competition` int unsigned NOT NULL,
	`nbEquipe` int unsigned NOT NULL,
	`allerRetour` SET('False','True') NOT NULL DEFAULT 'False',
	`suivant` int unsigned DEFAULT NULL,
	`precedant` int unsigned DEFAULT NULL,
	PRIMARY KEY (`idGroupe`),
	FOREIGN KEY (`competition`) REFERENCES `competition`(`idCompetition`),
	FOREIGN KEY (`suivant`) REFERENCES `groupe`(`idGroupe`),
	FOREIGN KEY (`precedant`) REFERENCES `groupe`(`idGroupe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `match` (
	`idMatch` int unsigned NOT NULL auto_increment,
	`groupe` int unsigned NOT NULL,
	`equipeA` int unsigned NOT NULL,
	`equipeB` int unsigned NOT NULL,
	`arbitre` int unsigned NOT NULL,
	`scoreA` int(1) NULL,
	`scoreB` int(1) NULL,
	`date` date NULL,
	`heure` time NULL,
	`lieu` varchar(32) NULL,
	PRIMARY KEY (`idMatch`),
	FOREIGN KEY (`groupe`) REFERENCES `groupe`(`idGroupe`),
	FOREIGN KEY (`equipeA`) REFERENCES `equipe`(`idEquipe`),
	FOREIGN KEY (`equipeB`) REFERENCES `equipe`(`idEquipe`),
	FOREIGN KEY (`arbitre`) REFERENCES `arbitre`(`idArbitre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `position` (
	`idPosition` int unsigned NOT NULL auto_increment,
	`position` varchar(16),
	PRIMARY KEY (`idPosition`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `joueur` (
	`idJoueur` int unsigned NOT NULL auto_increment,
	`club` int unsigned NOT NULL,
	`selection` int unsigned NULL,
	`position` int unsigned NOT NULL,
	PRIMARY KEY (`idJoueur`),
	FOREIGN KEY (`club`) REFERENCES `equipe`(`idEquipe`),
	FOREIGN KEY (`selection`) REFERENCES `equipe`(`idEquipe`),
	FOREIGN KEY (`position`) REFERENCES `position`(`idPosition`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `parieur` (
	`idParieur` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`idParieur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `pariMatch` (
	`parieur` int unsigned NOT NULL,
	`match` int unsigned NOT NULL,
	-- `idPari` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`parieur`,`match`),
	FOREIGN KEY (`parieur`) REFERENCES `parieur`(`idParieur`),
	FOREIGN KEY (`match`) REFERENCES `match`(`idMatch`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `pariCompetition` (
	`parieur` int unsigned NOT NULL,
	`competition` int unsigned NOT NULL,
	-- `idPari` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`parieur`,`competition`),
	FOREIGN KEY (`parieur`) REFERENCES `parieur`(`idParieur`),
	FOREIGN KEY (`competition`) REFERENCES `competition`(`idCompetition`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `nationalite` (
	`idNationalite` int unsigned NOT NULL auto_increment,
	`nationalite` varchar(32),
	PRIMARY KEY (`idNationalite`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `sportif` (
	`idSportif` int unsigned NOT NULL auto_increment,
	`idArbitre` int unsigned NULL,
	`idEntraineur` int unsigned NULL,
	`idJoueur` int unsigned NULL,
	`dateNaissance` date NOT NULL,
	`taille` varchar(4) NOT NULL,
	`nationalite` int unsigned NOT NULL,
	PRIMARY KEY (`idSportif`),
	FOREIGN KEY (`idArbitre`) REFERENCES `arbitre`(`idArbitre`),
	FOREIGN KEY (`idEntraineur`) REFERENCES `entraineur`(`idEntraineur`),
	FOREIGN KEY (`idJoueur`) REFERENCES `joueur`(`idJoueur`),
	FOREIGN KEY (`nationalite`) REFERENCES `nationalite`(`idNationalite`)	
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `utilisateurs` (
	`idUtilisateur` int unsigned NOT NULL auto_increment,
	`idAdministrateur` int unsigned NULL,
	`idParieur` int unsigned NULL,
	`login` varchar(32) NOT NULL,
	`password` varchar(40) NOT NULL,
	`email` varchar(64) NOT NULL,
	PRIMARY KEY (`idUtilisateur`),
	FOREIGN KEY (`idAdministrateur`) REFERENCES `administrateur`(`idAdministrateur`),
	FOREIGN KEY (`idParieur`) REFERENCES `parieur`(`idParieur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `personne` (
	`idPersonne` int unsigned NOT NULL auto_increment,
	`idSportif` int unsigned NULL,
	`idUtilisateur` int unsigned NULL,
	`nom` varchar(32) NOT NULL,
	`prenom` varchar(32) NOT NULL,
	PRIMARY KEY (`idPersonne`),
	FOREIGN KEY (`idSportif`) REFERENCES `sportif`(`idSportif`),
	FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateurs`(`idUtilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;