-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Merkadit_DB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Merkadit_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Merkadit_DB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `Merkadit_DB` ;

-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Countries` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(50) NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`States`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`States` (
  `state_id` INT NOT NULL AUTO_INCREMENT,
  `state_name` VARCHAR(50) NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`state_id`),
  INDEX `fk_States_Countries1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_States_Countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `Merkadit_DB`.`Countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Cities` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(50) NULL,
  `state_id` INT NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_cities_States1_idx` (`state_id` ASC) VISIBLE,
  CONSTRAINT `fk_cities_States1`
    FOREIGN KEY (`state_id`)
    REFERENCES `Merkadit_DB`.`States` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Addresses` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `address1` VARCHAR(60) NULL,
  `address2` VARCHAR(60) NULL,
  `zipcode` VARCHAR(6) NULL,
  `geolocation` POINT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_Addresses_cities1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_Addresses_cities1`
    FOREIGN KEY (`city_id`)
    REFERENCES `Merkadit_DB`.`Cities` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Buildings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Buildings` (
  `building_id` INT NOT NULL AUTO_INCREMENT,
  `Addresses_address_id` INT NOT NULL,
  PRIMARY KEY (`building_id`),
  INDEX `fk_buildings_Addresses1_idx` (`Addresses_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_buildings_Addresses1`
    FOREIGN KEY (`Addresses_address_id`)
    REFERENCES `Merkadit_DB`.`Addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Markets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Markets` (
  `market_id` INT NOT NULL AUTO_INCREMENT,
  `building_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`market_id`),
  INDEX `fk_markets_buildings_idx` (`building_id` ASC) VISIBLE,
  INDEX `fk_Markets_Users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_markets_buildings`
    FOREIGN KEY (`building_id`)
    REFERENCES `Merkadit_DB`.`Buildings` (`building_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Markets_Users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `Merkadit_DB`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Space_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Space_status` (
  `space_status_id` INT NOT NULL,
  `space_status` VARCHAR(30) NULL,
  PRIMARY KEY (`space_status_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Spaces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Spaces` (
  `space_id` INT NOT NULL AUTO_INCREMENT,
  `market_id` INT NOT NULL,
  `space_status_id` INT NOT NULL,
  PRIMARY KEY (`space_id`),
  INDEX `fk_spaces_markets1_idx` (`market_id` ASC) VISIBLE,
  INDEX `fk_spaces_space_status1_idx` (`space_status_id` ASC) VISIBLE,
  CONSTRAINT `fk_spaces_markets1`
    FOREIGN KEY (`market_id`)
    REFERENCES `Merkadit_DB`.`Markets` (`market_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_spaces_space_status1`
    FOREIGN KEY (`space_status_id`)
    REFERENCES `Merkadit_DB`.`Space_status` (`space_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Users_has_Spaces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Users_has_Spaces` (
  `user_id` INT NOT NULL,
  `space_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `space_id`),
  INDEX `fk_Users_has_Spaces_Spaces1_idx` (`space_id` ASC) VISIBLE,
  INDEX `fk_Users_has_Spaces_Users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Spaces_Users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `Merkadit_DB`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Spaces_Spaces1`
    FOREIGN KEY (`space_id`)
    REFERENCES `Merkadit_DB`.`Spaces` (`space_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Roles` (
  `role_id` INT NOT NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Users_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Users_roles` (
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  INDEX `fk_Users_roles_Users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_Users_roles_Roles1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_Users_roles_Users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `Merkadit_DB`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_roles_Roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `Merkadit_DB`.`Roles` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Permissions` (
  `permission_id` INT NOT NULL AUTO_INCREMENT,
  `permission_code` VARCHAR(15) NULL,
  PRIMARY KEY (`permission_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Roles_has_Permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Roles_has_Permissions` (
  `role_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`role_id`, `permission_id`),
  INDEX `fk_Roles_has_Permissions_Permissions1_idx` (`permission_id` ASC) VISIBLE,
  INDEX `fk_Roles_has_Permissions_Roles1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_Roles_has_Permissions_Roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `Merkadit_DB`.`Roles` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Roles_has_Permissions_Permissions1`
    FOREIGN KEY (`permission_id`)
    REFERENCES `Merkadit_DB`.`Permissions` (`permission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Users_has_Permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Users_has_Permissions` (
  `user_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `permission_id`),
  INDEX `fk_Users_has_Permissions_Permissions1_idx` (`permission_id` ASC) VISIBLE,
  INDEX `fk_Users_has_Permissions_Users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Permissions_Users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `Merkadit_DB`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Permissions_Permissions1`
    FOREIGN KEY (`permission_id`)
    REFERENCES `Merkadit_DB`.`Permissions` (`permission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Business`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Business` (
  `business_id` INT NOT NULL COMMENT 'Negocio/entidad jurídica',
  `tax_id` VARCHAR(12) NULL,
  PRIMARY KEY (`business_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Users_has_Business`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Users_has_Business` (
  `user_id` INT NOT NULL,
  `business_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `business_id`),
  INDEX `fk_Users_has_Business_Business1_idx` (`business_id` ASC) VISIBLE,
  INDEX `fk_Users_has_Business_Users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Business_Users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `Merkadit_DB`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Business_Business1`
    FOREIGN KEY (`business_id`)
    REFERENCES `Merkadit_DB`.`Business` (`business_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Contracts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Contracts` (
  `contract_id` INT NOT NULL AUTO_INCREMENT,
  `space_id` INT NOT NULL,
  `business_id` INT NOT NULL,
  PRIMARY KEY (`contract_id`),
  INDEX `fk_Contracts_Spaces1_idx` (`space_id` ASC) VISIBLE,
  INDEX `fk_Contracts_Business1_idx` (`business_id` ASC) VISIBLE,
  CONSTRAINT `fk_Contracts_Spaces1`
    FOREIGN KEY (`space_id`)
    REFERENCES `Merkadit_DB`.`Spaces` (`space_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contracts_Business1`
    FOREIGN KEY (`business_id`)
    REFERENCES `Merkadit_DB`.`Business` (`business_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
