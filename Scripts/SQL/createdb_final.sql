-- This script creates all necessary databases and tables (staging (stg), reporting (rpt), and stats)

-- ------------------------------------------------------------------------------------------------------------------
-- CREATE STAGING DATABASE AND TABLES
-- ------------------------------------------------------------------------------------------------------------------
SET innodb_lock_wait_timeout=100;

-- staging database (staging_db)
CREATE DATABASE staging_db;


USE staging_db;

-- donation staging table (donation_stg)
DROP TABLE IF EXISTS donation_stg;

CREATE TABLE donation_stg(
	num_id int NOT NULL AUTO_INCREMENT,
	FakeID int,
	PrimaryAffiliation char(250), 
	PersonOrg char(2),
	City char(250),
	State char(2), 
	Zip int(10), 
	FiscalYear year (4), 
	ContributionDate varchar(200), 
	Amount decimal(15,2), 
	ContributionType char(250),
	DesignationCode	varchar(250),
	DesignationName	varchar(250),
	VSEPurpose varchar(250),
	College varchar(250),
	DesignationType char(250),
	DesignationPurpose varchar(250),
	PaymentType char(250),
	PRIMARY KEY(num_id));

-- median income staging table (income_stg)
DROP TABLE IF EXISTS income_stg;

CREATE TABLE income_stg(
	income_id int NOT NULL AUTO_INCREMENT,
    zipcode int,
	year int,
    median_income int,
    PRIMARY KEY(income_id));
    
-- median home value table (homeval_stg)
DROP TABLE IF EXISTS homeval_stg;

CREATE TABLE homeval_stg(
	homeval_id int NOT NULL AUTO_INCREMENT,
    zipcode int,
    year int,
    homeval int,
    PRIMARY KEY(homeval_id));
    
-- ------------------------------------------------------------------------------------------------------------------
-- CREATE DONATION DATABASE AND TABLES
-- ------------------------------------------------------------------------------------------------------------------
    
-- donation database (donation_db)
CREATE DATABASE donation_db;

USE donation_db;

-- CREATE DONATION DIMENSION TABLES

-- Create donation table (dim_donation)

DROP TABLE IF EXISTS `dim_donation`;
CREATE TABLE `dim_donation`(
	`donation_key` INT NOT NULL AUTO_INCREMENT,
	`num_id` int,
	`contribution_type` varchar(50),
	`amount` numeric,
	`payment_type` varchar(50),
	PRIMARY KEY(`donation_key`));
    
    
-- Create date table (dim_date)
    
DROP TABLE IF EXISTS `dim_date`;
CREATE TABLE `dim_date`(
	`date_key` int NOT NULL AUTO_INCREMENT,
	`num_id` int,
	`date_string` varchar(50), 
	`year` varchar(20),
	`month` varchar(20),
	`day` varchar(5), 
	`quarter` varchar(10),
        `fiscal_year` int,
	`weekday` varchar(5), 
	`week` varchar(5), 
	PRIMARY KEY (`date_key`));
    
-- Create donor table (dim_donor)

DROP TABLE IF EXISTS `dim_donor`;
CREATE TABLE `dim_donor` (
	`donor_key` int NOT NULL AUTO_INCREMENT,
	`num_id` int,
	`fake_id` varchar(50),
	`primary_affiliation` varchar(50),
	`person_org_ind` varchar(20),
	 PRIMARY KEY(`donor_key`));

-- Create college table (dim_college)

DROP TABLE IF EXISTS `dim_college`;
CREATE TABLE `dim_college` (
	`college_key` int NOT NULL AUTO_INCREMENT,
	`num_id` int,
	`college_name` varchar(50), 
	PRIMARY KEY(`college_key`));
    
-- Create designation table (dim_designation)

