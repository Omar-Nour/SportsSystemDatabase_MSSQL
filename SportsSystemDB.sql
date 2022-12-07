CREATE DATABASE SportsSystemDB;

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

GO
CREATE PROCEDURE dropAllTables 
AS
	DROP TABLE SystemUser;
	DROP TABLE SystemAdmin;
	DROP TABLE StadiumManager;
	DROP TABLE ClubRepresentative;
	DROP TABLE Fan;
	DROP TABLE SportsAssociationManager;
	DROP TABLE Stadium;
	DROP TABLE Club;
	DROP TABLE Match;
	DROP TABLE Ticket;
	DROP TABLE HostRequest;
GO

GO
CREATE PROCEDURE dropAllProceduresFunctionsViews
AS
	DROP PROCEDURE createAllTables;
	DROP PROCEDURE dropAllTables;
	DROP PROCEDURE clearAllTables;
	--Add as you go
GO

GO
CREATE PROCEDURE clearAllTables
AS
	TRUNCATE TABLE SystemUser;
	TRUNCATE TABLE SystemAdmin;
	TRUNCATE TABLE StadiumManager;
	TRUNCATE TABLE ClubRepresentative;
	TRUNCATE TABLE Fan;
	TRUNCATE TABLE SportsAssociationManager;
	TRUNCATE TABLE Stadium;
	TRUNCATE TABLE Club;
	TRUNCATE TABLE Match;
	TRUNCATE TABLE Ticket;
	TRUNCATE TABLE HostRequest;
GO

GO
CREATE VIEW allAssocManagers AS
	SELECT username,name
	FROM SportsAssociationManager;
GO

GO
CREATE VIEW allClubRepresentatives AS
	SELECT R.username AS RepUserName,R.name AS RepName,C.name AS ClubName
		FROM ClubRepresentative AS R,Club AS C
		WHERE R.id = C.ClubRepresentativeID 
			AND R.username = C.ClubRepresentativeUserName;
GO

GO
CREATE VIEW allStadiumManagers AS
	SELECT M.username AS StadManUserName,M.name AS StadManName,S.name AS StadiumName
		FROM StadiumManager AS M,Stadium AS S
		WHERE M.id = S.StadiumManagerID 
			AND M.username = S.StadiumManagerUserName;
GO

GO
CREATE VIEW allFans AS
	SELECT name, NationalID,Birthdate,status
		FROM Fan;
GO

GO
CREATE VIEW allMatches AS 
	SELECT C.name AS Club1,C2.name AS Club2,C.name AS HostClub, M.StartTime AS KickOffTime
		FROM Match AS M, Club AS C, Club AS C2
			WHERE M.HostClubID = C.id 
				AND M.GuestClubID = C2.id AND C.id <> C2.id
GO

GO
CREATE VIEW allTickets AS
	SELECT C.name AS Club1, C2.name AS Club2, S.name AS Stadium,M.StartTime AS KickOffTime
		FROM Match AS M, Ticket AS T, Club AS C, Club AS C2, Stadium AS S
			WHERE M.HostClubID = C.id 
				AND M.GuestClubID = C2.id AND C.id <> C2.id
				AND T.MatchID = M.id 
				AND M.StadiumID = S.id;
GO

GO
CREATE VIEW allClubs AS
	SELECT name,location
		FROM Club;
GO