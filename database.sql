/*
DROP AND CREATE DATABASE
*/
DROP DATABASE HUDDB;
CREATE DATABASE HUDDB;
/*
DROP AND CREATE USER AND GRANT PRIVILEGES
*/
/*DROP USER IF EXISTS 'hudadmin'@'localhost';*/
/*CREATE USER 'hudadmin'@'localhost' IDENTIFIED BY 'hud@Dm1N';
GRANT ALL ON HUDDB.* TO 'hudadmin'@'localhost';*/
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

CREATE TABLE USER
(
  user_id int not null primary key auto_increment,
  user_name varchar(100) not null,
  user_fullname varchar(100) not null,
  user_email varchar(100) not null,
  user_phone varchar(20) not null
);

CREATE TABLE APARTMENT_LISTING
(
  apartment_id int not null primary key auto_increment,
  apartment_street_address varchar(256) not null,
  apartment_city varchar(100) not null,
  apartment_state_id int not null,
  apartment_zip_code int not null,
  foreign key (apartment_state_id)
      references STATE_LIST(state_id)
      on delete cascade on update cascade
);

CREATE TABLE USER_APARTMENT_INFO
(
  user_apartment_info_id int not null primary key auto_increment,
  user_apartment_info_user_id int not null,
  user_apartment_info_apartment_id int not null,
  user_apartment_info_start_date date not null,
  user_apartment_info_end_date date not null,
  user_apartment_info_rent int not null,
  user_apartment_info_description varchar(500) not null,
  foreign key (user_apartment_info_user_id)
      references USER(user_id)
      on delete cascade on update cascade,
  foreign key (user_apartment_info_apartment_id)
      references APARTMENT_LISTING(apartment_id)
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
LIST OF USERS
*/
INSERT INTO USER VALUES
(NULL, 'shawnee', 'Shawnee Apartments', 'shawnee@cmgleasing.com', '(540) 552-2384'),
(NULL, 'terraceview', 'Terrace View Apartments', 'leasing@terraceviewapartments.com', '(540) 315-3280'),
(NULL, 'theedge', 'The Edge', 'leasing@vtcampusedge.com', '(540) 552-3343'),
(NULL, 'hud', 'US Department of Housing and Urban Development', 'contactus@hud.gov', '(202) 708-1112');

/*
LIST OF TEST APARTMENT LISTINGS
*/
INSERT INTO APARTMENT_LISTING VALUES
(NULL, '1222 UNIVERSITY CITY BLVD.', 'BLACKSBURG', 46, 24060),
(NULL, '413 HUNT CLUB RD', 'BLACKSBURG', 46, 24060),
(NULL, '321 EDGE WAY', 'BLACKSBURG', 46, 24060);



/*
USER APARTMENT LISTING
*/
INSERT INTO USER_APARTMENT_INFO VALUES
(NULL, 1, 1, '2016-10-01', '2016-12-01', '600', 'Professionally maintained property features spacious apartments, natural landscaping and a park setting conducive to relaxation and leisurely walks. Our central location and multiple bus stops provide easy access to Virginia Tech, Kroger, University Mall, Starbucks and much more.'),
(NULL, 2, 2, '2016-11-11', '2017-03-01', '700', 'Living here, you''ll be less than 1 mile from Virginia Tech, have access to 14 bus stops and a bike lane to campus, close to local hot spots, shopping, Route 460, and more! You can choose from a variety of floor plans to suit your personal style. Townhomes and Garden Apartments are available in many sizes, with a multitude of options.'),
(NULL, 3, 3, '2016-09-28', '2017-01-01', '800', 'Come home to your fully furnished apartment with all utilities included. We offer Individual Leases (by the bed) with private bath & walk in closet, roommate matching and unsurpassed amenities, just steps to campus.');


/*
CREATE VIEW
*/
CREATE VIEW USER_APARTMENT_LISTING_VIEW AS
                      SELECT UAI.user_apartment_info_id,
                       CONCAT(
                       AL.apartment_street_address, ', ',
                       AL.apartment_city, ', ',
                       SL.state_name, ' ',
                       AL.apartment_zip_code) as apartment_listing_address,
                       SL.state_code,
                       UAI.user_apartment_info_start_date,
                       UAI.user_apartment_info_end_date,
                       UAI.user_apartment_info_rent,
                       UL.user_fullname,
                       UL.user_email,
                       UL.user_phone
                       FROM USER as UL JOIN
                       USER_APARTMENT_INFO AS UAI ON UL.user_id = UAI.user_apartment_info_user_id JOIN
                       APARTMENT_LISTING AS AL ON UAI.user_apartment_info_apartment_id = AL.apartment_id JOIN
                       STATE_LIST AS SL ON AL.apartment_state_id = SL.state_id
