-- Import this file once into MySQL/MariaDB.
-- The server.cfg connection string must use this same database: tsivtools.
CREATE DATABASE IF NOT EXISTS `tsivtools`
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE `tsivtools`;

CREATE TABLE IF NOT EXISTS `users` (
    `identifier` VARCHAR(60) NOT NULL,
    `ssn` VARCHAR(11) NOT NULL,
    `accounts` LONGTEXT NULL,
    `group` VARCHAR(50) NULL DEFAULT 'user',
    `inventory` LONGTEXT NULL,
    `job` VARCHAR(20) NULL DEFAULT 'unemployed',
    `job_grade` INT NULL DEFAULT 0,
    `loadout` LONGTEXT NULL,
    `metadata` LONGTEXT NULL,
    `position` LONGTEXT NULL,
    `firstname` VARCHAR(16) NULL DEFAULT NULL,
    `lastname` VARCHAR(16) NULL DEFAULT NULL,
    `dateofbirth` VARCHAR(10) NULL DEFAULT NULL,
    `sex` VARCHAR(1) NULL DEFAULT NULL,
    `height` INT NULL DEFAULT NULL,
    `skin` LONGTEXT NULL,
    `disabled` TINYINT(1) NULL DEFAULT 0,
    PRIMARY KEY (`identifier`),
    UNIQUE KEY `unique_ssn` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `items` (
    `name` VARCHAR(50) NOT NULL,
    `label` VARCHAR(50) NOT NULL,
    `weight` INT NOT NULL DEFAULT 1,
    `rare` TINYINT NOT NULL DEFAULT 0,
    `can_remove` TINYINT NOT NULL DEFAULT 1,
    PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `jobs` (
    `name` VARCHAR(50) NOT NULL,
    `label` VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO `jobs` (`name`, `label`)
VALUES ('unemployed', 'Unemployed');

CREATE TABLE IF NOT EXISTS `job_grades` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `job_name` VARCHAR(50) DEFAULT NULL,
    `grade` INT NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `label` VARCHAR(50) NOT NULL,
    `salary` INT NOT NULL,
    `skin_male` LONGTEXT NOT NULL,
    `skin_female` LONGTEXT NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO `job_grades`
    (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`)
VALUES
    (1, 'unemployed', 0, 'unemployed', 'Unemployed', 200, '{}', '{}');

CREATE TABLE IF NOT EXISTS `tsivtools_bans` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(64) NOT NULL,
    `identifiers` TEXT NULL,
    `name` VARCHAR(64) NOT NULL DEFAULT '',
    `reason` VARCHAR(255) NOT NULL DEFAULT '',
    `banned_by` VARCHAR(64) NOT NULL DEFAULT '',
    `created_at` INT UNSIGNED NOT NULL DEFAULT 0,
    `expires_at` INT UNSIGNED NOT NULL DEFAULT 0,
    `active` TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`),
    KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tsivtools_logs` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `category` VARCHAR(32) NOT NULL,
    `created_at` INT UNSIGNED NOT NULL DEFAULT 0,
    `actor` VARCHAR(64) NOT NULL DEFAULT '',
    `actor_name` VARCHAR(64) NOT NULL DEFAULT '',
    `target` VARCHAR(64) NOT NULL DEFAULT '',
    `target_name` VARCHAR(64) NOT NULL DEFAULT '',
    `message` TEXT NULL,
    `data` TEXT NULL,
    PRIMARY KEY (`id`),
    KEY `category` (`category`),
    KEY `actor` (`actor`),
    KEY `target` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tsivtools_watchlist` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(80) NOT NULL,
    `identifiers` TEXT NULL,
    `name` VARCHAR(64) NOT NULL DEFAULT '',
    `note` VARCHAR(255) NOT NULL DEFAULT '',
    `added_by` VARCHAR(80) NOT NULL DEFAULT '',
    `created_at` INT UNSIGNED NOT NULL DEFAULT 0,
    `active` TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`),
    KEY `identifier` (`identifier`),
    KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tsivtools_player_tags` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(80) NOT NULL,
    `name` VARCHAR(64) NOT NULL DEFAULT '',
    `content` VARCHAR(160) NOT NULL,
    `created_at` INT UNSIGNED NOT NULL DEFAULT 0,
    `expires_at` INT UNSIGNED NOT NULL DEFAULT 0,
    `added_by` VARCHAR(80) NOT NULL DEFAULT '',
    PRIMARY KEY (`id`),
    KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tsivtools_player_aliases` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `license` VARCHAR(80) NOT NULL,
    `steam` VARCHAR(80) NOT NULL DEFAULT '',
    `name` VARCHAR(64) NOT NULL DEFAULT '',
    `at` INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `license` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tsivtools_player_relationships` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(80) NOT NULL,
    `related_identifier` VARCHAR(80) NOT NULL,
    `related_name` VARCHAR(64) NOT NULL DEFAULT '',
    `note` VARCHAR(160) NOT NULL DEFAULT '',
    `created_at` INT UNSIGNED NOT NULL DEFAULT 0,
    `added_by` VARCHAR(80) NOT NULL DEFAULT '',
    PRIMARY KEY (`id`),
    KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `multicharacter_slots` (
    `identifier` VARCHAR(60) NOT NULL,
    `slots` INT NOT NULL,
    PRIMARY KEY (`identifier`),
    KEY `slots` (`slots`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;


CREATE TABLE IF NOT EXISTS `owned_vehicles` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(60) NOT NULL,
    `plate` VARCHAR(12) NOT NULL,
    `vehicle` LONGTEXT NOT NULL,
    `type` VARCHAR(20) NOT NULL DEFAULT 'car',
    `job` VARCHAR(20) NOT NULL DEFAULT '',
    `stored` TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_plate` (`plate`),
    KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;