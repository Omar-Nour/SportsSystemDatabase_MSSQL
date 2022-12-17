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
		PhoneNo int,
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
		id int IDENTITY PRIMARY KEY,
		status VARCHAR(20) ,
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


------- FROM XXI TO XXX -------

-- XXI
CREATE PROCEDURE addFan
@name varchar(20),
@username varchar(20),
@password varchar(20),
@nid varchar(20),
@bd datetime,
@address varchar(20),
@phone_num int
AS
INSERT INTO SystemUser VALUES (@username, @password);
INSERT INTO Fan VALUES (@username, @nid, @phone_num, @address, @name, 1, @bd);
GO

-- XXII
CREATE FUNCTION [upcomingMatchesOfClub]
(@club_name varchar(20))
RETURNS TABLE AS 
	RETURN SELECT C1.name as club, C2.name as competing_club, M.StartTime , S.name as stadium_name
			FROM Club C1, Club C2, Match M, Stadium S
			WHERE C1.name = @club_name AND ((C1.id = M.HostClubID AND C2.id = M.GuestClubID) OR 
			(C2.id = M.HostClubID AND C1.id = M.GuestClubID)) AND C1.name <> C2.name AND M.StadiumID = S.id
			AND CURRENT_TIMESTAMP < M.StartTime;
GO

-- XXIII
CREATE FUNCTION [availableMatchesToAttend]
(@date datetime)
RETURNS TABLE AS 
	RETURN SELECT H.name as host, G.name as guest, M.StartTime , S.name as stadium_name
			FROM Club H, Club G, Match M, Stadium S
			WHERE M.StartTime >= @date AND (H.id = M.HostClubID AND G.id = M.GuestClubID)
			AND EXISTS (SELECT * FROM Ticket T WHERE T.MatchID = M.id AND T.status = 1);
GO

-- XXIV
CREATE PROCEDURE purchaseTicket
@host_name varchar(20),
@guest_name varchar(20),
@nid varchar(20),
@start_time datetime
AS
	DECLARE @ticket_id int;
	DECLARE @fan_user_name varchar(20);
	DECLARE @match_id int;
	SET @match_id = (SELECT M.id FROM Club H, Club G, Match M
					 WHERE H.id = M.HostClubID AND G.id = M.GuestClubID AND
					  M.StartTime = @start_time AND  H.name = @host_name
					  AND G.name = @guest_name
	);
	SET @ticket_id = (SELECT MIN(T.id) FROM Ticket T, Match M
					  WHERE M.id = T.MatchID AND T.status = 1 
	);
	SET @fan_user_name = (SELECT username FROM Fan WHERE NationalID = @nid);

	UPDATE Ticket SET FanUserName = @fan_user_name, 
				      FanNationalID = @nid,
					  status = 0
				  WHERE id = @ticket_id;
GO

-- XXV
CREATE PROCEDURE updateMatchHost
@host_name varchar(20),
@guest_name varchar(20),
@start_time datetime
AS
	DECLARE @host_id int;
	DECLARE @guest_id int;
	DECLARE @match_id int;
	SELECT @match_id = M.id, @host_id = M.HostClubID, @guest_id = M.GuestClubID 
			FROM Club H, Club G, Match M
			WHERE H.id = M.HostClubID AND G.id = M.GuestClubID AND
			M.StartTime = @start_time AND  H.name = @host_name AND 
			G.name = @guest_name;
	
	
	UPDATE Match SET HostClubID = @guest_id, 
				     GuestClubID = @host_id,
					 StadiumID = null
				  WHERE id = @match_id;
GO

-- XXVI
CREATE VIEW matchesPerTeam AS
	SELECT C.name as club_name, COUNT(M.id) as matchs_played FROM Club C, Match M
	WHERE (C.id = M.HostClubID OR C.id = M.GuestClubID) 
	AND M.EndTime <= CURRENT_TIMESTAMP
	GROUP BY C.name;
GO

-- XXVII
CREATE VIEW clubsNeverMatched AS
	SELECT C1.name as club1, C2.name as club2
	FROM Club C1, Club C2
	WHERE C1.id < C2.id 
	AND NOT EXISTS (SELECT * FROM Match M 
					WHERE  (M.HostClubID = C1.id AND M.GuestClubID = C2.id)
					OR (M.HostClubID = C2.id AND M.GuestClubID = C1.id) AND
					M.EndTime < CURRENT_TIMESTAMP
	);
GO

-- XXVIII
CREATE FUNCTION [clubsNeverPlayed]
(@club_name varchar(20))
RETURNS TABLE
AS
	RETURN (SELECT C.name FROM clubsNeverMatched V, Club C
			WHERE (C.name = V.club2 and V.club1 = @club_name)
			OR (C.name = V.club1 and V.club2 = @club_name)
	);
GO

-- XXIX
CREATE FUNCTION [matchWithHighestAttendance]()
RETURNS TABLE
AS
	RETURN (SELECT H.name as host_club, G.name as guest_club 
			FROM Match M, Club H, Club G, Ticket T
			WHERE (H.id = M.HostClubID AND G.id = M.GuestClubID)
			AND T.MatchID = M.id AND T.status = 0
			GROUP BY M.id, H.name, G.name
			HAVING COUNT(T.id) >= ALL (SELECT COUNT(T2.id)
								 FROM Ticket T2
								 WHERE T2.status = 0 
								 GROUP BY T2.MatchID)
	);
GO





----------------------------


