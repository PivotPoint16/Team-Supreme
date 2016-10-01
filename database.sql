/*
DROP AND CREATE DATABASE
*/
DROP DATABASE HUDDB;
CREATE DATABASE HUDDB;
/*
DROP AND CREATE USER AND GRANT PRIVILEGES
*/
/*DROP USER IF EXISTS 'hudadmin'@'localhost';*/
CREATE USER 'hudadmin'@'localhost' IDENTIFIED BY 'hud@Dm1N';
GRANT ALL ON HUDDB.* TO 'hudadmin'@'localhost';
/*
SWITCH DATABASE
*/
USE HUDDB;
/*
CREATE TABLES
*/
CREATE TABLE STATE_LIST
(
  state_id int not null primary key,
  state_name varchar(100) not null,
  state_code varchar(2) not null
);

CREATE TABLE APARTMENT_LISTING
(
  apartment_id int not null primary key auto_increment,
  apartment_street_address varchar(256) not null,
  apartment_city varchar(100) not null,
  apartment_state_id int not null,
  apartment_zip_code int not null,
  apartment_start_date date not null,
  apartment_end_date date not null,
  foreign key (apartment_state_id)
      references STATE_LIST(state_id)
      on delete cascade on update cascade
);

/*
LIST OF STATES DATA
*/
INSERT INTO STATE_LIST VALUES
(1, 'ALABAMA',	'AL'),
(2, 'ALASKA',	'AK'),
(3, 'ARIZONA',	'AZ'),
(4, 'ARKANSAS',	'AR'),
(5, 'CALIFORNIA',	'CA'),
(6, 'COLORADO',	'CO'),
(7, 'CONNECTICUT',	'CT'),
(8, 'DELAWARE',	'DE'),
(9, 'FLORIDA',	'FL'),
(10, 'GEORGIA',	'GA'),
(11, 'HAWAII',	'HI'),
(12, 'IDAHO',	'ID'),
(13, 'ILLINOIS',	'IL'),
(14, 'INDIANA',	'IN'),
(15, 'IOWA',	'IA'),
(16, 'KANSAS',	'KS'),
(17, 'KENTUCKY',	'KY'),
(18, 'LOUISIANA',	'LA'),
(19, 'MAINE',	'ME'),
(20, 'MARYLAND',	'MD'),
(21, 'MASSACHUSETTS',	'MA'),
(22, 'MICHIGAN',	'MI'),
(23, 'MINNESOTA',	'MN'),
(24, 'MISSISSIPPI',	'MS'),
(25, 'MISSOURI',	'MO'),
(26, 'MONTANA',	'MT'),
(27, 'NEBRASKA',	'NE'),
(28, 'NEVADA',	'NV'),
(29, 'NEW HAMPSHIRE',	'NH'),
(30, 'NEW JERSEY',	'NJ'),
(31, 'NEW MEXICO',	'NM'),
(32, 'NEW YORK',	'NY'),
(33, 'NORTH CAROLINA',	'NC'),
(34, 'NORTH DAKOTA',	'ND'),
(35, 'OHIO',	'OH'),
(36, 'OKLAHOMA',	'OK'),
(37, 'OREGON',	'OR'),
(38, 'PENNSYLVANIA',	'PA'),
(39, 'RHODE ISLAND',	'RI'),
(40, 'SOUTH CAROLINA',	'SC'),
(41, 'SOUTH DAKOTA',	'SD'),
(42, 'TENNESSEE',	'TN'),
(43, 'TEXAS',	'TX'),
(44, 'UTAH',	'UT'),
(45, 'VERMONT',	'VT'),
(46, 'VIRGINIA',	'VA'),
(47, 'WASHINGTON',	'WA'),
(48, 'WEST VIRGINIA',	'WV'),
(49, 'WISCONSIN',	'WI'),
(50, 'WYOMING',	'WY'),
(51, 'GUAM',	'GU'),
(52, 'PUERTO RICO',	'PR'),
(53, 'VIRGIN ISLANDS',	'VI');

/*
LIST OF TEST APARTMENT LISTINGS
*/
INSERT INTO APARTMENT_LISTING VALUES
(NULL, '1222 UNIVERSITY CITY BLVD.', 'BLACKSBURG', 46, 24060, '2016-10-01','2016-12-01'),
(NULL, '413 HUNT CLUB RD', 'BLACKSBURG', 46, 24060, '2016-11-11','2017-03-01'),
(NULL, '321 EDGE WAY', 'BLACKSBURG', 46, 24060, '2016-09-28','2017-01-01');
