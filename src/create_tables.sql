-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema levymoguli
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema levymoguli
-- Luodaan skeema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `levymoguli` DEFAULT CHARACTER SET utf8 ;
USE `levymoguli` ;

-- -----------------------------------------------------
-- Table `levymoguli`.`artists`
-- Luodaan artistitaulu
-- artistid on pääavain ja määrätään automaagisesti
-- firstname on annettava tekstimuotoisena, max 45 merkkiä (varmaan riittää myös esim. espanjalaisille henkilöille)
-- lastname samoilla säännöillä kuin firstname
-- contract on vapaa tekstikenttä, sopimustyyppi voidaan kirjata tähän. Jokus käyttöliittymä voisi tarjota vain määrätyt sopparit.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `levymoguli`.`artists` (
  `artistid` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `contract` VARCHAR(45) NULL,
  PRIMARY KEY (`artistid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `levymoguli`.`bands`
-- Luodaan taulu bändeille
-- bandid on pääavain ja kasvaa automaattisesti
-- bandname on pakollinen tekstikenttä bändin nimelle
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `levymoguli`.`bands` (
  `bandid` INT NOT NULL AUTO_INCREMENT,
  `bandname` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`bandid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `levymoguli`.`releases`
-- Luodaan taulu julkaisuille
-- releaseid on pääavain ja kasvaa automaagisesti
-- releasename on pakollinen tekstikenttä julkaisun nimelle
-- media on vapaa tekstikenttä julkaisun mediatyypille (esim. CD tai digital jne.)
-- sales on kokonaislukukenttä myynnille (ei ole määritetty onko kyse kappaleista vai valuutasta), myyntihän on aluksi vielä 0 eli ei pakoteta syöttöä
-- releasedate on päivämääräkenttä julkaisupäivämääräksi
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `levymoguli`.`releases` (
  `releaseid` INT NOT NULL AUTO_INCREMENT,
  `releasename` VARCHAR(100) NOT NULL,
  `media` VARCHAR(45) NULL,
  `sales` INT NULL,
  `releasedate` DATE NULL,
  PRIMARY KEY (`releaseid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `levymoguli`.`members`
-- Luodaan liitostaulu artistien ja bändien liittämiseksi.
-- Viittaillaan artistid ja bandid pääavaimiin
-- ON DELETE JA ON UPDATE vyörytys
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `levymoguli`.`members` (
  `bands_bandid` INT NOT NULL,
  `artists_artistid` INT NOT NULL,
  PRIMARY KEY (`bands_bandid`, `artists_artistid`),
  INDEX `fk_bands_has_artists_artists1_idx` (`artists_artistid` ASC),
  INDEX `fk_bands_has_artists_bands_idx` (`bands_bandid` ASC),
  CONSTRAINT `fk_bands_has_artists_bands`
    FOREIGN KEY (`bands_bandid`)
    REFERENCES `levymoguli`.`bands` (`bandid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bands_has_artists_artists1`
    FOREIGN KEY (`artists_artistid`)
    REFERENCES `levymoguli`.`artists` (`artistid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `levymoguli`.`artistreleases`
-- Luodaan liitostaulu artistien ja julkaisuiden liittämiseksi
-- Viittaillaan artistid ja releaseid pääavaimiin
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `levymoguli`.`artistreleases` (
  `artists_artistid` INT NOT NULL,
  `releases_releaseid` INT NOT NULL,
  PRIMARY KEY (`artists_artistid`, `releases_releaseid`),
  INDEX `fk_artists_has_releases_releases1_idx` (`releases_releaseid` ASC),
  INDEX `fk_artists_has_releases_artists1_idx` (`artists_artistid` ASC),
  CONSTRAINT `fk_artists_has_releases_artists1`
    FOREIGN KEY (`artists_artistid`)
    REFERENCES `levymoguli`.`artists` (`artistid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artists_has_releases_releases1`
    FOREIGN KEY (`releases_releaseid`)
    REFERENCES `levymoguli`.`releases` (`releaseid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `levymoguli`.`bandreleases`
-- Luodaan liitostaulu bändien ja julkaisuiden liittämiseksi
-- Viittaillaan bandid ja releaseid pääavaimiin
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `levymoguli`.`bandreleases` (
  `bands_bandid` INT NOT NULL,
  `releases_releaseid` INT NOT NULL,
  PRIMARY KEY (`bands_bandid`, `releases_releaseid`),
  INDEX `fk_bands_has_releases_releases1_idx` (`releases_releaseid` ASC),
  INDEX `fk_bands_has_releases_bands1_idx` (`bands_bandid` ASC),
  CONSTRAINT `fk_bands_has_releases_bands1`
    FOREIGN KEY (`bands_bandid`)
    REFERENCES `levymoguli`.`bands` (`bandid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bands_has_releases_releases1`
    FOREIGN KEY (`releases_releaseid`)
    REFERENCES `levymoguli`.`releases` (`releaseid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
