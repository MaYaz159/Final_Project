CREATE DATABASE MyWebsite

GO

USE MyWebsite;
CREATE TABLE Login ( ID int primary key identity ( 1,1 ) , username varchar(100) not null , password varchar(100) not null , Profile_Picture VARBINARY(MAX) );

GO

INSERT INTO Login ( username, password )
VALUES 
    ('Admin', '0000'), 
    ('Mayaz', 'mayazpassword'), 
    ('Sara', 'sarapassword'), 
    ('Israa', 'israapassword'), 
    ('Jad', 'jadpassword'), 
    ('Haneen', 'haneenpassword');

GO

use MyWebsite;
SELECT * FROM Login;

GO

DELETE FROM Login
DROP TABLE Login

GO

use MyWebsite;
EXEC sp_help 'Login';

GO

