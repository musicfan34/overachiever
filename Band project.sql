SET SQL_SAFE_UPDATES = 0

select * from album
-- part 1
-- question 1 write a query that shows bands and thier respective albums' release date in decending order
select idband, albumname, releasedate
from album 
order by releasedate desc


-- question 2 write a query that shows all of the players that utilize drums along with the bands that they 
-- are a part of. you should only have one columm that shows the full player name (i.e., the player first and lastname should not be split into two columns 

 select concat(pfname, '', plname) as 'name' , bandname, instid
 from player p join band b
 on b.idband = p.idband
 where instid = 4
 
 -- question 3 Write a query that describes the number of instruments used by each band (hint: some bands have multiple players using the same instrument.)
 
 select distinct instid, bandname
 from player p join band b
 on b.idband = p.idband
 where instid
 
 -- question 4 write a query that lists the most popular instrument amongst the players.
 
 select instrument.instrument, count(player.instid)
 from instrument 
 inner join player on instrument.instid = player.instid
 group by instrument
 
 -- question 5 write a query that lists any albums that have a missing and/or missing release dates.
 
  SELECT albumname, releasedate
from album
where album.albumname is null or album.releasedate is null

-- Part 2

-- question 1 we need to add more band to the band table here is a list of the bands we like to add.
select * from band 

insert into band (idband, aid, bandname) value ('22', '1', 'weezer')
insert into band (idband, aid, bandname) value ('23','1', 'TLC')
insert into band (idband, aid, bandname) value ('24', '1', 'paramore')
insert into band (idband, aid, bandname) value ('25','1', 'blackpink')
insert into band (idband, aid, bandname) value ('26', '1', 'vampire weekend')

-- question 2 Now that we have added more bands, we need to ensure that we add the band members to 
-- the appropiate table. which table would we use to add the names of band members? 

select * from band

-- question 3 using the tbale you identified in task 2, add the followiung vaules 

INSERT INTO PLAYER(IDPLAYER,INSTID,IDBAND,PFNAME,PLNAME,HOMECITY,HOMESTATE)
		VALUES(30,3,22,'RIVERS','CUOMO','ROCHESTER','NEW YORK'),
			  (31,1,22,'BRIAN','BELL','IOWA CITY','IOWA'),
              (32,4,22,'PATRICK','WILSON','BUFFALO','NEW YORK'),
              (33,2,22,'SCOTT','SHRINER','TOLEDO','OHIO'),
              (34,3,23,'TIONNE','WATKINS','DES MOINES','IOWA'),
              (35,3,23,'ROZONDA','THOMAS','COLUMBUS','GEORGIA'),
			  (36,3,24,'HAYLEY','WILLIAMS','FRANKLIN','TENNESSEE'),
			  (37,1,24,'TAYLOR','YORK','NASHVILLE','TENNESSEE'),
			  (38,4,24,'ZAC','FARRO','VORHEES TOWNSHIP','NEW JERSEY'),
			  (39,3,25,'JISOO','KIM','','SOUTH KOREA'),
              (40,3,25,'JENNIE','KIM','','SOUTH KOREA'),
              (41,3,25,'ROSEANNE','PARK','','NEW ZEALAND'),
              (42,3,25,'LISA','MANOBAN','','THAILAND'),
              (43,3,26,'EZRA','KOENIG','NEW YORK','NEW YORK'),
              (44,2,26,'CHRIS','BAIO','BRONXVILLE','NEW YORK'),
              (45,4,26,'CHRIS','TOMSON','UPPER FREEHOLD TOWNSHIP','NEW JERSEY')
              
              select * from venue 
              
-- question 4 drop table records has signed a contract with a new venue! A new venue should be added to the venue table.

iNSERT INTO venue(idvenue, vname, city, state, zipcode, seats)
		values(12, 'Twin City Rock House', 'Minneapolis', 'MN', 55414, 2000);
        
-- question 5 which state has the largest amount of seating available ( regardless of number of venues at the state) hint: we are trying to determine the total number of seats for each state

SELECT STATE, SUM(SEATS) 'TOTAL SEATS'
FROM VENUE
GROUP BY STATE
ORDER BY STATE DESC;
        
-- Part 3 

-- Question 1 we need to add some data on upcoming performances for some of the artist. which table should we use to add this infomation.

select * from gig

-- question 2 using the table you mentioned in task 1 add the following infomation

insert into gig(GigID, idvenue, idband, gigdate, numattendees)
	values(1,4,2,'2022-05-05',1900),
    (2,12,26,'2022-04-15',null),
    (3,8,23,'2022-06-07',18000),
    (4,2,22,'2022-07-03',175)
    
-- question 3 are any of these venues oversold?

SELECT vname, SUM(V.SEATS), SUM(G.numattendees)
    FROM venue V
    INNER JOIN gig G
    ON V.idvenue = G.idvenue
    GROUP BY vname

-- question 4 we just got word that vampire weekend can expect 1,750 guests. write a query to update the table accordingly.

UPDATE GIG
    SET numattendees = 1750
    WHERE GigID = 2
    
SELECT *FROM GIg

-- question 5 we just got an update that the expected number of attendees at the river club for weezer will only have 125 guets. write a query to update the table accordly 
update gig
set numattendees = 125
where gigid = 2

-- question 6 create a view (called w_giginfo) that will show the band, the dates they will play, the venue they will play at , the number of attendees, and the venue capacity.
-- for this view, also create columm that describes what percentage of the venue capacity was utilized 

Create view vw_giginfo as
select band.bandname, gig.gigdate, gig.idvenue, gig.numattendees, venue.seats, gig.numattendees / venue.seats * 100 as '% capacity utilized' from gig
join venue on venue.idvenue = gig.idvenue
join band on gig.idband = band.idband;



-- Part 4

-- question 1 create a stored procedure that lists all of the venues that can handle more than 10,000 guest

DELIMITER $
CREATE PROCEDURE sp_bigvenue()
BEGIN
	SELECT VNAME, SEATS
	FROM VENUE WHERE SEATS > 10000;
END $

CALL sp_bigvenue()



-- question 2 create a stored procedure that lists all of the players that come from a specific state. We want to see ( once we run this stored procedure), what bands they are a part of, thier 
-- full name (in one columm), and the state they are from.

DELIMITER $
CREATE PROCEDURE sp_state 
BEGIN
	SELECT concat(pfname,'',plname) as name, homestate , homecity, idband
	FROM player 
END $



select * from player 