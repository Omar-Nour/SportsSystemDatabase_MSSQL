CREATE DATABASE SportsSystemDB;

GO

--Procedure that creates all tables for DB
CREATE PROCEDURE createAllTables
AS 
	CREATE TABLE SystemUser (
		username VARCHAR(20) PRIMARY KEY,
		password VARCHAR(20)
	);

	CREATE TABLE SystemAdmin (
		id int IDENTITY,
		username VARCHAR(20) UNIQUE,
		name VARCHAR(20),
		CONSTRAINT SysAdminPK PRIMARY KEY (id),
		FOREIGN KEY (username) REFERENCES SystemUser

	);

	CREATE TABLE StadiumManager(
		id int IDENTITY,
		username VARCHAR(20) UNIQUE,
		name VARCHAR(20),
		CONSTRAINT StadManPK PRIMARY KEY (id),
		FOREIGN KEY (username) REFERENCES SystemUser
	);

	CREATE TABLE ClubRepresentative(
		id int IDENTITY,
		username VARCHAR(20) UNIQUE,
		name VARCHAR(20),
		CONSTRAINT ClubRepPK PRIMARY KEY (id),
		FOREIGN KEY (username) REFERENCES SystemUser
	);

	CREATE TABLE Fan(
		username VARCHAR(20) UNIQUE,
		NationalID VARCHAR(20),
		PhoneNo VARCHAR(20),
		Address VARCHAR(20),
		name VARCHAR(20),
		status bit,
		BirthDate date,
		CONSTRAINT FanPK PRIMARY KEY (NationalID),
		FOREIGN KEY (username) REFERENCES SystemUser
	);

	CREATE TABLE SportsAssociationManager(
		id int IDENTITY,
		username VARCHAR(20) UNIQUE,
		name VARCHAR(20),
		CONSTRAINT SPAM_PK PRIMARY KEY (id),
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
		FOREIGN KEY (StadiumManagerID) 
			REFERENCES StadiumManager(id)
	);

	CREATE TABLE Club(
		id int IDENTITY PRIMARY KEY,
		name VARCHAR(20),
		location VARCHAR(20),
		ClubRepresentativeID int,
		ClubRepresentativeUserName VARCHAR(20),
		FOREIGN KEY (ClubRepresentativeID) 
			REFERENCES ClubRepresentative(id)
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
		FanUserName VARCHAR(20), 
		FanNationalID VARCHAR(20), 
		MatchID int FOREIGN KEY REFERENCES Match,
		FOREIGN KEY (FanNationalID) 
			REFERENCES Fan(NationalID)
	);

	CREATE TABLE HostRequest(
		id int PRIMARY KEY,
		status bit,
		MatchID int FOREIGN KEY REFERENCES Match,
		StadiumManagerID int,
		StadiumManagerUserName VARCHAR(20),
		ClubRepresentativeID int,
		ClubRepresentativeUserName VARCHAR(20),
		FOREIGN KEY (ClubRepresentativeID) 
			REFERENCES ClubRepresentative(id),
		FOREIGN KEY (StadiumManagerID) 
			REFERENCES StadiumManager(id)
	);
GO

GO
--Procedure that drops all of the created tables 
CREATE PROCEDURE dropAllTables 
AS
	DROP TABLE Ticket;
	DROP TABLE HostRequest;
	DROP TABLE Match;
	DROP TABLE Stadium;
	DROP TABLE Club;
	DROP TABLE SystemAdmin;
	DROP TABLE StadiumManager;
	DROP TABLE ClubRepresentative;
	DROP TABLE Fan;
	DROP TABLE SportsAssociationManager;
	DROP TABLE SystemUser;
GO

