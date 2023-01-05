-- 2022/11/20  Practice importing HepaT1ca dataset into MySQL -- 
-- CREATE DATABASE HepaT1ca;
-- Use HepaT1ca;

-- I want to get the big csv into the database itself and use it as a guidance 
-- The goal of transforming HepaT1ca dataset into MySQL is to:
-- able to query blood serum information, demeographic pretty easily
-- able to inspect outlier cases easily


USE HepaT1ca;
SELECT * from pre_demographic;

SHOW database;

DROP TABLE pre_demographic;

CREATE TABLE pre_demographic
(
record_id VARCHAR(70) NOT NULL,
redcap_event_name VARCHAR(70),
redcap_repeat_instrument VARCHAR(70),
redcap_repeat_instance VARCHAR(70),
redcap_data_access_group VARCHAR(70),
informed_consent VARCHAR(70),
inc_considered_for_tace VARCHAR(70),
under_18 VARCHAR(70),
prisoner VARCHAR(70),
unable_mri VARCHAR(70),
adult_incapacity VARCHAR(70),
eligible VARCHAR(70),
inclusion_exclusion_complete VARCHAR(70),
participant_cohort VARCHAR(70),
age_years VARCHAR(70),
sex VARCHAR(70),
ethnicity VARCHAR(70),
specify_ethnicity VARCHAR(70),
expected_pathology VARCHAR(70),
expected_pathology_spcfy VARCHAR(180),
cohort_demographics_complete VARCHAR(70)
);

SELECT * from pre_demographic; -- check if there is data in the table already

SHOW global variables like 'local_infile';

SET GLOBAL local_infile=1; -- this resolve ERROR 3948 (45000): Loading local data is disabled; this must be enabled on both the client and server sides


-- to load data from local file
load data local infile '/Users/yi-chunwang/2022-10-18 ISMRM Bayesian Network/bayesianismrm/Data/2022-11-50 pre_demographic.csv'
into TABLE pre_demographic
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 LINES;

-- still recieve this error
-- ERROR 5068 (HY000): LOAD DATA LOCAL INFILE file request rejected due to restrictions on access.
-- https://stackoverflow.com/questions/63361962/error-2068-hy000-load-data-local-infile-file-request-rejected-due-to-restrict




