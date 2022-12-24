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
		FOREIGN KEY (StadiumManagerID) REFERENCES StadiumManager(id) ON DELETE CASCADE
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
		StadiumID int REFERENCES Stadium ON DELETE CASCADE,
		HostClubID int FOREIGN KEY REFERENCES Club,
		GuestClubID int FOREIGN KEY REFERENCES Club
	);

	CREATE TABLE Ticket(
		id int IDENTITY PRIMARY KEY,
		status bit,
		FanUserName VARCHAR(20), 
		FanNationalID VARCHAR(20), 
		MatchID int FOREIGN KEY REFERENCES Match ON DELETE CASCADE,
		FOREIGN KEY (FanNationalID) 
			REFERENCES Fan(NationalID)
	);

	CREATE TABLE HostRequest(
		id int IDENTITY PRIMARY KEY,
		MatchID int FOREIGN KEY REFERENCES Match ON DELETE CASCADE,
		status VARCHAR(20) check (status in ('unhandled', 'accepted', 'rejected')),
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
	DROP PROCEDURE addAssociationManager;
	DROP PROCEDURE addNewMatch;
	DROP PROCEDURE deleteMatch;
	DROP PROCEDURE deleteMatchesOnStadium;
	DROP PROCEDURE addClub;
	DROP PROCEDURE addTicket;
	DROP PROCEDURE deleteClub;
	DROP PROCEDURE addStadium;
	DROP PROCEDURE deleteStadium;
	DROP PROCEDURE blockFan;
	DROP PROCEDURE unblockFan;
	DROP PROCEDURE addRepresentative;
	DROP PROCEDURE addHostRequest;
	DROP PROCEDURE addStadiumManager;
	DROP PROCEDURE acceptRequest;
	DROP PROCEDURE rejectRequest;
	DROP PROCEDURE addFan;
	DROP PROCEDURE purchaseTicket;
	DROP PROCEDURE updateMatchHost;

	DROP VIEW allAssocManagers;
	DROP VIEW allClubRepresentatives;
	DROP VIEW allStadiumManagers;
	DROP VIEW allFans;
	DROP VIEW allMatches;
	DROP VIEW allTickets;
	DROP VIEW allClubs;
	DROP VIEW allStadiums;
	DROP VIEW allRequests;
	DROP VIEW clubsWithNoMatches;
	DROP VIEW matchesPerTeam;
	DROP VIEW clubsNeverMatched;

	DROP FUNCTION requestsFromClub;
	DROP FUNCTION matchesRankedByAttendance;
	DROP FUNCTION viewAvailableStadiumsOn;
	DROP FUNCTION allUnassignedMatches;
	DROP FUNCTION allPendingRequests;
	DROP FUNCTION upcomingMatchesOfClub;
	DROP FUNCTION availableMatchesToAttend;
	DROP FUNCTION clubsNeverPlayed;
	DROP FUNCTION matchWithHighestAttendance;
	--Add as you go: DONE
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
	VALUES (@Username, @name);
	
GO

--(II)
GO
CREATE PROCEDURE addNewMatch
		@HostName VARCHAR(20),
		@GuestName VARCHAR(20),
		@StartTime datetime,
		@EndTime datetime

	AS

		DECLARE @HostID INT;
		DECLARE @GuestID INT;

		SELECT @HostID = C1.id, @GuestID = C2.id FROM Club C1, Club C2 WHERE C1.name = @HostName  AND C2.name = @GuestName;


		INSERT INTO Match
		VALUES (@StartTime, @EndTime, NULL, @HostID, @GuestID);

GO


--(III)
GO 

CREATE VIEW clubsWithNoMatches
AS

SELECT C.name
FROM Club C

WHERE C.id NOT IN (SELECT HostClubID
				   FROM Match M
						)					
		AND
		
		C.id NOT IN (SELECT GuestClubID
					 FROM Match M
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
DECLARE @Match_id INT = (SELECT M.id FROM Match M WHERE M.HostClubID = @Host_id AND M.GuestClubID = @Guest_id);


DELETE FROM Match  
WHERE Match.HostClubID = @Host_id AND Match.GuestClubID = @Guest_id;

DELETE FROM Ticket
WHERE Ticket.MatchID = @Match_id;

GO

--(V)
GO

CREATE PROCEDURE deleteMatchesOnStadium
		@StadiumName VARCHAR(20)
AS
DECLARE @StadiumID INT = (SELECT S.id FROM Stadium S WHERE S.name = @StadiumName);
--DECLARE @MatchID INT = (SELECT M.id FROM Match M WHERE M.StadiumID = @StadiumID);

DELETE FROM Match WHERE Match.id IN (SELECT M.id FROM Match M WHERE M.StadiumID = @StadiumID AND M.StartTime > CURRENT_TIMESTAMP);

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
VALUES (1, NULL, NULL, @MatchID);

GO


--(VIII)
GO
CREATE PROCEDURE deleteClub
		@ClubName VARCHAR(20)
AS
DECLARE @ClubID INT = (SELECT C.id FROM Club C WHERE C.name = @ClubName);

DELETE FROM Match WHERE (Match.HostClubID = @ClubID OR Match.GuestClubID = @ClubID) AND Match.StartTime > CURRENT_TIMESTAMP;
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
VALUES (@Name, @Cap, @Location, 1, NULL, NULL);

GO


--(X)
GO
CREATE PROCEDURE deleteStadium
		@Name VARCHAR(20)
AS

DECLARE @username VARCHAR(20);
DECLARE @stadiumID int;
SELECT @username = SM.username, @stadiumID = S.id FROM Stadium S, StadiumManager SM
WHERE S.name = @Name AND S.StadiumManagerID = SM.id;

UPDATE Match SET StadiumID = null
WHERE StadiumID = @stadiumID AND StartTime > CURRENT_TIMESTAMP;

DELETE FROM Stadium WHERE Stadium.name = @Name;
DELETE FROM StadiumManager WHERE username = @username;
DELETE FROM SystemUser WHERE username = @username;

GO

--EXEC createAllTables



-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--BLOCK FAN
GO
CREATE PROC blockFan
@NatId VARCHAR(20)
AS
UPDATE Fan
SET status=0
WHERE @NatId= Fan.NationalID

GO
--INSERT INTO Fan VALUES('ADHFJADSF','123','1232','DSFA','FDS',1,'10/24/2001')
--INSERT INTO SystemUser VALUES('ADHFJADSF','ASFF')

--EXEC unblockFan '123'

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UNBLOCK FAN
GO
CREATE PROC unblockFan
@NatId VARCHAR(20)
AS
UPDATE Fan
SET status=1
WHERE @NatId= Fan.NationalID

--INSERT INTO Fan VALUES('ADHFJADSF','123','1232','DSFA','FDS',1,'10/24/2001')
--INSERT INTO SystemUser VALUES('ADHFJADSF','ASFF')
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ADD CLUB REPRESENTATIVE DONE

GO
CREATE PROC addRepresentative
@Name VARCHAR(20),
@ClubName VARCHAR(20),
@Username VARCHAR(20),
@Password VARCHAR(20)



AS
INSERT INTO SystemUser VALUES(@Username ,@Password)
--SET IDENTITY_INSERT ClubRepresentative ON
INSERT INTO ClubRepresentative(username,name)
VALUES(@Username,@Name)

DECLARE @ID VARCHAR(20)
SELECT @ID=CR.id
FROM ClubRepresentative CR
WHERE CR.username=@Username


UPDATE Club
SET ClubRepresentativeUserName= @Name, ClubRepresentativeID = @ID

WHERE Club.name = @ClubName 
--EXEC addRepresentative 'MOH','DD','MOH1','12345'


--DROP PROC addRepresentative
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
--ADDHOST REQUEST
---HOST REQUEST ID IS INT NOT IDENTITY?????
CREATE PROC addHostRequest
@clubname VARCHAR(20),
@stadname VARCHAR(20),
@date DATETIME

AS
DECLARE @repid varchar(20)
SELECT @repid=C.ClubRepresentativeID
FROM Club C
WHERE C.name=@clubname

DECLARE @repUSER varchar(20)
SELECT @repUSER=C.ClubRepresentativeUserName
FROM Club C
WHERE C.name=@clubname

DECLARE @SMID VARCHAR(20)
SELECT @SMID=S.StadiumManagerID
FROM Stadium S
WHERE @stadname=S.name

DECLARE @SMUSERNAME VARCHAR(20)
SELECT @SMUSERNAME=S.StadiumManagerUserName
FROM Stadium S
WHERE S.name=@stadname

DECLARE @MATCHid varchar(20)
SELECT @MATCHid=M.id
FROM Match M 
WHERE M.StartTime = @date


INSERT INTO HostRequest (status,MatchID,ClubRepresentativeID,StadiumManagerID,StadiumManagerUserName,ClubRepresentativeUserName)
VALUES('unhandled',@MATCHid,@repid,@SMID,@SMUSERNAME,@repUSER);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--EXEC addHostRequest 'DD','EMIRATES','2022-04-22 10:34:23'
--DROP PROC addHostRequest

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--ADD STADUIM MANAGER DONE

GO
CREATE PROC addStadiumManager
@name VARCHAR(20),
@stadiumname VARCHAR(20),
@Username VARCHAR(20),
@Password VARCHAR(20)

AS 
INSERT INTO SystemUser VALUES(@Username ,@Password)

INSERT INTO StadiumManager(username,name)
VALUES(@Username,@Name)

DECLARE @ID VARCHAR(20)
SELECT @ID=SM.id
FROM StadiumManager SM
WHERE @Username=SM.username

UPDATE Stadium
SET StadiumManagerUserName= @Name, StadiumManagerID = @ID

WHERE Stadium.name = @stadiumname
------------------------------
--EXEC addStadiumManager 'Ahmed','EMIRATES','Ahmed1','1EW'

--DROP PROC addStadiumManager
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--ACCEPT REQUEST
-- null to be handeled correct logic
GO
CREATE PROC acceptRequest
@usernamestadman VARCHAR(20),
@hostclub VARCHAR(20),
@GUESTCLUB VARCHAR(20),
@starttime DATETIME

AS
DECLARE @MANAGERID VARCHAR(20)
SELECT @MANAGERID=SM.id
FROM StadiumManager SM
WHERE SM.username=@usernamestadman

DECLARE @HOST VARCHAR(20) 
DECLARE @GUEST VARCHAR(20)

DECLARE @MATCHID VARCHAR(20)

SELECT @HOST=C.id , @GUEST=C.id
FROM CLUB C
WHERE @hostclub=C.name AND @GUESTCLUB=C.name

SELECT @MATCHID= M.id
FROM Match M
WHERE M.HostClubID=@HOST AND M.GuestClubID=@GUEST AND M.StartTime=@starttime

UPDATE HostRequest
SET status='accepted'
WHERE HostRequest.MatchID=@MATCHID AND HostRequest.StadiumManagerID=@MANAGERID;

DECLARE @capacity int;
SELECT @capacity = S.capacity FROM Stadium S, StadiumManager SM
WHERE S.StadiumManagerID = SM.id AND SM.username = @usernamestadman;

DECLARE @i int = 1;
while (@i <= @capacity) 
begin
	exec addTicket @hostclub, @GUESTCLUB, @starttime;
	SET @i = @i + 1;
end
GO

--EXEC acceptRequest 'AHMED1','DD','2EW3A', '2022-04-22 10:34:23.000'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--GO
--CREATE PROC ACCEPTREQ2
--@usernamestadman varchar(20),
--@hostclub VARCHAR(20),
--@GUESTCLUB VARCHAR(20),
--@starttime date

--AS
--DECLARE @HOSTID VARCHAR(20)
--SELECT @HOSTID = C.id
--FROM Club C
--WHERE C.name=@hostclub


--DECLARE @GUESTID VARCHAR(20)
--SELECT @GUESTID = C.id
--FROM CLUB C
--WHERE C.NAME= @GUESTCLUB


--DECLARE @MATCHID VARCHAR(20)
--SELECT @MATCHID= M.id
--FROM MATCH M
--WHERE @HOSTID=M.HostClubID AND @GUESTID=M.GuestClubID AND M.StartTime=@starttime

--UPDATE HostRequest
--SET status=1
--WHERE HostRequest.MatchID=@MATCHID AND HostRequest.StadiumManagerUserName=@usernamestadman


--REJECT REQUEST
-- null to be handeled correct logic

GO
CREATE PROC rejectRequest
@usernamestadman varchar(20),
@hostclub VARCHAR(20),
@GUESTCLUB VARCHAR(20),
@starttime datetime

AS
DECLARE @MANAGERID VARCHAR(20)
SELECT @MANAGERID=SM.id
FROM StadiumManager SM
WHERE SM.username=@usernamestadman

DECLARE @HOST VARCHAR(20) 
DECLARE @GUEST VARCHAR(20)
DECLARE @MATCHID VARCHAR(20)

SELECT @HOST=C.id , @GUEST=C.id
FROM CLUB C
WHERE @hostclub=C.name AND @GUESTCLUB=C.name

SELECT @MATCHID= M.id
FROM Match M
WHERE M.HostClubID=@HOST AND M.GuestClubID=@GUEST AND M.StartTime=@starttime

UPDATE HostRequest
SET status='rejected'
WHERE HostRequest.MatchID=@MATCHID AND HostRequest.StadiumManagerID=@MANAGERID 
GO
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--EXEC acceptRequest'AHMED1','2EW3A','DD','2022-04-22 10:34:23'


--TRASH-----------------------------------------------------------------------------------------------------------------------------------------------------------

--EXEC addRepresentative 'SDbgAF','2EW3A','Al222aAa','FF','323'

--INSERT INTO SystemUser VALUES('Ahmed1','1EW')
--INSERT INTO StadiumManager(name,username)
--VALUES('Ahmed','Ahmed1')
--INSERT INTO Match(StartTime,EndTime,HostClubID,GuestClubID,StadiumID)
--VALUES('2022-04-22 10:34:23','2022-04-22 11:34:23' ,6,3,1)

--INSERT INTO HostRequest(ID,ClubRepresentativeID,StadiumManagerID,MatchID,StadiumManagerUserName,ClubRepresentativeUserName)
--VALUES(23,324,1,1,'AHMED1','MOH1')

--INSERT INTO Stadium( name, location, capacity,status)
--VALUES('EMIRATES','LONDON',2000,1)
--SET IDENTITY_INSERT ClubRepresentative ON
--INSERT INTO ClubRepresentative(id,username,name)
--VALUES(2,'SAFDF','FF')
--SET IDENTITY_INSERT Club OFF
--INSERT INTO Club(name,location,ClubRepresentativeID,ClubRepresentativeUserName)
--VALUES('2EW3A','WA7WA7',1,'SAFDF')
-----------------------------------------------------------------------------------------------------------------------------------------------------------------



--SELECT* -------------------------------------------------------------------------------------------------------------------------------------------------------

--SELECT * 
--FROM StadiumManager
--SELECT * 
--FROM ClubRepresentative
--SELECT * 
--FROM SystemUser
--SELECT * 
--FROM Club
--SELECT *
--FROM Stadium
--SELECT *
--FROM Match
--SELECT * 
--FROM HostRequest
---------------------------------------------------------------------------------------------------------------------------------------------------------------

--- VIEW AVAILABELE STADUIM THAT AVAIALABLE FOR RESERVATION AND NOT ALREADY HOSTING A MATCH AT THE START TIME--------------------------------------------------
GO
CREATE FUNCTION viewAvailableStadiumsOn
(@starttime DATETIME)
RETURNS TABLE  
AS  
RETURN  
    SELECT S.name , S.location , S.capacity
	FROM Stadium S , Match M
	WHERE S.status= 1 AND S.id  != M.StadiumID OR  S.id=M.StadiumID AND M.StartTime!=@starttime




GO 
-- DROP FUNCTION viewAvailableStadiumsOn
-- SELECT * FROM  DBO.viewAvailableStadiumsOn ('2022-04-22 11:34:23')


-----ALL UNASSIGNED MATCHES-------------------------------------------------------------------------------------------------------------------------------------
GO
CREATE FUNCTION allUnassignedMatches
(@CLUBHOST VARCHAR(20))


RETURNS @unassigned TABLE (guest_club VARCHAR(20) , starttime DATETIME)
AS 
BEGIN
DECLARE @HOSTCLUBID VARCHAR(20)
SELECT @HOSTCLUBID=C.id
FROM CLUB C
WHERE @CLUBHOST=C.name

DECLARE @GUESTCLUBID VARCHAR(20)
DECLARE @STARTTIME DATETIME

SELECT @GUESTCLUBID= M.GuestClubID , @STARTTIME= M.StartTime
FROM Match M
WHERE M.HostClubID= @HOSTCLUBID AND M.StadiumID IS NULL

DECLARE @GUESTCLUBNAME VARCHAR(20)
SELECT @GUESTCLUBNAME=C.name
FROM CLUB C
WHERE C.id=@GUESTCLUBID

INSERT INTO @unassigned VALUES (@GUESTCLUBNAME,@STARTTIME)


RETURN;
END;
GO

--SELECT * FROM  DBO.allUnassignedMatches ('2EW3A')

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
------ PENDING REQUEST DONE
GO
CREATE FUNCTION allPendingRequests
(@STDUSERNAME VARCHAR(20))

RETURNS @unassigned TABLE (CRNAME VARCHAR(20) ,GUESTNAME VARCHAR(20), starttime DATETIME)
AS 
BEGIN

DECLARE @CRID VARCHAR(20)
DECLARE @MATCHID VARCHAR(20)

SELECT @CRID= H.ClubRepresentativeID, @MATCHID= H.MatchID
FROM HostRequest H
WHERE H.StadiumManagerUserName = @STDUSERNAME AND H.status = 'unhandled'

DECLARE @CRNAME VARCHAR(20)
SELECT @CRNAME = CR.name
FROM ClubRepresentative CR
WHERE @CRID=CR.id


DECLARE @GUESTID VARCHAR(20)
DECLARE @STARTTIME DATETIME

SELECT @GUESTID=M.GuestClubID , @STARTTIME = M.StartTime
FROM MATCH M
WHERE @MATCHID=M.id

DECLARE @GUESTNAME VARCHAR(20)
SELECT @GUESTNAME=C.name
FROM Club C
WHERE @GUESTID=C.id


INSERT INTO @unassigned VALUES (@CRNAME,@GUESTNAME,@STARTTIME)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------


RETURN;
END;
GO

-- DROP FUNCTION allPendingRequests
--SELECT * FROM  DBO.allPendingRequests('Ahmed1')



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





----------------------------
GO
-- Login Procedure
CREATE PROCEDURE login 
@username VARCHAR(20),
@password VARCHAR(20),
@success bit output,
@user_type VARCHAR(20) output
AS 
	if EXISTS (SELECT * FROM SystemUser WHERE username = @username
		AND password = @password)
	begin
		if EXISTS (SELECT * FROM Fan WHERE username = @username)
		begin 
			SET @success = 1;
			SET @user_type = 'fan';
		end
		else if EXISTS (SELECT * FROM StadiumManager WHERE username = @username)
		begin 
			SET @success = 1;
			SET @user_type = 'stadman';
		end
		else if EXISTS (SELECT * FROM ClubRepresentative WHERE username = @username)
		begin 
			SET @success = 1;
			SET @user_type = 'clubrep';
		end
		else if EXISTS (SELECT * FROM SportsAssociationManager WHERE username = @username)
		begin 
			SET @success = 1;
			SET @user_type = 'sam';
		end
		else if EXISTS (SELECT * FROM SystemAdmin WHERE username = @username)
		begin 
			SET @success = 1;
			SET @user_type = 'admin';
		end
	end
	else
	begin
		SET @success = 0;
		SET @user_type = 'fail';
	end
	--print @success 
	--print @user_type
GO

CREATE PROCEDURE checkUsername
@username VARCHAR(20),
@success bit OUTPUT
AS
begin
 IF (@username IN (SELECT username FROM SystemUser))
	SET @success = 1;
 ELSE
	SET @success = 0;
end
GO

CREATE PROCEDURE checkStadExists
@stadname VARCHAR(20),
@success bit OUTPUT
AS
begin
 IF (@stadname IN (SELECT name FROM Stadium))
	SET @success = 1;
 ELSE
	SET @success = 0;
end
GO
CREATE PROCEDURE checkNidExists
@nid VARCHAR(20),
@success bit OUTPUT
AS
begin
 IF (@nid IN (SELECT NationalID FROM Fan))
	SET @success = 1;
 ELSE
	SET @success = 0;
end
GO
--EXEC addAssociationManager 'a','abc','123'; 
--DROP PROCEDURE checkUsername;
--SELECT * FROM SystemUser;
--SELECT * FROM Fan
--DECLARE @success bit;
--exec checkUsername 'abce', @success;


--exec login 'abc', '123', 1, 'a';