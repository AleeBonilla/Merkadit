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
  `countryId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`countryId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`States`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`States` (
  `stateId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `countryId` INT NOT NULL,
  PRIMARY KEY (`stateId`),
  INDEX `fk_States_Countries1_idx` (`countryId` ASC) VISIBLE,
  CONSTRAINT `fk_States_Countries1`
    FOREIGN KEY (`countryId`)
    REFERENCES `Merkadit_DB`.`Countries` (`countryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Cities` (
  `cityId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `stateId` INT NOT NULL,
  PRIMARY KEY (`cityId`),
  INDEX `fk_cities_States1_idx` (`stateId` ASC) VISIBLE,
  CONSTRAINT `fk_cities_States1`
    FOREIGN KEY (`stateId`)
    REFERENCES `Merkadit_DB`.`States` (`stateId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Addresses` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `address1` VARCHAR(60) NOT NULL,
  `address2` VARCHAR(60) NOT NULL,
  `zipcode` VARCHAR(6) NOT NULL,
  `geolocation` POINT NOT NULL,
  `status` ENUM("ACTIVE", "CHANGED", "ELIMINATED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `cityIid` INT NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_Addresses_cities1_idx` (`cityIid` ASC) VISIBLE,
  CONSTRAINT `fk_Addresses_cities1`
    FOREIGN KEY (`cityIid`)
    REFERENCES `Merkadit_DB`.`Cities` (`cityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Buildings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Buildings` (
  `buildingId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `buildingStatus` ENUM("ACTIVE", "UNDER_CONSTRUCTION", "UNDER_RENOVATION", "CLOSED") NOT NULL,
  `addressId` INT NOT NULL,
  PRIMARY KEY (`buildingId`),
  INDEX `fk_buildings_Addresses1_idx` (`addressId` ASC) VISIBLE,
  UNIQUE INDEX `addressId_UNIQUE` (`addressId` ASC) VISIBLE,
  CONSTRAINT `fk_buildings_Addresses1`
    FOREIGN KEY (`addressId`)
    REFERENCES `Merkadit_DB`.`Addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`BuildingArea`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`BuildingArea` (
  `buildingArea` INT NOT NULL AUTO_INCREMENT,
  `floorNumber` INT NOT NULL,
  `description` VARCHAR(255) NOT NULL COMMENT 'Para ubicar del siguiente modo: \"En el pasillo principal, frente a X tienda\", \"Desde la entrada principal, 50 metros a mano derecha\", etc.',
  `status` ENUM("ACTIVE", "UNDER_CONSTRUCTION", "UNDER_RENOVATION", "CLOSED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `buildingId` INT NOT NULL,
  PRIMARY KEY (`buildingArea`),
  INDEX `fk_InBuildingLocation_Buildings1_idx` (`buildingId` ASC) VISIBLE,
  CONSTRAINT `fk_InBuildingLocation_Buildings1`
    FOREIGN KEY (`buildingId`)
    REFERENCES `Merkadit_DB`.`Buildings` (`buildingId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`LegalEntityTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`LegalEntityTypes` (
  `EntityTypeId` INT NOT NULL,
  `legalEntityName` VARCHAR(30) NULL,
  PRIMARY KEY (`EntityTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Users` (
  `userId` INT NOT NULL AUTO_INCREMENT,
  `userNationalId` VARCHAR(20) NOT NULL,
  `userFirstname` VARCHAR(30) NOT NULL,
  `userLastname` VARCHAR(40) NOT NULL,
  `userPassword` VARBINARY(160) NOT NULL,
  `userStatus` ENUM("ACTIVE", "CHANGED", "INACTIVE", "DELETED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`userId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`BusinessRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`BusinessRoles` (
  `BussinessRoleId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NULL,
  PRIMARY KEY (`BussinessRoleId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Business`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Business` (
  `businessId` INT NOT NULL AUTO_INCREMENT COMMENT 'Negocio/entidad jurídica',
  `taxId` INT NOT NULL,
  `legalId` VARCHAR(45) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `legalName` VARCHAR(50) NOT NULL,
  `description` VARCHAR(255) NULL,
  `status` ENUM("ACTIVE", "INACTIVE", "SUSPENDED", "CLOSED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `bussinessRoleId` INT NOT NULL,
  `legalAddressId` INT NOT NULL,
  `legalEntityTypeId` INT NOT NULL,
  `changed_by` INT NULL,
  PRIMARY KEY (`businessId`),
  INDEX `fk_Business_Addresses1_idx` (`legalAddressId` ASC) VISIBLE,
  INDEX `fk_Business_entityType1_idx` (`legalEntityTypeId` ASC) VISIBLE,
  INDEX `fk_Business_Users1_idx` (`changed_by` ASC) VISIBLE,
  INDEX `fk_Business_BusinessRoles1_idx` (`bussinessRoleId` ASC) VISIBLE,
  CONSTRAINT `fk_Business_Addresses1`
    FOREIGN KEY (`legalAddressId`)
    REFERENCES `Merkadit_DB`.`Addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Business_entityType1`
    FOREIGN KEY (`legalEntityTypeId`)
    REFERENCES `Merkadit_DB`.`LegalEntityTypes` (`EntityTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Business_Users1`
    FOREIGN KEY (`changed_by`)
    REFERENCES `Merkadit_DB`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Business_BusinessRoles1`
    FOREIGN KEY (`bussinessRoleId`)
    REFERENCES `Merkadit_DB`.`BusinessRoles` (`BussinessRoleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Markets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Markets` (
  `marketId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `status` ENUM("ACTIVE", "UNDER_CONSTRUCTION", "INACTIVE") NOT NULL DEFAULT 'ACTIVE',
  `spaceCount` INT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `businessId` INT NOT NULL,
  `buildingArea` INT NOT NULL,
  PRIMARY KEY (`marketId`),
  INDEX `fk_Markets_inBuildingLocation1_idx` (`buildingArea` ASC) VISIBLE,
  UNIQUE INDEX `inBuildingLocationId_UNIQUE` (`buildingArea` ASC) VISIBLE,
  INDEX `fk_Markets_Business1_idx` (`businessId` ASC) VISIBLE,
  CONSTRAINT `fk_Markets_inBuildingLocation1`
    FOREIGN KEY (`buildingArea`)
    REFERENCES `Merkadit_DB`.`BuildingArea` (`buildingArea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Markets_Business1`
    FOREIGN KEY (`businessId`)
    REFERENCES `Merkadit_DB`.`Business` (`businessId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Spaces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Spaces` (
  `spaceId` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(6) NOT NULL,
  `size` FLOAT NOT NULL,
  `type` ENUM("FOOD", "RETAIL") NOT NULL,
  `status` ENUM("AVAILABLE", "OCUPPIED", "UNDER_RENOVATION", "CLOSED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `marketId` INT NOT NULL,
  PRIMARY KEY (`spaceId`),
  INDEX `fk_spaces_markets1_idx` (`marketId` ASC) VISIBLE,
  UNIQUE INDEX `spaceCode_UNIQUE` (`code` ASC) VISIBLE,
  CONSTRAINT `fk_spaces_markets1`
    FOREIGN KEY (`marketId`)
    REFERENCES `Merkadit_DB`.`Markets` (`marketId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Roles` (
  `roleId` INT NOT NULL,
  `roleName` VARCHAR(40) NOT NULL,
  `roleStatus` ENUM("ACTIVE", "INACTIVE", "ELIMINATED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`roleId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Modules` (
  `moduleId` INT NOT NULL,
  `moduleName` VARCHAR(45) NULL,
  PRIMARY KEY (`moduleId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Permissions` (
  `permissionId` INT NOT NULL AUTO_INCREMENT,
  `permissionCode` VARCHAR(15) NULL,
  `permissionStatus` ENUM("ACTIVE", "INACTIVE", "ELIMINATED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `moduleId` INT NOT NULL,
  PRIMARY KEY (`permissionId`),
  INDEX `fk_Permissions_Modules1_idx` (`moduleId` ASC) VISIBLE,
  CONSTRAINT `fk_Permissions_Modules1`
    FOREIGN KEY (`moduleId`)
    REFERENCES `Merkadit_DB`.`Modules` (`moduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`PermissionsPerRole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`PermissionsPerRole` (
  `roleId` INT NOT NULL,
  `permissionId` INT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `permissionPerRoleStaus` ENUM("ACTIVE", "INACTIVE", "ELIMINATED") NOT NULL,
  PRIMARY KEY (`roleId`, `permissionId`),
  INDEX `fk_Roles_has_Permissions_Permissions1_idx` (`permissionId` ASC) VISIBLE,
  INDEX `fk_Roles_has_Permissions_Roles1_idx` (`roleId` ASC) VISIBLE,
  CONSTRAINT `fk_Roles_has_Permissions_Roles1`
    FOREIGN KEY (`roleId`)
    REFERENCES `Merkadit_DB`.`Roles` (`roleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Roles_has_Permissions_Permissions1`
    FOREIGN KEY (`permissionId`)
    REFERENCES `Merkadit_DB`.`Permissions` (`permissionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`UserPermissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`UserPermissions` (
  `userId` INT NOT NULL,
  `permission_id` INT NOT NULL,
  `userPermssionStatus` ENUM("ACTIVE", "INACTIVE", "ELIMINATED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`userId`, `permission_id`),
  INDEX `fk_Users_has_Permissions_Permissions1_idx` (`permission_id` ASC) VISIBLE,
  INDEX `fk_Users_has_Permissions_Users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Permissions_Users1`
    FOREIGN KEY (`userId`)
    REFERENCES `Merkadit_DB`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Permissions_Permissions1`
    FOREIGN KEY (`permission_id`)
    REFERENCES `Merkadit_DB`.`Permissions` (`permissionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`UserBusiness`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`UserBusiness` (
  `userId` INT NOT NULL,
  `BusinessId` INT NOT NULL,
  `status` ENUM("ACTIVE", "INACTIVE", "ELIMINATED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`userId`, `BusinessId`),
  INDEX `fk_Users_has_Business_Business1_idx` (`BusinessId` ASC) VISIBLE,
  INDEX `fk_Users_has_Business_Users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Business_Users1`
    FOREIGN KEY (`userId`)
    REFERENCES `Merkadit_DB`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Business_Business1`
    FOREIGN KEY (`BusinessId`)
    REFERENCES `Merkadit_DB`.`Business` (`businessId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`RentPaymentFrequencies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`RentPaymentFrequencies` (
  `rentPaymentFrequencyId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NULL DEFAULT 'MONTHLY',
  PRIMARY KEY (`rentPaymentFrequencyId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Currencies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Currencies` (
  `currencyId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `code` VARCHAR(4) NOT NULL,
  `symbol` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`currencyId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Contracts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Contracts` (
  `contractId` INT NOT NULL AUTO_INCREMENT,
  `legalId` VARCHAR(20) NOT NULL,
  `rentAmount` FLOAT NOT NULL,
  `depositAmount` FLOAT NOT NULL COMMENT 'Pago inicial de garantía',
  `feePercentage` FLOAT NOT NULL,
  `status` ENUM("PENDING", "ACTIVE", "TERMINATED", "EXPIRED") NOT NULL,
  `latePaymentPolicy` VARCHAR(255) NOT NULL,
  `termsAndConditions` TEXT(0) NOT NULL,
  `fileURL` VARCHAR(255) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `startDate` DATETIME NOT NULL,
  `endDate` DATETIME NOT NULL,
  `rentPaymentFrequencyId` INT NOT NULL,
  `currencyId` INT NOT NULL,
  `adminBusinessId` INT NOT NULL,
  `tenantBusinessId` INT NOT NULL,
  `createdBy` INT NOT NULL,
  `signedBy` INT NOT NULL,
  PRIMARY KEY (`contractId`),
  INDEX `fk_Contracts_Business1_idx` (`tenantBusinessId` ASC) VISIBLE,
  INDEX `fk_Contracts_Business2_idx` (`adminBusinessId` ASC) VISIBLE,
  INDEX `fk_Contracts_Users1_idx` (`signedBy` ASC) VISIBLE,
  INDEX `fk_Contracts_Users2_idx` (`createdBy` ASC) VISIBLE,
  INDEX `fk_Contracts_RentPaymentFrequency1_idx` (`rentPaymentFrequencyId` ASC) VISIBLE,
  INDEX `fk_Contracts_CurrencyCodes1_idx` (`currencyId` ASC) VISIBLE,
  CONSTRAINT `fk_Contracts_Business1`
    FOREIGN KEY (`tenantBusinessId`)
    REFERENCES `Merkadit_DB`.`Business` (`businessId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contracts_Business2`
    FOREIGN KEY (`adminBusinessId`)
    REFERENCES `Merkadit_DB`.`Business` (`businessId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contracts_Users1`
    FOREIGN KEY (`signedBy`)
    REFERENCES `Merkadit_DB`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contracts_Users2`
    FOREIGN KEY (`createdBy`)
    REFERENCES `Merkadit_DB`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contracts_RentPaymentFrequency1`
    FOREIGN KEY (`rentPaymentFrequencyId`)
    REFERENCES `Merkadit_DB`.`RentPaymentFrequencies` (`rentPaymentFrequencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contracts_CurrencyCodes1`
    FOREIGN KEY (`currencyId`)
    REFERENCES `Merkadit_DB`.`Currencies` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`ContactMethodTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`ContactMethodTypes` (
  `contactMethodTypeId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`contactMethodTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`ContactMethods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`ContactMethods` (
  `contactMethodId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  `contactMethodTypeiId` INT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `deleted` BIT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`contactMethodId`),
  INDEX `fk_ContactMethods_ContactMethod_types1_idx` (`contactMethodTypeiId` ASC) VISIBLE,
  CONSTRAINT `fk_ContactMethods_ContactMethod_types1`
    FOREIGN KEY (`contactMethodTypeiId`)
    REFERENCES `Merkadit_DB`.`ContactMethodTypes` (`contactMethodTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`ProductCategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`ProductCategories` (
  `productCategoryId` INT NOT NULL AUTO_INCREMENT,
  `productCategoryName` VARCHAR(30) NULL,
  PRIMARY KEY (`productCategoryId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`TransactionTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`TransactionTypes` (
  `transactionType` INT NOT NULL,
  `name` VARCHAR(30) NULL,
  PRIMARY KEY (`transactionType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`PaymentMethods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`PaymentMethods` (
  `paymentMethodId` INT NOT NULL,
  `name` VARCHAR(30) NULL,
  PRIMARY KEY (`paymentMethodId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Transactions` (
  `TransactionId` INT NOT NULL,
  `amount` FLOAT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `status` ENUM("PENDING", "CANCELLED", "COMPLETED") NOT NULL,
  `enabled` TINYINT NOT NULL,
  `checksum` VARCHAR(64) NULL,
  `transactionType` INT NOT NULL,
  `businessId` INT NOT NULL,
  `contractId` INT NULL,
  `currencyId` INT NOT NULL,
  `paymentMethodId` INT NOT NULL,
  PRIMARY KEY (`TransactionId`),
  INDEX `fk_Transactions_TransactionTypes1_idx` (`transactionType` ASC) VISIBLE,
  INDEX `fk_Transactions_Business1_idx` (`businessId` ASC) VISIBLE,
  INDEX `fk_Transactions_Contracts1_idx` (`contractId` ASC) VISIBLE,
  INDEX `fk_Transactions_Currencies1_idx` (`currencyId` ASC) VISIBLE,
  INDEX `fk_Transactions_PaymentMethods1_idx` (`paymentMethodId` ASC) VISIBLE,
  CONSTRAINT `fk_Transactions_TransactionTypes1`
    FOREIGN KEY (`transactionType`)
    REFERENCES `Merkadit_DB`.`TransactionTypes` (`transactionType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transactions_Business1`
    FOREIGN KEY (`businessId`)
    REFERENCES `Merkadit_DB`.`Business` (`businessId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transactions_Contracts1`
    FOREIGN KEY (`contractId`)
    REFERENCES `Merkadit_DB`.`Contracts` (`contractId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transactions_Currencies1`
    FOREIGN KEY (`currencyId`)
    REFERENCES `Merkadit_DB`.`Currencies` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transactions_PaymentMethods1`
    FOREIGN KEY (`paymentMethodId`)
    REFERENCES `Merkadit_DB`.`PaymentMethods` (`paymentMethodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`SaleBills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`SaleBills` (
  `saleBillId` INT NOT NULL AUTO_INCREMENT,
  `BillNumber` INT UNSIGNED NOT NULL,
  `referenceNumber` INT UNSIGNED NOT NULL,
  `discount` FLOAT NULL,
  `taxAmount` FLOAT NULL,
  `taxApplied` FLOAT NULL,
  `total` FLOAT NULL,
  `paymentConfirmation` JSON NULL,
  `buyerName` VARCHAR(60) NULL,
  `buyerId` INT NULL,
  `createdAt` DATETIME NOT NULL,
  `checksum` VARCHAR(64) NULL,
  `transactionId` INT NOT NULL,
  `contractId` INT NOT NULL,
  `paymentMethodId` INT NOT NULL,
  PRIMARY KEY (`saleBillId`),
  INDEX `fk_GlobalBill_Transactions1_idx` (`transactionId` ASC) VISIBLE,
  INDEX `fk_SaleBills_Contracts1_idx` (`contractId` ASC) VISIBLE,
  INDEX `fk_SaleBills_PaymentMethods1_idx` (`paymentMethodId` ASC) VISIBLE,
  CONSTRAINT `fk_GlobalBill_Transactions1`
    FOREIGN KEY (`transactionId`)
    REFERENCES `Merkadit_DB`.`Transactions` (`TransactionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SaleBills_Contracts1`
    FOREIGN KEY (`contractId`)
    REFERENCES `Merkadit_DB`.`Contracts` (`contractId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SaleBills_PaymentMethods1`
    FOREIGN KEY (`paymentMethodId`)
    REFERENCES `Merkadit_DB`.`PaymentMethods` (`paymentMethodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`BusinessSaleItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`BusinessSaleItems` (
  `businessSaleItemId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `price` FLOAT NOT NULL,
  `barCode` VARCHAR(50) NOT NULL,
  `status` ENUM("ACTIVE", "INACTIVE", "CHANGED", "ELIMINATED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `businessId` INT NOT NULL,
  `currencyId` INT NOT NULL,
  PRIMARY KEY (`businessSaleItemId`),
  INDEX `fk_BusinessSaleItems_Business1_idx` (`businessId` ASC) VISIBLE,
  INDEX `fk_BusinessSaleItems_Currencies1_idx` (`currencyId` ASC) VISIBLE,
  CONSTRAINT `fk_BusinessSaleItems_Business1`
    FOREIGN KEY (`businessId`)
    REFERENCES `Merkadit_DB`.`Business` (`businessId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BusinessSaleItems_Currencies1`
    FOREIGN KEY (`currencyId`)
    REFERENCES `Merkadit_DB`.`Currencies` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`BillDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`BillDetail` (
  `billDetail_id` INT NOT NULL,
  `quantity` INT NULL,
  `unitPrice` FLOAT NOT NULL,
  `subtotal` FLOAT NULL,
  `checkSum` INT NULL,
  `createdAt` DATETIME NOT NULL,
  `saleBillId` INT NOT NULL,
  `businessSaleItemId` INT NOT NULL,
  PRIMARY KEY (`billDetail_id`),
  INDEX `fk_BillDetail_SaleBills1_idx` (`saleBillId` ASC) VISIBLE,
  INDEX `fk_BillDetail_BusinessSaleItems1_idx` (`businessSaleItemId` ASC) VISIBLE,
  CONSTRAINT `fk_BillDetail_SaleBills1`
    FOREIGN KEY (`saleBillId`)
    REFERENCES `Merkadit_DB`.`SaleBills` (`saleBillId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BillDetail_BusinessSaleItems1`
    FOREIGN KEY (`businessSaleItemId`)
    REFERENCES `Merkadit_DB`.`BusinessSaleItems` (`businessSaleItemId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`BusinessCategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`BusinessCategories` (
  `businessCategoryId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`businessCategoryId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`CategoriesPerBusiness`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`CategoriesPerBusiness` (
  `BusinessId` INT NOT NULL,
  `BuisinessCategoryId` INT NOT NULL,
  `status` ENUM("ACTIVE", "INACTIVE", "ELIMINATED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`BusinessId`, `BuisinessCategoryId`),
  INDEX `fk_Business_has_Business_category_Business_category1_idx` (`BuisinessCategoryId` ASC) VISIBLE,
  INDEX `fk_Business_has_Business_category_Business1_idx` (`BusinessId` ASC) VISIBLE,
  CONSTRAINT `fk_Business_has_Business_category_Business1`
    FOREIGN KEY (`BusinessId`)
    REFERENCES `Merkadit_DB`.`Business` (`businessId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Business_has_Business_category_Business_category1`
    FOREIGN KEY (`BuisinessCategoryId`)
    REFERENCES `Merkadit_DB`.`BusinessCategories` (`businessCategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`SpacesPerContract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`SpacesPerContract` (
  `contractId` INT NOT NULL,
  `spaceId` INT NOT NULL,
  `status` ENUM("ACTIVE", "CANCELLED", "INACTIVE") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`contractId`, `spaceId`),
  INDEX `fk_Contracts_has_SpaceInMarket_SpaceInMarket1_idx` (`spaceId` ASC) VISIBLE,
  INDEX `fk_Contracts_has_SpaceInMarket_Contracts1_idx` (`contractId` ASC) VISIBLE,
  CONSTRAINT `fk_Contracts_has_SpaceInMarket_Contracts1`
    FOREIGN KEY (`contractId`)
    REFERENCES `Merkadit_DB`.`Contracts` (`contractId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contracts_has_SpaceInMarket_SpaceInMarket1`
    FOREIGN KEY (`spaceId`)
    REFERENCES `Merkadit_DB`.`Spaces` (`spaceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Applications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Applications` (
  `AppId` INT NOT NULL,
  `appName` VARCHAR(45) NOT NULL,
  `appType` ENUM("Web App", "Mobile App") NULL,
  `moduleId` INT NOT NULL,
  PRIMARY KEY (`AppId`),
  INDEX `fk_Applications_Modules1_idx` (`moduleId` ASC) VISIBLE,
  CONSTRAINT `fk_Applications_Modules1`
    FOREIGN KEY (`moduleId`)
    REFERENCES `Merkadit_DB`.`Modules` (`moduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`UnitMeasures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`UnitMeasures` (
  `unitMeasureId` INT NOT NULL,
  `name` VARCHAR(30) NULL,
  `code` VARCHAR(3) NULL,
  PRIMARY KEY (`unitMeasureId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`BusinessProducts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`BusinessProducts` (
  `businessProductId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `status` ENUM("ACTIVE", "INACTIVE", "CHANGED", "ELIMINATED") NULL,
  `price` FLOAT NOT NULL,
  `cost` FLOAT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `businessId` INT NOT NULL,
  `productCategoryId` INT NOT NULL,
  `currencyId` INT NOT NULL,
  `unitMeasureId` INT NULL,
  PRIMARY KEY (`businessProductId`),
  INDEX `fk_BusinessProducts_Business1_idx` (`businessId` ASC) VISIBLE,
  INDEX `fk_BusinessProducts_ProductCategories1_idx` (`productCategoryId` ASC) VISIBLE,
  INDEX `fk_BusinessProducts_Currencies1_idx` (`currencyId` ASC) VISIBLE,
  INDEX `fk_BusinessProducts_UnitMeasures1_idx` (`unitMeasureId` ASC) VISIBLE,
  CONSTRAINT `fk_BusinessProducts_Business1`
    FOREIGN KEY (`businessId`)
    REFERENCES `Merkadit_DB`.`Business` (`businessId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BusinessProducts_ProductCategories1`
    FOREIGN KEY (`productCategoryId`)
    REFERENCES `Merkadit_DB`.`ProductCategories` (`productCategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BusinessProducts_Currencies1`
    FOREIGN KEY (`currencyId`)
    REFERENCES `Merkadit_DB`.`Currencies` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BusinessProducts_UnitMeasures1`
    FOREIGN KEY (`unitMeasureId`)
    REFERENCES `Merkadit_DB`.`UnitMeasures` (`unitMeasureId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`Inventory` (
  `InventoryId` INT NOT NULL,
  `status` ENUM("ACTIVE", "INACTIVE", "ELIMINATED") NOT NULL,
  `quantity` INT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `contractId` INT NOT NULL,
  `businessProductId` INT NOT NULL,
  PRIMARY KEY (`InventoryId`),
  INDEX `fk_Inventory_Contracts1_idx` (`contractId` ASC) VISIBLE,
  INDEX `fk_Inventory_BusinessProducts1_idx` (`businessProductId` ASC) VISIBLE,
  CONSTRAINT `fk_Inventory_Contracts1`
    FOREIGN KEY (`contractId`)
    REFERENCES `Merkadit_DB`.`Contracts` (`contractId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventory_BusinessProducts1`
    FOREIGN KEY (`businessProductId`)
    REFERENCES `Merkadit_DB`.`BusinessProducts` (`businessProductId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`InventoryLogTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`InventoryLogTypes` (
  `InventoryLogTypeId` INT NOT NULL,
  `name` VARCHAR(60) NULL,
  PRIMARY KEY (`InventoryLogTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`InventoryLogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`InventoryLogs` (
  `InventoryLogId` INT NOT NULL,
  `changeQuantity` INT NOT NULL,
  `changeType` ENUM("SALE", "PURCHASE", "ASJUSTMENT", "TRANSFER") NOT NULL,
  `InventoryLogTypeId` INT NOT NULL,
  `InventoryId` INT NOT NULL,
  `checksum` VARCHAR(64) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  PRIMARY KEY (`InventoryLogId`),
  INDEX `fk_InventoryLogs_InventoryLogTypes1_idx` (`InventoryLogTypeId` ASC) VISIBLE,
  INDEX `fk_InventoryLogs_Inventory1_idx` (`InventoryId` ASC) VISIBLE,
  CONSTRAINT `fk_InventoryLogs_InventoryLogTypes1`
    FOREIGN KEY (`InventoryLogTypeId`)
    REFERENCES `Merkadit_DB`.`InventoryLogTypes` (`InventoryLogTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InventoryLogs_Inventory1`
    FOREIGN KEY (`InventoryId`)
    REFERENCES `Merkadit_DB`.`Inventory` (`InventoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`SystemLogTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`SystemLogTypes` (
  `SystemLogTypeId` INT NOT NULL,
  `LogTypeName` VARCHAR(30) NULL,
  PRIMARY KEY (`SystemLogTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`LogSources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`LogSources` (
  `logSourceId` INT NOT NULL,
  `LogSourceName` VARCHAR(45) NULL,
  PRIMARY KEY (`logSourceId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`LogLevels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`LogLevels` (
  `LogLevelId` INT NOT NULL,
  `logLevelName` VARCHAR(45) NULL,
  PRIMARY KEY (`LogLevelId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`SystemLogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`SystemLogs` (
  `SystemLogId` INT NOT NULL,
  `SystemLogTypeId` INT NOT NULL,
  `ModuleId` INT NOT NULL,
  `UserId` INT NOT NULL,
  `Description` VARCHAR(255) NULL,
  `postTime` TIMESTAMP(6) NULL,
  `SystemLogscol` VARCHAR(45) NULL,
  `logSourceId` INT NOT NULL,
  `logLevelId` INT NOT NULL,
  PRIMARY KEY (`SystemLogId`),
  INDEX `fk_SystemLogs_SystemLogTypes1_idx` (`SystemLogTypeId` ASC) VISIBLE,
  INDEX `fk_SystemLogs_Modules1_idx` (`ModuleId` ASC) VISIBLE,
  INDEX `fk_SystemLogs_Users1_idx` (`UserId` ASC) VISIBLE,
  INDEX `fk_SystemLogs_LogSources1_idx` (`logSourceId` ASC) VISIBLE,
  INDEX `fk_SystemLogs_LogLevels1_idx` (`logLevelId` ASC) VISIBLE,
  CONSTRAINT `fk_SystemLogs_SystemLogTypes1`
    FOREIGN KEY (`SystemLogTypeId`)
    REFERENCES `Merkadit_DB`.`SystemLogTypes` (`SystemLogTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SystemLogs_Modules1`
    FOREIGN KEY (`ModuleId`)
    REFERENCES `Merkadit_DB`.`Modules` (`moduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SystemLogs_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `Merkadit_DB`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SystemLogs_LogSources1`
    FOREIGN KEY (`logSourceId`)
    REFERENCES `Merkadit_DB`.`LogSources` (`logSourceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SystemLogs_LogLevels1`
    FOREIGN KEY (`logLevelId`)
    REFERENCES `Merkadit_DB`.`LogLevels` (`LogLevelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`OperationalExpenseTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`OperationalExpenseTypes` (
  `operationalExpenseTypeId` INT NOT NULL,
  `name` VARCHAR(30) NULL,
  PRIMARY KEY (`operationalExpenseTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`OperationalExpenses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`OperationalExpenses` (
  `operationalExpenseId` INT NOT NULL AUTO_INCREMENT,
  `operationalExpenseTypeId` INT NOT NULL,
  `transactionId` INT NOT NULL,
  `checksum` VARCHAR(64) NULL,
  PRIMARY KEY (`operationalExpenseId`),
  INDEX `fk_OperationalExpenses_OperationalExpenseTypes1_idx` (`operationalExpenseTypeId` ASC) VISIBLE,
  INDEX `fk_OperationalExpenses_Transactions1_idx` (`transactionId` ASC) VISIBLE,
  CONSTRAINT `fk_OperationalExpenses_OperationalExpenseTypes1`
    FOREIGN KEY (`operationalExpenseTypeId`)
    REFERENCES `Merkadit_DB`.`OperationalExpenseTypes` (`operationalExpenseTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OperationalExpenses_Transactions1`
    FOREIGN KEY (`transactionId`)
    REFERENCES `Merkadit_DB`.`Transactions` (`TransactionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`ContactMethodsPerBusiness`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`ContactMethodsPerBusiness` (
  `businessId` INT NOT NULL,
  `contactMethodId` INT NOT NULL,
  `status` ENUM("ACTIVE", "INACTIVE", "CHANGED", "ELIMINATED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`businessId`, `contactMethodId`),
  INDEX `fk_Business_has_ContactMethods_ContactMethods1_idx` (`contactMethodId` ASC) VISIBLE,
  INDEX `fk_Business_has_ContactMethods_Business1_idx` (`businessId` ASC) VISIBLE,
  CONSTRAINT `fk_Business_has_ContactMethods_Business1`
    FOREIGN KEY (`businessId`)
    REFERENCES `Merkadit_DB`.`Business` (`businessId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Business_has_ContactMethods_ContactMethods1`
    FOREIGN KEY (`contactMethodId`)
    REFERENCES `Merkadit_DB`.`ContactMethods` (`contactMethodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`ContactMethodsPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`ContactMethodsPerUser` (
  `userId` INT NOT NULL,
  `contactMethodId` INT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `status` ENUM("ACTIVE", "INACTIVE", "CHANGED", "ELIMINATED") NOT NULL,
  PRIMARY KEY (`userId`, `contactMethodId`),
  INDEX `fk_Users_has_ContactMethods_ContactMethods1_idx` (`contactMethodId` ASC) VISIBLE,
  INDEX `fk_Users_has_ContactMethods_Users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_ContactMethods_Users1`
    FOREIGN KEY (`userId`)
    REFERENCES `Merkadit_DB`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_ContactMethods_ContactMethods1`
    FOREIGN KEY (`contactMethodId`)
    REFERENCES `Merkadit_DB`.`ContactMethods` (`contactMethodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`RolesPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`RolesPerUser` (
  `userId` INT NOT NULL,
  `roleId` INT NOT NULL,
  `status` ENUM("ACTIVE", "INACTIVE", "ELIMINATED") NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`userId`, `roleId`),
  INDEX `fk_Users_has_Roles_Roles1_idx` (`roleId` ASC) VISIBLE,
  INDEX `fk_Users_has_Roles_Users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Roles_Users1`
    FOREIGN KEY (`userId`)
    REFERENCES `Merkadit_DB`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Roles_Roles1`
    FOREIGN KEY (`roleId`)
    REFERENCES `Merkadit_DB`.`Roles` (`roleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`AccountsReceivables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`AccountsReceivables` (
  `accountReceivableId` INT NOT NULL,
  `totalAmount` FLOAT NULL,
  `currentBalance` FLOAT NULL,
  `status` ENUM("ACTIVE", "CLOSED", "INACTIVE") NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `businessId` INT NOT NULL,
  `contractId` INT NOT NULL,
  `currencyId` INT NOT NULL,
  PRIMARY KEY (`accountReceivableId`),
  INDEX `fk_AccountsReceivable_Business1_idx` (`businessId` ASC) VISIBLE,
  INDEX `fk_AccountsReceivable_Contracts1_idx` (`contractId` ASC) VISIBLE,
  INDEX `fk_AccountsReceivable_Currencies1_idx` (`currencyId` ASC) VISIBLE,
  CONSTRAINT `fk_AccountsReceivable_Business1`
    FOREIGN KEY (`businessId`)
    REFERENCES `Merkadit_DB`.`Business` (`businessId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AccountsReceivable_Contracts1`
    FOREIGN KEY (`contractId`)
    REFERENCES `Merkadit_DB`.`Contracts` (`contractId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AccountsReceivable_Currencies1`
    FOREIGN KEY (`currencyId`)
    REFERENCES `Merkadit_DB`.`Currencies` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Merkadit_DB`.`AccountReceivableLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Merkadit_DB`.`AccountReceivableLog` (
  `accountReceivablesLog` INT NOT NULL AUTO_INCREMENT,
  `changeAmount` FLOAT NULL,
  `description` VARCHAR(255) NULL,
  `createdAt` DATETIME NOT NULL,
  `changeType` ENUM("CHARGE", "PAYMENT", "ADJUSTMENT") NULL,
  `checksum` VARCHAR(64) NULL,
  `transactionId` INT NOT NULL,
  `accountReceivableId` INT NOT NULL,
  PRIMARY KEY (`accountReceivablesLog`),
  INDEX `fk_AccountReceivableLog_AccountsReceivables1_idx` (`accountReceivableId` ASC) VISIBLE,
  INDEX `fk_AccountReceivableLog_Transactions1_idx` (`transactionId` ASC) VISIBLE,
  CONSTRAINT `fk_AccountReceivableLog_AccountsReceivables1`
    FOREIGN KEY (`accountReceivableId`)
    REFERENCES `Merkadit_DB`.`AccountsReceivables` (`accountReceivableId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AccountReceivableLog_Transactions1`
    FOREIGN KEY (`transactionId`)
    REFERENCES `Merkadit_DB`.`Transactions` (`TransactionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
