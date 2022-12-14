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
	DROP FUNCTION requestsFromClub;
	DROP FUNCTION matchesRankedByAttendance;
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
		WHERE R.id = C.ClubRepresentativeID;
			
GO

GO
--A View that returns the usernames and names
--of all Stadium Managers as well as the name of the stadium they are 
--managing
CREATE VIEW allStadiumManagers AS
	SELECT M.username AS StadManUserName,M.name AS StadManName,S.name AS StadiumName
		FROM StadiumManager AS M,Stadium AS S
		WHERE M.id = S.StadiumManagerID; 
			
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
				AND M.GuestClubID = C2.id AND C.id <> C2.id;
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

GO
---xxx
-- a function that returns a table containing the name of the hosting club 
--and the name of the guest club of all played matches 
--sorted descendingly by the total number of tickets they have sold
--input: nothing
--output: table
CREATE FUNCTION matchesRankedByAttendance
()
RETURNS TABLE
AS 
RETURN (
	SELECT TOP(100) PERCENT C.name AS HostClubName, C2.name AS GuestClubName, COUNT(T.id) AS numOfTickets
		FROM Match AS M, Ticket AS T, Club AS C, Club AS C2
		WHERE M.HostClubID = C.id 
				AND M.GuestClubID = C2.id AND C.id <> C2.id
				AND T.MatchID = M.id AND T.status = 0
		GROUP BY C.name, C2.name,M.id,M.StartTime
		ORDER BY COUNT(T.id) DESC
)
GO

GO
--xxxi
-- a function that returns a table containing the name of the hosting club 
--and the name of the competing club of all matches that are 
--requested to be hosted on the given stadium sent by the representative
--of the given club.
--input: varchar(20) representing name of a stadium, varchar(20) representing name of a club
--output: table
CREATE FUNCTION requestsFromClub
(@stadium_name VARCHAR(20),@club_name VARCHAR(20))
RETURNS TABLE
AS
RETURN (
	SELECT C.name AS HostClubName, C2.name AS GuestClubName
		FROM Club AS C, Club AS C2, 
		Stadium AS S, Match AS M, HostRequest AS HR, 
		ClubRepresentative AS CR
			WHERE M.HostClubID = C.id
			AND M.GuestClubID = C2.id AND C.id <> C2.id
			AND C.name = @club_name AND C.ClubRepresentativeID = CR.id
			AND S.id = M.StadiumID 
			AND S.name = @stadium_name 
			AND HR.MatchID = M.id AND HR.ClubRepresentativeID = CR.id
	)
GO