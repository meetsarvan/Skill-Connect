-- Create database and connect to it (Run in psql or PostgreSQL client)
CREATE DATABASE skill_connect;
\c skill_connect;

-- ========================================================================================================= --
-- DDL Script for Skill Connect Platform                                                                     --
-- |                                                                                                         --   
-- |>This script defines all tables and relationships required for the Skill Connect job matching system.    --
-- ========================================================================================================= --

-- Table storing basic user details
CREATE TABLE user_t( 
    user_id INT PRIMARY KEY, 
    user_name VARCHAR(30) NOT NULL, 
    github_handle VARCHAR(50), 
    codeforces_handle VARCHAR(50), 
    leetcode_handle VARCHAR(50), 
    dob DATE NOT NULL, 
    city VARCHAR(30) NOT NULL, 
    state VARCHAR(30) NOT NULL 
); 

-- Table for storing multiple mobile numbers for users
CREATE TABLE mobile_number ( 
    user_id INT, 
    mobile_number VARCHAR(15), 
    PRIMARY KEY (user_id, mobile_number), 
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE 
); 

-- Table for storing multiple email addresses for users
CREATE TABLE email_id ( 
    user_id INT, 
    email_id VARCHAR(255), 
    PRIMARY KEY (user_id, email_id), 
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE 
); 

-- Login credentials for users
CREATE TABLE user_login ( 
    user_id INT, 
    applicant_username VARCHAR(50) PRIMARY KEY, 
    password VARCHAR(100) NOT NULL, 
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) 
); 

-- Projects done by users
CREATE TABLE project ( 
    pno INT PRIMARY KEY, 
    user_id INT, 
    pname VARCHAR(50) NOT NULL, 
    description TEXT, 
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE 
); 

-- Technologies used in each project
CREATE TABLE project_techstack ( 
    pno INT, 
    tech VARCHAR(50), 
    PRIMARY KEY (pno, tech), 
    FOREIGN KEY (pno) REFERENCES project(pno) ON DELETE CASCADE 
); 

-- Master table of skills
CREATE TABLE skills ( 
    skill_name VARCHAR(100), 
    skill_category VARCHAR(100), 
    description TEXT, 
    PRIMARY KEY (skill_name) 
); 

-- Skills possessed by users
CREATE TABLE possess( 
    skill_name VARCHAR(100), 
    user_id INT, 
    PRIMARY KEY (skill_name, user_id), 
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE, 
    FOREIGN KEY (skill_name) REFERENCES skills(skill_name) ON DELETE CASCADE 
); 

-- Work experience of users
CREATE TABLE experience ( 
    eid INT PRIMARY KEY, 
    user_id INT, 
    company_name VARCHAR(100) NOT NULL, 
    address VARCHAR(255) NOT NULL, 
    mode VARCHAR(25) NOT NULL,  -- e.g. Remote/Onsite
    duration VARCHAR(30) NOT NULL, 
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE 
); 

-- Details specific to internships
CREATE TABLE internship_experience ( 
    eid INT PRIMARY KEY, 
    supervision_level VARCHAR(50) NOT NULL, 
    FOREIGN KEY (eid) REFERENCES experience(eid) ON DELETE CASCADE 
); 

-- Details specific to job experience
CREATE TABLE job_experience ( 
    eid INT PRIMARY KEY, 
    seniority_level VARCHAR(50), 
    FOREIGN KEY (eid) REFERENCES experience(eid) ON DELETE CASCADE 
); 

-- Schooling information of the user
CREATE TABLE schooling ( 
    seat_no_10th VARCHAR(20) PRIMARY KEY, 
    seat_no_12th VARCHAR(20) NOT NULL, 
    user_id INT, 
    pass_out_year_12th INT NOT NULL, 
    school_name_12th VARCHAR(100) NOT NULL, 
    school_name_10th VARCHAR(100) NOT NULL, 
    percentage_10th DECIMAL(5, 2) NOT NULL, 
    percentage_12th DECIMAL(5, 2) NOT NULL, 
    school_address_12th VARCHAR(100) NOT NULL, 
    JEE_percentile DECIMAL(5, 2), 
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE 
); 

-- User's job/internship expectations
CREATE TABLE expectation ( 
    exp_id INT, 
    user_id INT, 
    contract_time VARCHAR(50), 
    salary DECIMAL(10, 2), 
    preference_mode VARCHAR(100) NOT NULL, -- e.g. Remote/Hybrid
    PRIMARY KEY (exp_id, user_id), 
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE 
); 

