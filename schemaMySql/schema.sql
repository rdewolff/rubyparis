-- phpMyAdmin SQL Dump
-- version 2.10.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Dec 18, 2007 at 10:37 AM
-- Server version: 5.0.41
-- PHP Version: 5.2.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `rubyparis`
-- 
CREATE DATABASE `rubyparis` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `rubyparis`;

-- --------------------------------------------------------

-- 
-- Table structure for table `users`
-- 

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL auto_increment,
  `nom` varchar(64) NOT NULL,
  `prenom` varchar(64) NOT NULL,
  `login` varchar(32) NOT NULL,
  `pw` varchar(32) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY  (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `users`
-- 

INSERT INTO `users` VALUES (1, 'Romamichelle', 'Chamelito', 'g', 'g', 'g@g.c');
