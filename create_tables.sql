-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema AB5123_3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema AB5123_3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AB5123_3` DEFAULT CHARACTER SET utf8 ;
USE `AB5123_3` ;

-- -----------------------------------------------------
-- Table `AB5123_3`.`artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AB5123_3`.`artists` (
  `artistid` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `contract` VARCHAR(45) NULL,
  PRIMARY KEY (`artistid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AB5123_3`.`bands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AB5123_3`.`bands` (
  `bandid` INT NOT NULL AUTO_INCREMENT,
  `bandname` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`bandid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AB5123_3`.`releases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AB5123_3`.`releases` (
  `releaseid` INT NOT NULL AUTO_INCREMENT,
  `releasename` VARCHAR(100) NOT NULL,
  `media` VARCHAR(45) NULL,
  `sales` INT NULL,
  `releasedate` DATE NULL,
  PRIMARY KEY (`releaseid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AB5123_3`.`members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AB5123_3`.`members` (
  `bands_bandid` INT NOT NULL,
  `artists_artistid` INT NOT NULL,
  PRIMARY KEY (`bands_bandid`, `artists_artistid`),
  INDEX `fk_bands_has_artists_artists1_idx` (`artists_artistid` ASC),
  INDEX `fk_bands_has_artists_bands_idx` (`bands_bandid` ASC),
  CONSTRAINT `fk_bands_has_artists_bands`
    FOREIGN KEY (`bands_bandid`)
    REFERENCES `AB5123_3`.`bands` (`bandid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bands_has_artists_artists1`
    FOREIGN KEY (`artists_artistid`)
    REFERENCES `AB5123_3`.`artists` (`artistid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AB5123_3`.`artistreleases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AB5123_3`.`artistreleases` (
  `artists_artistid` INT NOT NULL,
  `releases_releaseid` INT NOT NULL,
  PRIMARY KEY (`artists_artistid`, `releases_releaseid`),
  INDEX `fk_artists_has_releases_releases1_idx` (`releases_releaseid` ASC),
  INDEX `fk_artists_has_releases_artists1_idx` (`artists_artistid` ASC),
  CONSTRAINT `fk_artists_has_releases_artists1`
    FOREIGN KEY (`artists_artistid`)
    REFERENCES `AB5123_3`.`artists` (`artistid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artists_has_releases_releases1`
    FOREIGN KEY (`releases_releaseid`)
    REFERENCES `AB5123_3`.`releases` (`releaseid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AB5123_3`.`bandreleases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AB5123_3`.`bandreleases` (
  `bands_bandid` INT NOT NULL,
  `releases_releaseid` INT NOT NULL,
  PRIMARY KEY (`bands_bandid`, `releases_releaseid`),
  INDEX `fk_bands_has_releases_releases1_idx` (`releases_releaseid` ASC),
  INDEX `fk_bands_has_releases_bands1_idx` (`bands_bandid` ASC),
  CONSTRAINT `fk_bands_has_releases_bands1`
    FOREIGN KEY (`bands_bandid`)
    REFERENCES `AB5123_3`.`bands` (`bandid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bands_has_releases_releases1`
    FOREIGN KEY (`releases_releaseid`)
    REFERENCES `AB5123_3`.`releases` (`releaseid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
