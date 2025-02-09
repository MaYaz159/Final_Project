CREATE DATABASE MyWebsite

GO

USE MyWebsite
CREATE TABLE Login ( ID int primary key identity ( 1,1 ) , username varchar(20) unique not null , password varchar(20) not null , Profile_Picture VARBINARY(MAX) );

GO

INSERT INTO Login ( username, password )
VALUES 
    ('admin', 'adminpassword'), 
    ('mayaz', 'mayazpassword'), 
    ('sara2000', 'sarapassword'), 
    ('israa2003', 'israapassword'), 
    ('jad2009', 'jadpassword'), 
    ('haneen2005', 'haneenpassword');

INSERT INTO Login ( username, password )
VALUES ('jawad2006' , 'jawadpassword'); 

GO

use MyWebsite
SELECT * FROM Login;

GO