GO
--Procedure that drops all of the created Procedures, Functions or Views 
CREATE PROCEDURE dropAllProceduresFunctionsViews
AS
	DROP PROCEDURE createAllTables;
	DROP PROCEDURE dropAllTables;
	DROP PROCEDURE clearAllTables;
	DROP VIEW allAssocManagers;
	DROP VIEW allClubRepresentatives;
	DROP VIEW allStadiumManagers;
	DROP VIEW allFans;
	DROP VIEW allMatches;
	DROP VIEW allTickets;
	DROP VIEW allClubs;
	DROP VIEW allStadiums;
	DROP VIEW allRequests;
	--Add as you go
GO

GO
--Procedure that clears the rows of all the tables
CREATE PROCEDURE clearAllTables
AS
	DELETE FROM Ticket;
	DELETE FROM HostRequest;
	DELETE FROM Match;
	DELETE FROM Stadium;
	DELETE FROM Club;
	DELETE FROM SystemAdmin;
	DELETE FROM StadiumManager;
	DELETE FROM ClubRepresentative;
	DELETE FROM Fan;
	DELETE FROM SportsAssociationManager;
	DELETE FROM SystemUser;
GO

GO
--A View that returns 
--the usernames and names of all Sports Association Managers
CREATE VIEW allAssocManagers AS
	SELECT username,name
	FROM SportsAssociationManager;
GO

GO
--A View that returns the usernames and names
--of all Club Representatives as well as the name of the club they are 
--representing
CREATE VIEW allClubRepresentatives AS
	SELECT R.username AS RepUserName,R.name AS RepName,C.name AS ClubName
		FROM ClubRepresentative AS R,Club AS C
		WHERE R.id = C.ClubRepresentativeID 
			
GO

GO
--A View that returns the usernames and names
--of all Stadium Managers as well as the name of the stadium they are 
--managing
CREATE VIEW allStadiumManagers AS
	SELECT M.username AS StadManUserName,M.name AS StadManName,S.name AS StadiumName
		FROM StadiumManager AS M,Stadium AS S
		WHERE M.id = S.StadiumManagerID 
			
GO

GO
--A view that returns the name, NationalID
--and status (blocked or unblocked) for all fans
CREATE VIEW allFans AS
	SELECT name, NationalID,Birthdate,status
		FROM Fan;
GO

GO
--A view that returns the start time of the match
--as well as the names of the competing clubs (and the name of the host club)
--for all matches
CREATE VIEW allMatches AS 
	SELECT C.name AS Club1,C2.name AS Club2,C.name AS HostClub, M.StartTime AS KickOffTime
		FROM Match AS M, Club AS C, Club AS C2
			WHERE M.HostClubID = C.id 
				AND M.GuestClubID = C2.id AND C.id <> C2.id
GO

GO
--A View that returns the name of the competing clubs for a match,
--the starttime and the stadium for all Tickets
CREATE VIEW allTickets AS
	SELECT C.name AS Club1, C2.name AS Club2, S.name AS Stadium,M.StartTime AS KickOffTime
		FROM Match AS M, Ticket AS T, Club AS C, Club AS C2, Stadium AS S
			WHERE M.HostClubID = C.id 
				AND M.GuestClubID = C2.id AND C.id <> C2.id
				AND T.MatchID = M.id 
				AND M.StadiumID = S.id;
GO

GO
--A view that returns the name and location of all clubs
CREATE VIEW allClubs AS
	SELECT name,location
		FROM Club;
GO

GO
--A View that returns the name, location, capacity
-- and status (available or unavailable) for all Stadiums
CREATE VIEW allStadiums AS 
	SELECT name, location, capacity, status AS StadiumStatus
		FROM Stadium;
GO

GO
--A View that returns the name of the Club Representative sending a host request,
--the name of the Stadium Manager receiving the request,
--and its status (accepted or rejected)
CREATE VIEW allRequests AS 
	SELECT CR.name AS ClubRepSending, SM.name AS StadManReceiving,H.
	status AS RequestStatus
		FROM HostRequest AS H,StadiumManager AS SM, ClubRepresentative AS CR
			WHERE SM.id = H.StadiumManagerID 
			AND CR.id = H.ClubRepresentativeID;
GO


-- (------------------ 2.3 ------------------)


