-- This script creates all stored procdures to load the tables

-- ------------------------------------------------------------------------------------------------------------------
-- CREATE DONATION DATABASE STORED PROCDURES
-- ------------------------------------------------------------------------------------------------------------------
SET innodb_lock_wait_timeout=100;
USE donation_db;

-- load dim_donation procedure
DELIMITER //
CREATE PROCEDURE load_dim_donation()
BEGIN
	INSERT INTO donation_db.dim_donation(num_id, contribution_type, amount, payment_type) 
	SELECT num_id, ContributionType, Amount, PaymentType 
    FROM staging_db.donation_stg;
END //

-- load dim_date procedure

CREATE PROCEDURE load_dim_date()
BEGIN
	INSERT INTO donation_db.dim_date(num_id, date_string, year,month, day, quarter, weekday, week, fiscal_year) 
	SELECT 
		num_id,
		ContributionDate as 'Date String',
		YEAR(str_to_date(ContributionDate,'%m/%d/%Y')) as year,
		MONTH(str_to_date(ContributionDate,'%m/%d/%Y')) as month,
		Day(str_to_date(ContributionDate,'%m/%d/%Y')) as day,
		Quarter(str_to_date(ContributionDate,'%m/%d/%Y')) as quarter,
		WeekDay(str_to_date(ContributionDate,'%m/%d/%Y')) as weekDay,
		Week(str_to_date(ContributionDate,'%m/%d/%Y')) as week,
        FiscalYear as fiscal_year
		FROM staging_db.donation_stg;
END//

-- load dim_donor procedure

CREATE PROCEDURE load_dim_donor()
BEGIN
	INSERT INTO donation_db.dim_donor(num_id, fake_id, primary_affiliation, person_org_ind) 
	SELECT  num_id, FakeID, PrimaryAffiliation, PersonOrg 
    FROM staging_db.donation_stg;
END //

-- load dim_college procedure

CREATE PROCEDURE load_dim_college()
BEGIN
	INSERT INTO donation_db.dim_college(num_id, college_name) 
	SELECT num_id, College 
    FROM staging_db.donation_stg;
END//

-- load dim_designation procedure

CREATE PROCEDURE load_dim_designation()
BEGIN
	INSERT INTO donation_db.dim_designation(num_id, designation_code, designation_type, designation_purpose,designation_name, vse_purpose) 
	SELECT num_id, DesignationCode, DesignationType, DesignationPurpose, DesignationName, VSEpurpose
	FROM staging_db.donation_stg;
END//

-- load dim_location procedure

CREATE PROCEDURE load_dim_loc()
BEGIN
	INSERT INTO donation_db.dim_location(num_id, zip_code, city, state) 
	SELECT num_id, Zip, City, State
	FROM staging_db.donation_stg;
END//


-- load donation_fact procedure

SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 0;

CREATE PROCEDURE load_donation_fact()
BEGIN
	INSERT INTO donation_db.donation_fact(date_key, donation_key, donor_key, college_key, designation_key, location_key)
	SELECT d.date_key, dn.donation_key, don.donor_key, c.college_key, de.designation_key, l.location_key
	FROM donation_db.dim_date d 
	LEFT JOIN donation_db.dim_donation dn ON dn.num_id = d.num_id
	LEFT JOIN donation_db.dim_donor don ON don.num_id = d.num_id
	LEFT JOIN donation_db.dim_college c ON c.num_id = d.num_id
	LEFT JOIN donation_db.dim_designation de ON de.num_id = d.num_id
	LEFT JOIN donation_db.dim_location l ON l.num_id = d.num_id;
END//

DELIMITER ;

SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS = 1;


-- ------------------------------------------------------------------------------------------------------------------
-- CREATE STATS DATABASE STORED PROCDURES
-- ------------------------------------------------------------------------------------------------------------------

USE stats_db;

-- load dim_homeval procedure

DELIMITER //
CREATE PROCEDURE load_dim_homeval()
BEGIN
	INSERT INTO stats_db.dim_homeval(zipcode, year, homeval) 
	SELECT zipcode, year, homeval
    FROM staging_db.homeval_stg;
END //


-- load dim_income procedure

CREATE PROCEDURE load_dim_income()
BEGIN
	INSERT INTO stats_db.dim_income(zipcode, year, median_income) 
	SELECT zipcode, year, median_income
    FROM staging_db.income_stg;
END //


-- load dim_location procedure

CREATE PROCEDURE load_dim_location()
BEGIN
	INSERT INTO stats_db.dim_location(zipcode, city, state) 
	SELECT Zip, City, State
    FROM staging_db.donation_stg;
END //


-- load stats_fact procedure

SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 0;

CREATE PROCEDURE load_stats_fact()
BEGIN
	INSERT INTO stats_db.stats_fact(homeval_id, income_id, location_id)
	SELECT h.homeval_id, i.income_id, l.location_id
	FROM stats_db.dim_homeval h
	LEFT JOIN stats_db.dim_income i ON i.zipcode = h.zipcode
    LEFT JOIN stats_db.dim_location l ON l.zipcode = h.zipcode ;
END//

DELIMITER ;

SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------------------------------------------------------
-- CLEAR STAGING TABLES STORED PROCDURES
-- ------------------------------------------------------------------------------------------------------------------

SET SQL_SAFE_UPDATES = 0;
USE staging_db;

-- clear donation_stg procedure

DELIMITER //
CREATE PROCEDURE del_donation()
BEGIN
	DELETE FROM staging_db.donation_stg;
END//


-- clear homeval_stg procedure

USE stats_db;

DELIMITER //
CREATE PROCEDURE del_homeval()
BEGIN
	DELETE FROM staging_db.homeval_stg;
END//

-- clear income_stg procedure

DELIMITER //
CREATE PROCEDURE del_income()
BEGIN
	DELETE FROM staging_db.income_stg;
END//

SET SQL_SAFE_UPDATES = 1;
