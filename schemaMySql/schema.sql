-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `rubyparis`
-- 

-- ICI!!!!!!! Eventuellement créer tables club et selection nationale

DROP DATABASE IF EXISTS `rubyparis`;
CREATE DATABASE `rubyparis` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `rubyparis`;


CREATE TABLE `Entraineur` (
	`idEntraineur` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`idEntraineur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Equipe` (
	`idEquipe` int unsigned NOT NULL auto_increment,
	`entraineur` int unsigned NOT NULL,
	`nom` varchar(32) NOT NULL,
	`provenanve` varchar(32) NOT NULL,
	`url` varchar(32) NOT NULL,
	`stade` varchar(32) NOT NULL,
	PRIMARY KEY (`idEquipe`),
	FOREIGN KEY (`entraineur`) REFERENCES `Entraineur`(`idEntraineur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Arbitre` (
	`idArbitre` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`idArbitre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Administrateur` (
	`idAdministrateur` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`idAdministrateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Competition` (
	`idCompetition` int unsigned NOT NULL auto_increment,
	`administrateur` int unsigned NOT NULL,
	`nom` varchar(32) NOT NULL,
	`description` varchar(128) NOT NULL,
	`dateDebut` date NOT NULL,
	`dateFin` date NOT NULL,
	PRIMARY KEY (`idCompetition`),
	FOREIGN KEY (`administrateur`) REFERENCES `Administrateur`(`idAdministrateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Groupe` (
	`idGroupe` int unsigned NOT NULL auto_increment,
	`competition` int unsigned NOT NULL,
	`nbEquipe` int unsigned NOT NULL,
	`allerRetour` SET('False','True') NOT NULL DEFAULT 'False',
	`suivant` int unsigned DEFAULT NULL,
	`precedant` int unsigned DEFAULT NULL,
	PRIMARY KEY (`idGroupe`),
	FOREIGN KEY (`competition`) REFERENCES `Competition`(`idCompetition`),
	FOREIGN KEY (`suivant`) REFERENCES `Groupe`(`idGroupe`),
	FOREIGN KEY (`precedant`) REFERENCES `Groupe`(`idGroupe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Match` (
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
	FOREIGN KEY (`groupe`) REFERENCES `Groupe`(`idGroupe`),
	FOREIGN KEY (`equipeA`) REFERENCES `Equipe`(`idEquipe`),
	FOREIGN KEY (`equipeB`) REFERENCES `Equipe`(`idEquipe`),
	FOREIGN KEY (`arbitre`) REFERENCES `Arbitre`(`idArbitre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Position` (
	`idPosition` int unsigned NOT NULL auto_increment,
	`position` varchar(16),
	PRIMARY KEY (`idPosition`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Joueur` (
	`idJoueur` int unsigned NOT NULL auto_increment,
	`club` int unsigned NOT NULL,
	`selection` int unsigned NULL,
	`position` int unsigned NOT NULL,
	PRIMARY KEY (`idJoueur`),
	FOREIGN KEY (`club`) REFERENCES `Equipe`(`idEquipe`),
	FOREIGN KEY (`selection`) REFERENCES `Equipe`(`idEquipe`),
	FOREIGN KEY (`position`) REFERENCES `Position`(`idPosition`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Parieur` (
	`idParieur` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`idParieur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `PariMatch` (
	`parieur` int unsigned NOT NULL,
	`match` int unsigned NOT NULL,
	-- `idPari` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`parieur`,`match`),
	FOREIGN KEY (`parieur`) REFERENCES `Parieur`(`idParieur`),
	FOREIGN KEY (`match`) REFERENCES `Match`(`idMatch`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `PariCompetition` (
	`parieur` int unsigned NOT NULL,
	`competition` int unsigned NOT NULL,
	-- `idPari` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`parieur`,`competition`),
	FOREIGN KEY (`parieur`) REFERENCES `Parieur`(`idParieur`),
	FOREIGN KEY (`competition`) REFERENCES `Competition`(`idCompetition`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Nationalite` (
	`idNationalite` int unsigned NOT NULL auto_increment,
	`nationalite` varchar(32),
	PRIMARY KEY (`idNationalite`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Sportif` (
	`idSportif` int unsigned NOT NULL auto_increment,
	`idArbitre` int unsigned NULL,
	`idEntraineur` int unsigned NULL,
	`idJoueur` int unsigned NULL,
	`dateNaissance` date NOT NULL,
	`taille` varchar(4) NOT NULL,
	`nationalite` int unsigned NOT NULL,
	PRIMARY KEY (`idSportif`),
	FOREIGN KEY (`idArbitre`) REFERENCES `Arbitre`(`idArbitre`),
	FOREIGN KEY (`idEntraineur`) REFERENCES `Entraineur`(`idEntraineur`),
	FOREIGN KEY (`idJoueur`) REFERENCES `Joueur`(`idJoueur`),
	FOREIGN KEY (`nationalite`) REFERENCES `Nationalite`(`idNationalite`)	
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Utilisateur` (
	`idUtilisateur` int unsigned NOT NULL auto_increment,
	`idAdministrateur` int unsigned NULL,
	`idParieur` int unsigned NULL,
	`login` varchar(32) NOT NULL,
	`password` varchar(40) NOT NULL,
	`email` varchar(64) NOT NULL,
	PRIMARY KEY (`idUtilisateur`),
	FOREIGN KEY (`idAdministrateur`) REFERENCES `Administrateur`(`idAdministrateur`),
	FOREIGN KEY (`idParieur`) REFERENCES `Parieur`(`idParieur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Personne` (
	`idPersonne` int unsigned NOT NULL auto_increment,
	`idSportif` int unsigned NULL,
	`idUtilisateur` int unsigned NULL,
	`nom` varchar(32) NOT NULL,
	`prenom` varchar(32) NOT NULL,
	PRIMARY KEY (`idPersonne`),
	FOREIGN KEY (`idSportif`) REFERENCES `Sportif`(`idSportif`),
	FOREIGN KEY (`idUtilisateur`) REFERENCES `Utilisateur`(`idUtilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;