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
		id int IDENTITY PRIMARY KEY,
		status VARCHAR(20) check (status in ('unhandled', 'accepted', 'rejected')),
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

--EXEC createAllTables



-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--BLOCK FAN
GO
CREATE PROC BlockFan
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
