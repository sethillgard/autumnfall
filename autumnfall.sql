-- phpMyAdmin SQL Dump
-- version 2.11.9.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 21-02-2009 a las 17:18:44
-- Versión del servidor: 5.0.67
-- Versión de PHP: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `autumnfall`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gamedata`
--

CREATE TABLE IF NOT EXISTS `gamedata` (
  `gamedata_id` int(11) NOT NULL auto_increment,
  `rel_user` int(11) NOT NULL,
  `rel_game` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY  (`gamedata_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=45 ;

--
-- Volcar la base de datos para la tabla `gamedata`
--

INSERT INTO `gamedata` (`gamedata_id`, `rel_user`, `rel_game`, `name`, `value`) VALUES
(41, 2, 1, 'joseClicked', 'true'),
(42, 2, 1, 'juanClicked', 'true'),
(43, 2, 1, '__GameObject1__Clicked', 'true'),
(44, 2, 1, 'pacoClicked', 'true');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `games`
--

CREATE TABLE IF NOT EXISTS `games` (
  `game_id` int(11) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL,
  `public_name` varchar(25) NOT NULL,
  `rel_author` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  `website` varchar(30) NOT NULL,
  PRIMARY KEY  (`game_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `games`
--

INSERT INTO `games` (`game_id`, `name`, `public_name`, `rel_author`, `description`, `website`) VALUES
(1, 'TestGame', 'TesteGame!', 2, 'Es el primer juego de prueba', 'www.autumnfall.com/testgame');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `scores`
--

CREATE TABLE IF NOT EXISTS `scores` (
  `score_id` int(11) NOT NULL auto_increment,
  `rel_game` int(11) NOT NULL,
  `mode` varchar(20) NOT NULL,
  `alias` varchar(20) NOT NULL,
  `score` int(11) NOT NULL,
  PRIMARY KEY  (`score_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=123 ;

--
-- Volcar la base de datos para la tabla `scores`
--

INSERT INTO `scores` (`score_id`, `rel_game`, `mode`, `alias`, `score`) VALUES
(15, 1, '', 'seth', 7),
(14, 1, '', 'seth', 5),
(13, 1, '', 'seth', 1),
(12, 1, '', 'seth', 9),
(11, 1, '', 'seth', 5),
(16, 1, '', 'seth', 1),
(17, 1, '', 'seth', 5),
(18, 1, '', 'seth', 5),
(19, 1, '', 'seth', 5),
(20, 1, '', 'seth', 5),
(21, 1, '', 'seth', 1),
(22, 1, '', 'seth', 5),
(23, 1, 'Hard', 'seth', 1),
(24, 1, 'Hard', 'seth', 5),
(25, 1, 'Hard', 'seth', 5),
(26, 1, 'Hard', 'seth', 5),
(27, 1, 'Hard', 'seth', 1),
(28, 1, 'Hard', 'seth', 1),
(29, 1, 'Hard', 'seth', 1),
(30, 1, 'Hard', 'seth', 1),
(31, 1, 'Hard', 'seth', 1),
(32, 1, 'Hard', 'seth', 1),
(33, 1, 'Hard', 'seth', 5),
(34, 1, 'Hard', 'seth', 5),
(35, 1, 'Hard', 'seth', 5),
(36, 1, 'Hard', 'seth', 5),
(37, 1, 'Hard', 'seth', 1),
(38, 1, 'Hard', 'seth', 5),
(39, 1, 'Hard', 'seth', 5),
(40, 1, 'Hard', 'seth', 5),
(41, 1, 'Hard', 'seth', 1),
(42, 1, 'Hard', 'seth', 5),
(43, 1, 'Hard', 'seth', 5),
(44, 1, 'Hard', 'seth', 1),
(45, 1, 'Hard', 'seth', 1),
(46, 1, 'Hard', 'seth', 1),
(47, 1, 'Hard', 'seth', 1),
(48, 1, 'Hard', 'seth', 1),
(49, 1, 'Hard', 'seth', 1),
(50, 1, 'Hard', 'seth', 1),
(51, 1, 'Hard', 'seth', 1),
(52, 1, 'Hard', 'seth', 1),
(53, 1, 'Hard', 'seth', 1),
(54, 1, 'Hard', 'seth', 1),
(55, 1, 'Hard', 'seth', 1),
(56, 1, 'Hard', 'seth', 1),
(57, 1, 'Hard', 'seth', 1),
(58, 1, 'Hard', 'seth', 1),
(59, 1, 'Hard', 'seth', 1),
(60, 1, 'Hard', 'seth', 1),
(61, 1, 'Hard', 'seth', 1),
(62, 1, 'Hard', 'seth', 1),
(63, 1, 'Hard', 'denominador0', 5),
(64, 1, 'Hard', 'denominador0', 5),
(65, 1, 'Hard', 'denominador0', 1),
(66, 1, 'Hard', 'denominador0', 1),
(67, 1, 'Hard', 'denominador0', 1),
(68, 1, 'Hard', 'seth', 5),
(69, 1, 'Hard', 'seth', 5),
(70, 1, 'Hard', 'seth', 1),
(71, 1, 'Hard', 'seth', 1),
(72, 1, 'Hard', 'seth', 5),
(73, 1, 'Hard', 'seth', 5),
(74, 1, 'Hard', 'seth', 5),
(75, 1, 'Hard', 'seth', 5),
(76, 1, 'Hard', 'seth', 5),
(77, 1, 'Hard', 'seth', 5),
(78, 1, 'Hard', 'seth', 5),
(79, 1, 'Hard', 'denominador0', 5),
(80, 1, 'Hard', 'denominador0', 5),
(81, 1, 'Hard', 'denominador0', 5),
(82, 1, 'Hard', 'denominador0', 5),
(83, 1, 'Hard', 'denominador0', 1),
(84, 1, 'Hard', 'denominador0', 1),
(85, 1, 'Hard', 'seth', 5),
(86, 1, 'Hard', 'seth', 5),
(87, 1, 'Hard', 'seth', 5),
(88, 1, 'Hard', 'seth', 5),
(89, 1, 'Hard', 'seth', 5),
(90, 1, 'Hard', 'seth', 5),
(91, 1, 'Hard', 'seth', 5),
(92, 1, 'Hard', 'seth', 1),
(93, 1, 'Hard', 'seth', 1),
(94, 1, 'Hard', 'seth', 5),
(95, 1, 'Hard', 'seth', 5),
(96, 1, 'Hard', 'seth', 5),
(97, 1, 'Hard', 'seth', 5),
(98, 1, 'Hard', 'seth', 5),
(99, 1, 'Hard', 'seth', 5),
(100, 1, 'Hard', 'seth', 5),
(101, 1, 'Hard', 'seth', 5),
(102, 1, 'Hard', 'seth', 5),
(103, 1, 'Hard', 'seth', 5),
(104, 1, 'Hard', 'seth', 5),
(105, 1, 'Hard', 'seth', 5),
(106, 1, 'Hard', 'seth', 1),
(107, 1, 'Hard', 'seth', 5),
(108, 1, 'Hard', 'seth', 1),
(109, 1, 'Hard', 'seth', 5),
(110, 1, 'Hard', 'seth', 1),
(111, 1, 'Hard', 'seth', 5),
(112, 1, 'Hard', 'seth', 5),
(113, 1, 'Hard', 'seth', 1),
(114, 1, 'Hard', 'seth', 1),
(115, 1, 'Hard', 'seth', 5),
(116, 1, 'Hard', 'seth', 5),
(117, 1, 'Hard', 'seth', 1),
(118, 1, 'Hard', 'seth', 1),
(119, 1, 'Test', 'Juan', 666),
(120, 1, 'Hard', 'seth', 5),
(121, 1, 'Hard', 'seth', 5),
(122, 1, 'Hard', 'Daniel', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL auto_increment,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `alias` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `avatar_url` varchar(100) NOT NULL,
  `url` varchar(100) default NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `birthday` date NOT NULL,
  `join_date` date NOT NULL,
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcar la base de datos para la tabla `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `alias`, `email`, `avatar_url`, `url`, `first_name`, `last_name`, `birthday`, `join_date`) VALUES
(1, 'denominador0', 'mision316', 'Mayrita', 'mayra@google.com', 'www.google.com', 'www.skadjkshda.com', 'Mayra', 'García', '2009-01-15', '2009-01-31'),
(2, 'seth', 'silence', 'Daniel', 'seth@google.com', 'www.lalala.com', 'www.shaññaññañañaña.com', 'Daniel', 'Rodríguez', '2009-07-24', '2009-01-23');
