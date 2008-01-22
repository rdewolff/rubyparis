-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `rubyparis`
-- 

-- ICI!!!!!!! Eventuellement créer tables club et selection nationale

DROP DATABASE IF EXISTS `rubyparis_development`;
CREATE DATABASE `rubyparis_development` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `rubyparis_development`;


CREATE TABLE `personnes` (
	`id` int unsigned NOT NULL auto_increment,
	`nom` varchar(32) NOT NULL,
	`prenom` varchar(32) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `nationalites` (
	`id` int unsigned NOT NULL auto_increment,
	`nationalite` varchar(32),
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `sportifs` (
	`id` int unsigned NOT NULL auto_increment,
	`personne_id` int unsigned NULL,
	`dateNaissance` date NOT NULL,
	`taille` varchar(4) NOT NULL,
	`nationalite_id` int unsigned NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`personne_id`) REFERENCES `personnes`(`id`),
	FOREIGN KEY (`nationalite_id`) REFERENCES `nationalites`(`id`)	
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `utilisateurs` (
	`id` int unsigned NOT NULL auto_increment,
	-- `personne_id` int unsigned NOT NULL,
	`login` varchar(32) NOT NULL,
	`password` varchar(40) NOT NULL,
	`email` varchar(64) NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`id`) REFERENCES `personnes`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



CREATE TABLE `entraineurs` (
	`id` int unsigned NOT NULL auto_increment,
	`sportif_id` int unsigned NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`sportif_id`) REFERENCES `sportifs`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `equipes` (
	`id` int unsigned NOT NULL auto_increment,
	`entraineur_id` int unsigned NOT NULL,
	`nom` varchar(32) NOT NULL,
	`provenance` varchar(32) NOT NULL,
	`url` varchar(32) NOT NULL,
	`stade` varchar(32) NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`entraineur_id`) REFERENCES `entraineurs`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `arbitres` (
	`id` int unsigned NOT NULL auto_increment,
	`sportif_id` int unsigned NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`sportif_id`) REFERENCES `sportifs`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `administrateurs` (
	`id` int unsigned NOT NULL auto_increment,
	`utilisateur_id` int unsigned NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `competitions` (
	`id` int unsigned NOT NULL auto_increment,
	`administrateur_id` int unsigned NOT NULL,
	`nom` varchar(32) NOT NULL,
	`description` varchar(128) NOT NULL,
	`dateDebut` date NOT NULL,
	`dateFin` date NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`administrateur_id`) REFERENCES `administrateurs`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `groupes` (
	`id` int unsigned NOT NULL auto_increment,
	`competition_id` int unsigned NOT NULL,
	`nbEquipe` int unsigned NOT NULL,
	`allerRetour` SET('False','True') NOT NULL DEFAULT 'False',
	`suivant` int unsigned DEFAULT NULL,
	`precedant` int unsigned DEFAULT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`competition_id`) REFERENCES `competitions`(`id`),
	FOREIGN KEY (`suivant`) REFERENCES `groupes`(`id`),
	FOREIGN KEY (`precedant`) REFERENCES `groupes`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `matchs` (
	`id` int unsigned NOT NULL auto_increment,
	`groupe_id` int unsigned NOT NULL,
	`equipeA` int unsigned NOT NULL,
	`equipeB` int unsigned NOT NULL,
	`arbitre_id` int unsigned NOT NULL,
	`scoreA` int(1) NULL,
	`scoreB` int(1) NULL,
	`date` date NULL,
	`heure` time NULL,
	`lieu` varchar(32) NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`groupe_id`) REFERENCES `groupes`(`id`),
	FOREIGN KEY (`equipeA`) REFERENCES `equipes`(`id`),
	FOREIGN KEY (`equipeB`) REFERENCES `equipes`(`id`),
	FOREIGN KEY (`arbitre_id`) REFERENCES `arbitres`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `positions` (
	`id` int unsigned NOT NULL auto_increment,
	`position` varchar(16),
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `joueurs` (
	`id` int unsigned NOT NULL auto_increment,
	`sportif_id` int unsigned NOT NULL,
	`club` int unsigned NOT NULL,
	`selection` int unsigned NULL,
	`position_id` int unsigned NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`sportif_id`) REFERENCES `sportifs`(`id`),
	FOREIGN KEY (`club`) REFERENCES `equipes`(`id`),
	FOREIGN KEY (`selection`) REFERENCES `equipes`(`id`),
	FOREIGN KEY (`position_id`) REFERENCES `positions`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `parieurs` (
	-- `id` int unsigned NOT NULL auto_increment,
	`id` int unsigned NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`id`) REFERENCES `utilisateurs`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `pariMatchs` (
	`parieur_id` int unsigned NOT NULL,
	`match_id` int unsigned NOT NULL,
	-- `idPari` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`parieur_id`,`match_id`),
	FOREIGN KEY (`parieur_id`) REFERENCES `parieurs`(`id`),
	FOREIGN KEY (`match_id`) REFERENCES `matchs`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `pariCompetitions` (
	`parieur_id` int unsigned NOT NULL,
	`competition_id` int unsigned NOT NULL,
	-- `idPari` int unsigned NOT NULL auto_increment,
	PRIMARY KEY (`parieur_id`,`competition_id`),
	FOREIGN KEY (`parieur_id`) REFERENCES `parieurs`(`id`),
	FOREIGN KEY (`competition_id`) REFERENCES `competitions`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;