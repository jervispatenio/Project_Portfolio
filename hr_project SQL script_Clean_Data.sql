CREATE DATABASE hr_project;

USE hr_project;

-- Load .csv file table : hr

SELECT * FROM hr;
DESCRIBE hr;

ALTER TABLE hr
CHANGE COLUMN id emp_id VARCHAR(20) NULL;

-- Modify column 'birthdate', 'hire_date' and 'termdate' to appropriate datatype

-- for birthdate column

SET SQL_SAFE_UPDATES = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL 
	END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;


-- for hire_date column
UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL 
	END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- for termdate column
UPDATE hr
SET termdate = date(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- ADD column for 'age' -- calculated from birthdate to current date

ALTER TABLE hr
ADD COLUMN age INT;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM hr;
DESCRIBE hr;

-- check min and max age
SELECT
	MIN(age) as youngest,
    MAX(age) as oldest
FROM hr;

-- You may use this dataset for Power BI visualization
SELECT *
FROM hr;