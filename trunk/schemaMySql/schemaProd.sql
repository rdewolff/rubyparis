-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `rubyparis`
-- 

-- ICI!!!!!!! Eventuellement créer tables club et selection nationale

DROP DATABASE IF EXISTS `rubyparis_production`;
CREATE DATABASE `rubyparis_production` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `rubyparis_production`;


CREATE TABLE `personnes` (
	`idPersonne` int unsigned NOT NULL auto_increment,
	`nom` varchar(32) NOT NULL,
	`prenom` varchar(32) NOT NULL,
	PRIMARY KEY (`idPersonne`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `nationalites` (
	`idNationalite` int unsigned NOT NULL auto_increment,
	`nationalite` varchar(32),
	PRIMARY KEY (`idNationalite`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `sportifs` (
	`idSportif` int unsigned NOT NULL auto_increment,
	`idPersonne` int unsigned NULL,
	`dateNaissance` date NOT NULL,
	`taille` varchar(4) NOT NULL,
	`nationalite` int unsigned NOT NULL,
	PRIMARY KEY (`idSportif`),
	FOREIGN KEY (`idPersonne`) REFERENCES `personnes`(`idPersonne`),
	FOREIGN KEY (`nationalite`) REFERENCES `nationalites`(`idNationalite`)	
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `utilisateurs` (
	`idUtilisateur` int unsigned NOT NULL auto_increment,
	`idPersonne` int unsigned NOT NULL,
	`login` varchar(32) NOT NULL,
	`password` varchar(40) NOT NULL,
	`email` varchar(64) NOT NULL,
	PRIMARY KEY (`idUtilisateur`),
	FOREIGN KEY (`idPersonne`) REFERENCES `personnes`(`idPersonne`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



CREATE TABLE `entraineurs` (
	`idEntraineur` int unsigned NOT NULL auto_increment,
	`idSportif` int unsigned NOT NULL,
	PRIMARY KEY (`idEntraineur`),
	FOREIGN KEY (`idSportif`) REFERENCES `sportifs`(`idSportif`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `equipes` (
	`idEquipe` int unsigned NOT NULL auto_increment,
	`entraineur` int unsigned NOT NULL,
	`nom` varchar(32) NOT NULL,
	`provenanve` varchar(32) NOT NULL,
	`url` varchar(32) NOT NULL,
	`stade` varchar(32) NOT NULL,
	PRIMARY KEY (`idEquipe`),
	FOREIGN KEY (`entraineur`) REFERENCES `entraineurs`(`idEntraineur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `arbitres` (
	`idArbitre` int unsigned NOT NULL auto_increment,
	`idSportif` int unsigned NOT NULL,
	PRIMARY KEY (`idArbitre`),
	FOREIGN KEY (`idSportif`) REFERENCES `sportifs`(`idSportif`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `administrateurs` (
	`idAdministrateur` int unsigned NOT NULL auto_increment,
	`idUtilisateur` int unsigned NOT NULL,
	PRIMARY KEY (`idAdministrateur`),
	FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateurs`(`idUtilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `competitions` (
	`idCompetition` int unsigned NOT NULL auto_increment,
	`administrateur` int unsigned NOT NULL,
	`nom` varchar(32) NOT NULL,
	`description` varchar(128) NOT NULL,
	`dateDebut` date NOT NULL,
	`dateFin` date NOT NULL,
	PRIMARY KEY (`idCompetition`),
	FOREIGN KEY (`administrateur`) REFERENCES `administrateurs`(`idAdministrateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `groupes` (
	`idGroupe` int unsigned NOT NULL auto_increment,
	`competition` int unsigned NOT NULL,
	`nbEquipe` int unsigned NOT NULL,
	`allerRetour` SET('False','True') NOT NULL DEFAULT 'False',
	`suivant` int unsigned DEFAULT NULL,
	`precedant` int unsigned DEFAULT NULL,
	PRIMARY KEY (`idGroupe`),
	FOREIGN KEY (`competition`) REFERENCES `competitions`(`idCompetition`),
	FOREIGN KEY (`suivant`) REFERENCES `groupes`(`idGroupe`),
	FOREIGN KEY (`precedant`) REFERENCES `groupes`(`idGroupe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `matchs` (
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
	FOREIGN KEY (`groupe`) REFERENCES `groupes`(`idGroupe`),
	FOREIGN KEY (`equipeA`) REFERENCES `equipes`(`idEquipe`),
	FOREIGN KEY (`equipeB`) REFERENCES `equipes`(`idEquipe`),
	FOREIGN KEY (`arbitre`) REFERENCES `arbitres`(`idArbitre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `positions` (
	`idPosition` int unsigned NOT NULL auto_increment,
	`position` varchar(16),
	PRIMARY KEY (`idPosition`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `joueurs` (
	`idJoueur` int unsigned NOT NULL auto_increment,
	`idSportif` int unsigned NOT NULL,
	`club` int unsigned NOT NULL,
	`selection` int unsigned NULL,
	`position` int unsigned NOT NULL,
	PRIMARY KEY (`idJoueur`),
	FOREIGN KEY (`idSportif`) REFERENCES `sportifs`(`idSportif`),
	FOREIGN KEY (`club`) REFERENCES `equipes`(`idEquipe`),
	FOREIGN KEY (`selection`) REFERENCES `equipes`(`idEquipe`),
	FOREIGN KEY (`position`) REFERENCES `positions`(`idPosition`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `parieurs` (
	`idParieur` int unsigned NOT NULL auto_increment,
	`idUtilisateur` int unsigned NOT NULL,
	PRIMARY KEY (`idParieur`),
	FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateurs`(`idUtilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `pariMatchs` (
	`parieur` int unsigned NOT NULL,
	`match` int unsigned NOT NULL,
	-- `idPari` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`parieur`,`match`),
	FOREIGN KEY (`parieur`) REFERENCES `parieurs`(`idParieur`),
	FOREIGN KEY (`match`) REFERENCES `matchs`(`idMatch`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `pariCompetitions` (
	`parieur` int unsigned NOT NULL,
	`competition` int unsigned NOT NULL,
	-- `idPari` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`parieur`,`competition`),
	FOREIGN KEY (`parieur`) REFERENCES `parieurs`(`idParieur`),
	FOREIGN KEY (`competition`) REFERENCES `competitions`(`idCompetition`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;








