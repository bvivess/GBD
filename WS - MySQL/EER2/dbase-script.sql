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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema qcenter
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`school`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`school` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `contact_info` JSON NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`course` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(45) NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `year_holidays` JSON NULL,
  `school_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_course_school1`
    FOREIGN KEY (`school_id`)
    REFERENCES `mydb`.`school` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_course_school1_idx` ON `mydb`.`course` (`school_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`reports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reports` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `id` INT NOT NULL AUTO_INCREMENT,
  `update_time` TIMESTAMP NULL,
  `reports` JSON NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_reports_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `mydb`.`course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_reports_course1_idx` ON `mydb`.`reports` (`course_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`deparment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`deparment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL,
  `school_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_deparment_school`
    FOREIGN KEY (`school_id`)
    REFERENCES `mydb`.`school` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_deparment_school_idx` ON `mydb`.`deparment` (`school_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `deparment_id` INT NOT NULL,
  CONSTRAINT `fk_user_deparment1`
    FOREIGN KEY (`deparment_id`)
    REFERENCES `mydb`.`deparment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_user_deparment1_idx` ON `mydb`.`user` (`deparment_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
