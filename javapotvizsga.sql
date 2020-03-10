-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2020. Már 10. 14:23
-- Kiszolgáló verziója: 10.1.28-MariaDB
-- PHP verzió: 5.6.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `javapotvizsga`
--
CREATE DATABASE IF NOT EXISTS `javapotvizsga` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `javapotvizsga`;

DELIMITER $$
--
-- Eljárások
--
DROP PROCEDURE IF EXISTS `addNewHegy`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewHegy` (IN `szelessegi_koordinataIN` INT(8), IN `hosszusagi_koordinataIN` INT(8), IN `magassagIN` INT(8), IN `megmaszas_nehezsegIN` INT(8))  NO SQL
INSERT INTO `hegyek`  (`hegyek`.`szelessegi_koordinata`, `hegyek`.`hosszusagi_koordinata`, `hegyek`.`magassag`, `hegyek`.`megmaszas_nehezseg`)
VALUES (szelessegi_koordinataIN,hosszusagi_koordinataIN,magassagIN,megmaszas_nehezsegIN)$$

DROP PROCEDURE IF EXISTS `getAllFelnottAbc`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllFelnottAbc` ()  NO SQL
SELECT * FROM `hegymaszok` WHERE `hegymaszok`.`kor`>= 18 GROUP BY (nev)$$

DROP PROCEDURE IF EXISTS `getAllHegyMagassagCsokken`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllHegyMagassagCsokken` ()  NO SQL
SELECT * FROM `hegyek` GROUP BY (magassag) DESC$$

DROP PROCEDURE IF EXISTS `selectByIdKepesseg`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectByIdKepesseg` (IN `idIN` INT(8))  NO SQL
SELECT * FROM `hegyek` WHERE `hegymaszok`.`kepessegi_szint`>= `hegyek`.`megmaszas_nehezseg`$$

DROP PROCEDURE IF EXISTS `updateKepessegById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateKepessegById` (IN `idIN` INT(8))  NO SQL
UPDATE hegymaszok SET kepessegi_szint = kepessegi_szint +1 WHERE `hegymaszok`.`id`= idIN$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `hegyek`
--

DROP TABLE IF EXISTS `hegyek`;
CREATE TABLE `hegyek` (
  `id` int(8) NOT NULL,
  `szelessegi_koordinata` int(8) NOT NULL,
  `hosszusagi_koordinata` int(8) NOT NULL,
  `magassag` int(8) NOT NULL,
  `megmaszas_nehezseg` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `hegyek`
--

INSERT INTO `hegyek` (`id`, `szelessegi_koordinata`, `hosszusagi_koordinata`, `magassag`, `megmaszas_nehezseg`) VALUES
(1, 4564, 3245, 3000, 10),
(2, 5656, 3333, 2300, 7),
(3, 3434, 7776, 1300, 5),
(4, 45224, 56456, 4000, 10),
(5, 3435, 4532, 2345, 3),
(6, 45345, 453545, 3403, 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `hegymaszok`
--

DROP TABLE IF EXISTS `hegymaszok`;
CREATE TABLE `hegymaszok` (
  `id` int(8) NOT NULL,
  `nev` varchar(50) NOT NULL,
  `kor` int(3) NOT NULL,
  `orszag` varchar(50) NOT NULL,
  `kepessegi_szint` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `hegymaszok`
--

INSERT INTO `hegymaszok` (`id`, `nev`, `kor`, `orszag`, `kepessegi_szint`) VALUES
(1, 'Tamás', 43, 'Magyarország', 1),
(2, 'Sára', 30, 'Skócia', 1),
(3, 'Péter', 10, 'Kína', 9),
(4, 'Kata', 23, 'Magyarország', 5),
(5, 'József', 35, 'Szlovákia', 6),
(6, 'Aladin', 12, 'India', 5),
(7, 'Zsolt', 18, 'Ausztria', 7);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `hegyek`
--
ALTER TABLE `hegyek`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `hegymaszok`
--
ALTER TABLE `hegymaszok`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `hegyek`
--
ALTER TABLE `hegyek`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `hegymaszok`
--
ALTER TABLE `hegymaszok`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
