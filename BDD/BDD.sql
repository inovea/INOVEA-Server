-- MySQL Script generated by MySQL Workbench
-- 07/25/15 17:40:50
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Courier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Courier` (
  `idCourier` INT NOT NULL AUTO_INCREMENT,
  `mail` VARCHAR(45) NOT NULL,
  `encrypted_password` VARCHAR(80) NOT NULL,
  `name` VARCHAR(45) NULL,
  `firstname` VARCHAR(45) NULL,
  `scheduler` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idCourier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Errand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Errand` (
  `idErrand` INT NOT NULL AUTO_INCREMENT,
  `state` INT NOT NULL DEFAULT 0,
  `dateDebut` DATETIME NOT NULL DEFAULT 0001-01-01 01:00:00,
  `dateFin` DATETIME NOT NULL DEFAULT 0001-01-01 01:00:00,
  `duree` DOUBLE NULL,
  `distance` DOUBLE NULL,
  `Courier_idCourier` INT NULL,
  PRIMARY KEY (`idErrand`, `Courier_idCourier`),
  INDEX `fk_Errand_Courier_idx` (`Courier_idCourier` ASC),
  CONSTRAINT `fk_Errand_Courier`
    FOREIGN KEY (`Courier_idCourier`)
    REFERENCES `mydb`.`Courier` (`idCourier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CentreExploitation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CentreExploitation` (
  `idCe` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `color` VARCHAR(45) NULL,
  `url_zone` VARCHAR(2000) NULL,
  PRIMARY KEY (`idCe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Container`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Container` (
  `idContainer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `lat` DOUBLE NULL,
  `lng` DOUBLE NULL,
  `state` INT NOT NULL DEFAULT 0,
  `type` INT NOT NULL DEFAULT 0,
  `lastCollect` DATETIME NOT NULL DEFAULT 0001-01-01 01:00:00,
  `address` VARCHAR(140) NULL,
  `Errand_idErrand` INT NULL,
  `CentreExploitation_idCe` INT NOT NULL,
  PRIMARY KEY (`idContainer`, `lastCollect`, `Errand_idErrand`, `CentreExploitation_idCe`),
  INDEX `fk_Container_Errand1_idx` (`Errand_idErrand` ASC),
  INDEX `fk_Container_CentreExploitation1_idx` (`CentreExploitation_idCe` ASC),
  CONSTRAINT `fk_Container_Errand1`
    FOREIGN KEY (`Errand_idErrand`)
    REFERENCES `mydb`.`Errand` (`idErrand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Container_CentreExploitation1`
    FOREIGN KEY (`CentreExploitation_idCe`)
    REFERENCES `mydb`.`CentreExploitation` (`idCe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Alert`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Alert` (
  `idAlert` INT NOT NULL AUTO_INCREMENT,
  `state` INT NOT NULL DEFAULT 0,
  `description` VARCHAR(140) NULL,
  `date` DATETIME NOT NULL,
  `author` VARCHAR(45) NULL,
  `Container_idContainer` INT NOT NULL,
  PRIMARY KEY (`idAlert`, `Container_idContainer`),
  INDEX `fk_Alert_Container1_idx` (`Container_idContainer` ASC),
  CONSTRAINT `fk_Alert_Container1`
    FOREIGN KEY (`Container_idContainer`)
    REFERENCES `mydb`.`Container` (`idContainer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