--(I)
GO
CREATE PROCEDURE addAssociationManager 
		@name VARCHAR(20),
		@Username VARCHAR(20), 
		@Password VARCHAR(20)

	AS

		INSERT INTO SystemUser
		VALUES (@Username, @Password);
		INSERT INTO SportsAssociationManager
		VALUES (@name, @Username);	
GO

--(II)
GO
CREATE PROCEDURE addNewMatch
		@HostName VARCHAR(20),
		@GuestName VARCHAR(20),
		@StartTime datetime,
		@EndTime datetime

	AS
		INSERT INTO Match
		VALUES (@StartTime, @EndTime, NULL, @HostName, @GuestName);
GO

--(III)
GO 
CREATE VIEW clubsWithNoMatches
AS

	SELECT C.name
	FROM Club C
	WHERE C.id NOT IN (SELECT HostClubID
			   FROM Match M
			   WHERE C.id = M.HostClubID
					)					
			AND

		C.id NOT IN (SELECT GuestClubID
				FROM Match M
				WHERE C.id = M.GuestClubID
					);
GO

--(IV)
GO
CREATE PROCEDURE deleteMatch
		@HostClub VARCHAR(20),
		@GuestClub VARCHAR(20)
AS
		DECLARE @Host_id INT = (SELECT C.id FROM Club C WHERE C.name = @HostClub);
		DECLARE @Guest_id INT = (SELECT C.id FROM Club C WHERE C.name = @GuestClub);


		DELETE FROM Match  
		WHERE Match.HostClubID = @Host_id AND Match.GuestClubID = @Guest_id;
GO

--(V)
GO

CREATE PROCEDURE deleteMatchesOnStadium
		@StadiumName VARCHAR(20)
AS
		DECLARE @StadiumID INT = (SELECT S.id FROM Stadium S WHERE S.name = @StadiumName);
		DELETE FROM Match WHERE Match.StadiumID = @StadiumID;
GO

--(VI)
GO

CREATE PROCEDURE addClub
		@ClubName VARCHAR(20),
		@Location VARCHAR(20)
AS
		INSERT INTO Club
		VALUES (@ClubName, @Location, NULL, NULL);

GO

--(VII)
GO
CREATE PROCEDURE addTicket
		@HostName VARCHAR(20),
		@GuestName VARCHAR(20),
		@Time datetime
AS
		DECLARE @HostID INT = (SELECT C.id FROM Club C WHERE C.name = @HostName);
		DECLARE @GuestID INT = (SELECT C.id FROM Club C WHERE C.name = @GuestName);
		DECLARE @MatchID INT = (SELECT Match.id FROM Match WHERE Match.StartTime = @Time AND Match.HostClubID = @HostID AND Match.GuestClubID = @GuestID);

		INSERT INTO Ticket
		VALUES (NULL, NULL, NULL, @MatchID);

GO

--(VIII)
GO
CREATE PROCEDURE deleteClub
		@ClubName VARCHAR(20)
AS
		DECLARE @ClubID INT = (SELECT C.id FROM Club C WHERE C.name = @ClubName);
		DECLARE @ClubRepID INT = (SELECT C.ClubRepresentativeID FROM Club C WHERE C.name = @ClubName);
		DELETE FROM Match WHERE Match.HostClubID = @ClubID OR Match.GuestClubID = @ClubID;
		DELETE FROM ClubRepresentative WHERE ClubRepresentative.id = @ClubRepID;
		DELETE FROM Club WHERE Club.name = @ClubName;
GO

--(IX)
GO

CREATE PROCEDURE addStadium
		@Name VARCHAR(20),
		@Location VARCHAR(20),
		@Cap INT
AS
		INSERT INTO Stadium
		VALUES (@Name, @Cap, @Location, NULL, NULL, NULL);

GO

--(X)
GO
CREATE PROCEDURE deleteStadium
		@Name VARCHAR(20)
AS
		DELETE FROM Stadium WHERE Stadium.name = @Name;

GO
