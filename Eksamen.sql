START TRANSACTION;

CREATE SCHEMA IF NOT EXISTS eksamen;

-- Satt rekkefølge for å droppe de riktig, hvis de eksisterer. 
DROP TABLE IF EXISTS Subscription;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS UserLivestream;
DROP TABLE IF EXISTS Livestream;
DROP TABLE IF EXISTS Video;
DROP TABLE IF EXISTS UserInfo;

-- Skape tabellene
CREATE TABLE UserInfo(
	UserID CHAR(27) NOT NULL UNIQUE,
    UserNumber TINYINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    UserName VARCHAR(100) NOT NULL,
    FirstName VARCHAR(15) NOT NULL,
    LastName VARCHAR(25) NOT NULL,
    CountryOfRes ENUM('Norway', 'Sweden', 'Denmark', 'Finland', 'Russia', 'Iceland'),
    Password VARCHAR(50) NOT NULL,
    DateOfRegister TIMESTAMP,
    CONSTRAINT UserInfo_PK PRIMARY KEY(UserID)
);

CREATE TABLE Subscription(
	UserID CHAR(27) NOT NULL,
    SubscribesTo TINYINT UNSIGNED NOT NULL,
    Started TIMESTAMP,
    CONSTRAINT Subscription_PK Primary KEY(UserID, SubscribesTo),
    CONSTRAINT Subs_UserInfo_FK FOREIGN KEY(SubscribesTo) REFERENCES UserInfo(UserNumber)
);

CREATE TABLE Video(
	VideoID VARCHAR(9) NOT NULL UNIQUE,
    UserID CHAR(27) NOT NULL,
    Title VARCHAR(150) DEFAULT 'UNNAMED',
	Description VARCHAR(500) DEFAULT 'No Description found',
    Uploaded TIMESTAMP,
    ViewNumber SMALLINT,
    CONSTRAINT Video_PK PRIMARY KEY(VideoID),
    CONSTRAINT Video_UserInfo_FK FOREIGN KEY(UserID) REFERENCES UserInfo(UserID)
);

CREATE TABLE Comments(
	CommentID INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    VideoID VARCHAR(9) NOT NULL,
    UserID CHAR(27) NOT NULL,
    Comment TEXT,
    Made TIMESTAMP,
    CONSTRAINT Comments_PK PRIMARY KEY(CommentID),
    CONSTRAINT Comments_Video_FK FOREIGN KEY(VideoID) REFERENCES Video(VideoID),
    CONSTRAINT Comments_UserInfo_FK FOREIGN KEY(UserID) REFERENCES UserInfo(UserID)
);

CREATE TABLE Livestream(
	StreamID VARCHAR(9) NOT NULL UNIQUE,
    UserID CHAR(27) NOT NULL,
    Title VARCHAR(150) DEFAULT 'Unnamed Steam',
    Description TEXT,
    ViewNumber SMALLINT,
    CONSTRAINT Livestream_PK PRIMARY KEY(StreamID),
    CONSTRAINT Livestream_UserInfo_FK FOREIGN KEY(UserID) REFERENCES Userinfo(UserID)
);

-- Skape koblingsentitet
CREATE TABLE UserLivestream(
	ULUserID CHAR(27) NOT NULL,
    ULStreamID VARCHAR(9) NOT NULL,
    CONSTRAINT UL_PK PRIMARY KEY(ULUserID, ULStreamID),
    CONSTRAINT UL_UserInfo_FK FOREIGN KEY(ULUserID) REFERENCES UserInfo(UserID),
    CONSTRAINT UL_Livestream_FK FOREIGN KEY(ULStreamID) REFERENCES Livestream(StreamID)
);

-- Legg inn data i UserInfo
INSERT INTO UserInfo(UserID, UserName, Firstname, LastName, CountryOfRes, Password)
VALUES('yPuIjS8cdvmQcDElSbHKbPI7PXP', 'BenJen01', 'Ben', 'Jenkins', 'Russia', 'Password123'), 
	  ('uZghnOQiZazhbxjVxC3ipXfzINg', 'Alacho', 'Håvard', 'Mathisen', 'Norway', 'SomethingSecret435'),
      ('3OhZHe60v9m9nSFgPHEbAQC3gef', 'Lauper', 'Per', 'Lavuås', 'Norway', 'LaererIDB1100'), 
	  ('VFh8WUJxGXR6oxUUDCcu4Kvsq7V', 'Garbits', 'George', 'Lopez', 'Russia', '764352sda'),
      ('yAJTgoDFXYX935XPjTGSKxoNzd6', 'Boeller', 'Gabriel', 'Iglesias', 'Sweden', 'jegblesammenmed'), 
	  ('6wjm3yxzS02KdVPhtrQCKiLCIOM', 'Johan Falkenberg', 'Johan', 'Falkenberg', 'Denmark', 'LompererGodt1243'),
      ('8yBjF79yF7l7sZFvczaUvNJCC8J', 'Cato-Wize', 'Carlo', 'Josham', 'Finland', 'Gambino23'), 
	  ('Bq1fjp2XmJD8g1qG2oidFHSJ7uF', 'Wizard', 'You', 'wish', 'Iceland', 'HjelpeMeg'),
      ('d4H2kz5yxj8Ema2QvWpKTsZ4Trg', 'Herrpot', 'Harry', 'Potter', 'Sweden', 'Titt10titt'), 
	  ('9ObqY02K9nA4KOrPfuHQ4QSEJrG', 'Frubor', 'Petunia', 'Pottesen', 'Norway', 'JegGikkFemPa');