DROP TABLE IF EXISTS dim_designation;
CREATE TABLE `dim_designation`(
	`designation_key` int NOT NULL AUTO_INCREMENT,
	`num_id` int,
	`designation_code` varchar(50), 
	`designation_type` varchar(50),
	`designation_purpose` varchar(50), 
	`designation_name` varchar(50), 
	`vse_purpose` varchar(50), 
	PRIMARY KEY(`designation_key`));
    
-- Create location table (dim_location)

DROP TABLE IF EXISTS dim_location;
CREATE TABLE `dim_location`(
	`location_key` int NOT NULL AUTO_INCREMENT,
        `num_id` int,
        `zip_code` int NOT NULL,
        `city` varchar (200),
        `state` varchar (100),
        PRIMARY KEY(`location_key`));
    
-- CREATE DONATION FACT TABLE (donation_fact)

DROP TABLE IF EXISTS donation_fact;
CREATE TABLE `donation_fact`(
	`date_key` int,
	`donation_key` int, 
	`donor_key` int,
	`college_key` int,  
	`designation_key` int,
        `location_key` int);
    
-- add foreign key constraints

SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE `donation_fact`
ADD CONSTRAINT `FK_dim_date` FOREIGN KEY (`date_key`) REFERENCES `dim_date` (`date_key`);

ALTER TABLE `donation_fact`
ADD CONSTRAINT `FK_dim_donation` FOREIGN KEY (`donation_key`) REFERENCES `dim_donation` (`donation_key`);

ALTER TABLE `donation_fact`
ADD CONSTRAINT `FK_dim_donor` FOREIGN KEY (`donor_key`) REFERENCES `dim_donor` (`donor_key`);

ALTER TABLE `donation_fact`
add CONSTRAINT `FK_dim_college` FOREIGN KEY (`college_key`) REFERENCES `dim_college` (`college_key`);

ALTER TABLE `donation_fact`
ADD CONSTRAINT `FK_date` FOREIGN KEY (`designation_key`) REFERENCES `dim_designation` (`designation_key`);

ALTER TABLE `donation_fact`
ADD CONSTRAINT `FK_dim_location` FOREIGN KEY (`location_key`) REFERENCES `dim_location` (`location_key`);

-- 
SET FOREIGN_KEY_CHECKS=1;

    
-- ------------------------------------------------------------------------------------------------------------------
-- CREATE STATS DATABASE AND TABLES
-- ------------------------------------------------------------------------------------------------------------------

-- stats database (stats_db)
CREATE DATABASE stats_db;

USE stats_db;

-- CREATE STATS DIMENSION TABLES

-- Create median homevalue table (dim_homeval)

CREATE TABLE `dim_homeval`(
	homeval_id int NOT NULL AUTO_INCREMENT,
    zipcode int,
    year int,
    homeval int,
    PRIMARY KEY(homeval_id));

    
-- Create median income table (dim_income)

CREATE TABLE `dim_income`(
	income_id int NOT NULL AUTO_INCREMENT,
    zipcode int,
	year int,
    median_income int,
    PRIMARY KEY(income_id));
    
-- create location table (dim_location)

CREATE TABLE `dim_location`(
	location_id int NOT NULL AUTO_INCREMENT,
    zipcode int NOT NULL,
    city varchar (200),
    state varchar (100),
    PRIMARY KEY(location_id));
    
-- CREATE STATS FACT TABLE (stats_fact)

CREATE TABLE `stats_fact`(
	homeval_id int,
    income_id int,
    location_id int);
    
-- add foreign key constraints


SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE `stats_fact`
ADD CONSTRAINT `FK_dim_homeval` FOREIGN KEY (`homeval_id`) REFERENCES `dim_homeval` (`homeval_id`);

ALTER TABLE `stats_fact`
ADD CONSTRAINT `FK_dim_income` FOREIGN KEY (`income_id`) REFERENCES `dim_income` (`income_id`);

ALTER TABLE `stats_fact`
ADD CONSTRAINT `FK_dim_location` FOREIGN KEY (`location_id`) REFERENCES `dim_location` (`location_id`);

-- 
SET FOREIGN_KEY_CHECKS=1;
    

