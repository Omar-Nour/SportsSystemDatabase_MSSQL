﻿CREATE DATABASE SportsSystemDB;

GO
CREATE PROCEDURE createAllTables
AS 
	CREATE TABLE SystemUser (
		username VARCHAR(20) PRIMARY KEY,
		password VARCHAR(20)
	);

	CREATE TABLE SystemAdmin (
		id int IDENTITY,
		username VARCHAR(20),
		name VARCHAR(20),
		CONSTRAINT SysAdminPK PRIMARY KEY (id,username),
		FOREIGN KEY (username) REFERENCES SystemUser
	);

	CREATE TABLE StadiumManager(
		id int IDENTITY,
		username VARCHAR(20),
		name VARCHAR(20),
		CONSTRAINT StadManPK PRIMARY KEY (id,username),
		FOREIGN KEY (username) REFERENCES SystemUser
	);

	CREATE TABLE ClubRepresentative(
		id int IDENTITY,
		username VARCHAR(20),
		name VARCHAR(20),
		CONSTRAINT ClubRepPK PRIMARY KEY (id,username),
		FOREIGN KEY (username) REFERENCES SystemUser
	);

	CREATE TABLE Fan(
		username VARCHAR(20),
		NationalID VARCHAR(20),
		PhoneNo VARCHAR(20),
		Address VARCHAR(20),
		name VARCHAR(20),
		status bit,
		BirthDate date,
		CONSTRAINT FanPK PRIMARY KEY (NationalID,username),
		FOREIGN KEY (username) REFERENCES SystemUser
	);

	CREATE TABLE SportsAssociationManager(
		id int IDENTITY,
		username VARCHAR(20),
		name VARCHAR(20),
		CONSTRAINT SPAM_PK PRIMARY KEY (id,username),
		FOREIGN KEY (username) REFERENCES SystemUser
	);

	CREATE TABLE Stadium(
		id int IDENTITY PRIMARY KEY,
		name VARCHAR(20),
		capacity int,
		location VARCHAR(20),
		status bit,
		StadiumManagerID int,
		StadiumManagerUserName VARCHAR(20),
		FOREIGN KEY (StadiumManagerID,StadiumManagerUserName) 
			REFERENCES StadiumManager(id,username)
	);

	CREATE TABLE Club(
		id int IDENTITY PRIMARY KEY,
		name VARCHAR(20),
		location VARCHAR(20),
		ClubRepresentativeID int,
		ClubRepresentativeUserName VARCHAR(20),
		FOREIGN KEY (ClubRepresentativeID,ClubRepresentativeUserName) 
			REFERENCES ClubRepresentative(id,username)
	);

	CREATE TABLE Match(
		id int IDENTITY PRIMARY KEY,
		StartTime datetime,
		EndTime datetime,
		StadiumID int REFERENCES Stadium,
		HostClubID int FOREIGN KEY REFERENCES Club,
		GuestClubID int FOREIGN KEY REFERENCES Club
	);

	CREATE TABLE Ticket(
		id int IDENTITY PRIMARY KEY,
		status bit,
		FanUserName VARCHAR(20), --FOREIGN KEY REFERENCES Fan(username),
		FanNationalID VARCHAR(20), --FOREIGN KEY REFERENCES Fan(NationalID),
		MatchID int FOREIGN KEY REFERENCES Match,
		FOREIGN KEY (FanNationalID,FanUserName) 
			REFERENCES Fan(NationalID,username)
	);

	CREATE TABLE HostRequest(
		id int PRIMARY KEY,
		status bit,
		MatchID int FOREIGN KEY REFERENCES Match,
		StadiumManagerID int,
		StadiumManagerUserName VARCHAR(20),
		ClubRepresentativeID int,
		ClubRepresentativeUserName VARCHAR(20),
		FOREIGN KEY (ClubRepresentativeID,ClubRepresentativeUserName) 
			REFERENCES ClubRepresentative(id,username),
		FOREIGN KEY (StadiumManagerID,StadiumManagerUserName) 
			REFERENCES StadiumManager(id,username)
	);

GO