-- Legg inn data i Subscription
INSERT INTO Subscription(UserID, SubscribesTo)
VALUES('yPuIjS8cdvmQcDElSbHKbPI7PXP', '1'),
	  ('3OhZHe60v9m9nSFgPHEbAQC3gef', '2'),
      ('yAJTgoDFXYX935XPjTGSKxoNzd6', '3'),
	  ('6wjm3yxzS02KdVPhtrQCKiLCIOM', '5'),
      ('d4H2kz5yxj8Ema2QvWpKTsZ4Trg', '4'),
	  ('uZghnOQiZazhbxjVxC3ipXfzINg', '10'),
      ('8yBjF79yF7l7sZFvczaUvNJCC8J', '9'),
	  ('9ObqY02K9nA4KOrPfuHQ4QSEJrG', '8'),
      ('yPuIjS8cdvmQcDElSbHKbPI7PXP', '7'),
	  ('d4H2kz5yxj8Ema2QvWpKTsZ4Trg', '10'),
      ('yAJTgoDFXYX935XPjTGSKxoNzd6', '5'),
	  ('3OhZHe60v9m9nSFgPHEbAQC3gef', '3'),
      ('9ObqY02K9nA4KOrPfuHQ4QSEJrG', '2'),
	  ('uZghnOQiZazhbxjVxC3ipXfzINg', '1'),
      ('d4H2kz5yxj8Ema2QvWpKTsZ4Trg', '7'),
      ('d4H2kz5yxj8Ema2QvWpKTsZ4Trg', '5'),
	  ('VFh8WUJxGXR6oxUUDCcu4Kvsq7V', '6'),
      ('uZghnOQiZazhbxjVxC3ipXfzINg', '2');

-- Legg inn videoer
INSERT INTO Video(VideoID, UserID, Title, Description, ViewNumber)
VALUES('A7stswuGt', 'uZghnOQiZazhbxjVxC3ipXfzINg', 'A lonely cat', 'This video will make me rich', 10343),
      ('uL4Mp3Dm1', '3OhZHe60v9m9nSFgPHEbAQC3gef', 'En kjedelig dag', 'Filmet 1. klasse', 10),
      ('ul20W49PX', '3OhZHe60v9m9nSFgPHEbAQC3gef', 'Nei', 'Hallo MYSQL', 100),
      ('q5RMaToeX', 'yAJTgoDFXYX935XPjTGSKxoNzd6', 'Jamie.mov', 'My brother is weird', 32767),
      ('VbPD3es84', 'uZghnOQiZazhbxjVxC3ipXfzINg', 'Let''s Play Minecraft', 'We be pewdiepie', 233),
      ('vfu82Qc', 'Bq1fjp2XmJD8g1qG2oidFHSJ7uF', 'Pretend to play', 'Found love in a 8-bit game', 999),
      ('M0p4af17A', 'd4H2kz5yxj8Ema2QvWpKTsZ4Trg', 'Barbie girl', 'I play with my barbie', 301),
      ('hWOaDs9Ow', '6wjm3yxzS02KdVPhtrQCKiLCIOM', 'Guess who''s back', 'Back again', 0),
      ('2mcdYXr', 'uZghnOQiZazhbxjVxC3ipXfzINg', 'Back again', 'Shadies back', 666),
      ('4SwqZNrn3', 'Bq1fjp2XmJD8g1qG2oidFHSJ7uF', 'Never Gonna', 'Rick Roll', 878),
      ('hVd6ck73l', 'd4H2kz5yxj8Ema2QvWpKTsZ4Trg', 'Give you up', 'Was made for loving you', 15000),
      ('BoV6FMkmW', '9ObqY02K9nA4KOrPfuHQ4QSEJrG', 'Never gonna', 'Describe what?', 4525),
      ('y0HOfn', 'd4H2kz5yxj8Ema2QvWpKTsZ4Trg', 'Let you down', 'HAH. STOOPID.', 9043),
      ('0pVxvHqkP', '3OhZHe60v9m9nSFgPHEbAQC3gef', 'Never gonna', 'Jonathan from Spotify', 999),
      ('Dw8xGqrNe', '8yBjF79yF7l7sZFvczaUvNJCC8J', 'Run around', 'joidjoiasdjiosajoi sadjoi asoidj iaosd', 22);

-- Legg inn videoer uten beskrivelse 
INSERT INTO Video(VideoID, UserID, Title, ViewNumber)
VALUES('aLRf3', '6wjm3yxzS02KdVPhtrQCKiLCIOM', 'You wish!', 2),
      ('7dgI', 'yAJTgoDFXYX935XPjTGSKxoNzd6', 'Sangen ble ikke', 0);

-- Legg inn videoer uten tittel
INSERT INTO Video(VideoID, UserID, Description, ViewNumber)
VALUES('wBhPbp3', 'yAJTgoDFXYX935XPjTGSKxoNzd6', 'FERDIG!', 1);

SELECT * FROM UserInfo;

COMMIT;