-- Degrees and specializations offered
CREATE TABLE degree ( 
    specialization VARCHAR(50), 
    degree VARCHAR(50), 
    PRIMARY KEY (specialization, degree) 
); 

-- College master table
CREATE TABLE college ( 
    college_name VARCHAR(50) PRIMARY KEY, 
    address VARCHAR(255) NOT NULL 
); 

-- Degrees completed by users
CREATE TABLE completed ( 
    user_id INT, 
    specialization VARCHAR(50), 
    degree VARCHAR(50), 
    college_name VARCHAR(50), 
    passout_year INT NOT NULL, 
    CGPA DECIMAL(4, 2) NOT NULL, 
    PRIMARY KEY (user_id, specialization, degree, college_name), 
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE, 
    FOREIGN KEY (specialization, degree) REFERENCES degree(specialization, degree) ON DELETE CASCADE, 
    FOREIGN KEY (college_name) REFERENCES college(college_name) ON DELETE CASCADE 
); 

-- Degrees offered by a college
CREATE TABLE offer ( 
    college_name VARCHAR(50), 
    specialization VARCHAR(50), 
    degree VARCHAR(50), 
    PRIMARY KEY (college_name, specialization, degree), 
    FOREIGN KEY (specialization, degree) REFERENCES degree(specialization, degree) ON DELETE CASCADE, 
    FOREIGN KEY (college_name) REFERENCES college(college_name) ON DELETE CASCADE 
); 

-- Companies table
CREATE TABLE company ( 
    cid INT PRIMARY KEY, 
    company_name VARCHAR(50) NOT NULL, 
    website_link VARCHAR(100), 
    headquarter_id INT NOT NULL 
); 

-- Company emails
CREATE TABLE company_email ( 
    cid INT, 
    email_id VARCHAR(255), 
    PRIMARY KEY (cid, email_id), 
    FOREIGN KEY (cid) REFERENCES company(cid) ON DELETE CASCADE 
); 

-- Company contact numbers
CREATE TABLE company_contact_number ( 
    cid INT, 
    contact_number VARCHAR(15), 
    PRIMARY KEY (cid, contact_number), 
    FOREIGN KEY (cid) REFERENCES company(cid) ON DELETE CASCADE 
); 

-- Login credentials for companies
CREATE TABLE company_login ( 
    company_username VARCHAR(100) PRIMARY KEY, 
    password VARCHAR(100) NOT NULL, 
    cid INT, 
    FOREIGN KEY (cid) REFERENCES company(cid) 
); 

-- Offices of a company
CREATE TABLE offices ( 
    office_id INT, 
    cid INT, 
    city VARCHAR(20) NOT NULL, 
    state VARCHAR(20) NOT NULL, 
    PRIMARY KEY (cid, office_id), 
    FOREIGN KEY (cid) REFERENCES company(cid) 
); 

-- Job offers by companies
CREATE TABLE offers ( 
    offer_id INT PRIMARY KEY, 
    cid INT, 
    skill_required VARCHAR(30) NOT NULL, 
    role VARCHAR(50) NOT NULL, 
    number_of_vacancies INT NOT NULL, 
    end_date DATE NOT NULL, 
    salary DECIMAL(10, 2) NOT NULL, 
    FOREIGN KEY (cid) REFERENCES company(cid) 
); 

-- Contract details for offers
CREATE TABLE contract ( 
    contract_number INT, 
    contract_start_date DATE, 
    contract_end_date DATE NOT NULL, 
    min_duration INT NOT NULL, -- in months or weeks
    location VARCHAR(255) NOT NULL, 
    mode VARCHAR(30) NOT NULL, -- e.g. Remote/Onsite
    shift VARCHAR(30) NOT NULL, -- e.g. Day/Night
    offer_id INT, 
    PRIMARY KEY (contract_number, offer_id), 
    FOREIGN KEY (offer_id) REFERENCES offers(offer_id) 
); 

-- Users applying to offers
CREATE TABLE apply ( 
    user_id INT, 
    offer_id INT, 
    apply_date DATE NOT NULL, 
    status VARCHAR(30) NOT NULL, -- e.g. Pending, Selected
    PRIMARY KEY (user_id, offer_id), 
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) ON DELETE CASCADE, 
    FOREIGN KEY (offer_id) REFERENCES offers(offer_id) ON DELETE CASCADE 
); 

-- Companies searching for users
CREATE TABLE search ( 
    cid INT, 
    user_id INT, 
    PRIMARY KEY (cid, user_id), 
    FOREIGN KEY (cid) REFERENCES company(cid), 
    FOREIGN KEY (user_id) REFERENCES user_t(user_id) 
);