use charikov;

create table pripojeni(
ID int identity(1,1) primary key,
id_platform int,
FOREIGN KEY (id_platform) REFERENCES platforma(ID),
id_uzivatel int,
FOREIGN KEY (id_uzivatel) REFERENCES uzivatel(ID),
);

create table platforma(
ID int identity(1,1) primary key,
nazev varchar(20),
nickname varchar(50),
heslo varchar(50)
);


create table pocitac(
ID int identity(1,1) primary key,
CPU varchar(20) not null,
GPU varchar(20) not null,
RAM varchar(20) not null,
Memory_Bus varchar(20) not null,
Bandwidth varchar(20) not null
);


create table hra(
ID int identity(1,1) primary key,
Nazev varchar(50) not null,
Zanr varchar(50) not null,
Vyvojar varchar(50) not null,
Vydavatel varchar(50) not null,
Datum_vydani date not null,
Pocet_hracu varchar(20) not null,
Verze varchar(20) not null,
id_platform int,
FOREIGN KEY (id_platform) REFERENCES platforma(ID)
);

create table clenstvi(
ID int identity(1,1) primary key,
Nazev varchar(20) not null,
Dovoleny_cas int not null,
Cena int not null,
Kvalita_obrazku varchar(20) not null,
);

create table uzivatel(
ID int identity(1,1) primary key,
Jmeno varchar(20) not null,
Prijmeni varchar(20) not null,
Nickname varchar(50) not null,
Email varchar(50) not null,
id_member int,
FOREIGN KEY (id_member) REFERENCES clenstvi(ID)
);

create table sesion(
ID int identity(1,1) primary key,
start_time date not null,
end_time date not null,
device varchar(50) not null,
wifi_speed varchar(50) not null,
id_pc int,
FOREIGN KEY (id_pc) REFERENCES pocitac(ID),
id_hra int ,
FOREIGN KEY (id_hra) REFERENCES hra(ID),
id_uzivatel int,
FOREIGN KEY (id_uzivatel) REFERENCES uzivatel(ID)
);

-- Vkladani hodnot do tabulky hra
insert into hra(Nazev, Zanr, Vyvojar, Vydavatel, Datum_vydani, Pocet_hracu, Verze) values 
('Fortnite','Action','Epic Games','Epic Games','2017-07-25','Multiplayer', '23'),
('Apex Legends','Action','Respawn Entertaiment','Electronic Arts','2020-11-05','Multiplayer', '19'),
('Paper, Please','Adventure','3909','3909','2013-08-08','Singleplayer','8'),
('CS:GO','Action','Valve Software','Valve Software','2015-12-31','Multiplayer','38'),
('Tomb Raider','Action','Nixxes Software','Square Enix','2013-03-04','Singleplayer','4');

select * from hra;

-- Vkladani hodnot do tabulky pocitac
insert into pocitac(CPU,GPU,RAM,Memory_Bus,Bandwidth) values 
('Ryzen Threadripp Pro',' RTX 3080','32 GB','384-bit','600GB/s');

-- Vkladani hodnot do pripojeni
insert into platforma(nazev,nickname,heslo) values 
('Steam','MandrMax','sdfrgs'),
('Epic','Leonardo','sdfgera'),
('Steam','Mimik','135468'),
('Ubisoft','Jezek','df48sa'),
('Ubisoft','Jakub789','e87d9s');

select * from platforma;

--pripojeni
insert into pripojeni(id_uzivatel, id_platform) values
(1,1),(1,2),(2,3),(3,4),(4,5);


-- Vkladani hodnot do clenstvi
insert into clenstvi(Nazev,Dovoleny_cas, Cena, Kvalita_obrazku) values
('Free', 1 , '0' , '480'),
('Priority',6,'230','1080'),
('RTX 3080',8,'500','4k');

ALTER TABLE clenstvi
DROP COLUMN Datum_zacatku;

select * from clenstvi;

--Vkladani hodnot do uzivatel
insert into uzivatel(Jmeno, Prijmeni, Nickname, Email , id_member) values
('Leonid', 'Charikov', 'Leonardo', 'charikov@spsejecna.cz' , 2),
('Vlad','Gregr','Vladgrg','gregr@seznam.cz',3),
('Michal','Bartusek','Mimikil','bartusek@seznam.cz', 4),
('Jirka', 'Jezil', 'Jezek', 'jezil@spsejecna.cz' , 2);

select * from uzivatel;

-- Vkladani hodnot do sesion
insert into sesion(start_time,end_time,device,wifi_speed,id_pc, id_hra,id_uzivatel) values
('2022-12-30','2022-12-30','PC Chrome','50 Mb/s',3, 5, 1),
('2022-12-26','2022-12-27',' Mobile Iphone','10 Mb/s',3, 7 , 1),
('2022-12-03','2022-12-03',' TV','25 Mb/s',3, 6, 3),
('2022-11-29','2022-11-29','Mac','60 Mb/s',3, 6, 4);
select * from sesion;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Vytvareni Indexu HRAC a Proces
create index HRAC
on uzivatel (ID, Nickname , Email, id_member);

create index Proces
on sesion(ID ,id_uzivatel, id_pc, id_hra, start_time, device);

SELECT * FROM uzivatel WITH(INDEX(HRAC));

SELECT * FROM sesion WITH(INDEX(Proces));


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Transakce 
-- 1) Nejprve zkusime udelal zalohu transakce 
Begin TRANSACTION;
-- Vkladani hodnoty do hra a ukladani tyhle transakce jako firstsave
insert into hra(Nazev, Zanr, Vyvojar, Vydavatel, Datum_vydani, Pocet_hracu, Verze)
Values ('Portal 2','Adventure','Valve Software', 'Valve Software', '2011-04-18', 'Singleplayer', '5')
SAVE TRANSACTION firstsave;
COMMIT;

-- Mazani hru Portal 2 a ukladame transakci jako secondsave;
Begin TRANSACTION;
delete from hra where Nazev = 'Portal 2';
SAVE TRANSACTION secondsave;
COMMIT;

select * from hra;

if @@TRANCOUNT > 0
-- Vracime zpet ulozenou transakci firstsave
rollback transaction firstsave;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Procedury
-- 1. procedura
CREATE PROCEDURE VyberHry ( @Zanr nvarchar(30) and @Pocet_hracu nvarchar(30) )
AS
select * from hra 
where Zanr = @Zanr AND Pocet_hracu = @Pocet_hracu;

-- 2. procedura
CREATE PROCEDURE ZanrHer @Zanr nvarchar(30)
AS
SELECT * FROM hra 
WHERE Zanr = @Zanr;


exec VyberHry @Zanr = 'Action', @Pocet_hracu = 'Multiplayer';
exec ZanrHer @Zanr = 'Adventure';

-- 3. procedura
create procedure Zaznam
AS
select sesion.start_time , uzivatel.Nickname , hra.Nazev 
From sesion, uzivatel, hra
WHERE uzivatel.ID = id_uzivatel and hra.ID = id_hra and sesion.start_time <= GETDATE()
order by start_time;

exec Zaznam;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- View
--1. 
CREATE VIEW MemberFree
AS
SELECT Nazev, uzivatel.Nickname
FROM clenstvi, uzivatel
WHERE Nazev = 'Free' and clenstvi.ID = id_member;

select * from MemberFree;

--2. 
create view VypisSesion
as
select sesion.start_time, sesion.end_time , sesion.id_pc, uzivatel.Nickname,hra.Nazev, hra.Zanr, hra.Pocet_hracu, clenstvi.ID, clenstvi.Dovoleny_cas
from sesion, uzivatel, clenstvi, hra 
where clenstvi.ID = id_member and uzivatel.ID = id_uzivatel and hra.ID = id_hra;

select * from VypisSesion;

--3
create view uzivatelConn
as
select uzivatel.ID, uzivatel.Jmeno, uzivatel.Prijmeni, uzivatel.Email, platforma.nazev, platforma.nickname
from uzivatel, platforma, pripojeni
where platforma.ID = id_platform and uzivatel.ID = id_uzivatel;

select * from uzivatelConn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Trigger

--1. 
CREATE TRIGGER verzehry
ON hra
AFTER INSERT, UPDATE
AS
UPDATE hra
SET Verze = Verze + 1
from hra;

select * from hra;

--2. 
CREATE TRIGGER delbackup_trigger
ON hra
AFTER DELETE
AS
   -- Vytvoøení zálohy celé databáze
   BACKUP DATABASE charikov TO DISK = 'C:Cloud Gaming DS\config\diff_backup.bak'
   with differential = 'diffbackup';


CREATE TRIGGER newbackup_trigger
ON hra
AFTER insert
AS
   -- Vytvoøení zálohy celé databáze
   BACKUP DATABASE charikov TO DISK = 'C:Cloud Gaming DS\config\diff_backup.bak'
   with differential = 'diffbackup';
 


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Zaloha
-- fullbackup 
BACKUP DATABASE charikov 
TO DISK='C:\Users\Desktop\Cloud Gaming DS\config\charikov.bak'
with name = 'fullbackup';
GO

-- differential 
BACKUP DATABASE charikov 
TO DISK='C:\Users\Desktop\Cloud Gaming DS\config\diff_backup.bak'
with differential = 'diffbackup';
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Role


CREATE LOGIN Leo WITH PASSWORD = '489789';
CREATE USER Leo FOR LOGIN Leo;
ALTER ROLE db_owner ADD MEMBER Leo;

CREATE LOGIN John WITH PASSWORD = '12345';
CREATE USER John FOR LOGIN John;
ALTER ROLE db_accessadmin ADD MEMBER John;

CREATE LOGIN Ema WITH PASSWORD = '78478';
CREATE USER Ema FOR LOGIN Ema;
ALTER ROLE db_datareader ADD MEMBER Ema;

CREATE LOGIN Kris WITH PASSWORD = '97497';
CREATE USER Kris FOR LOGIN Kris;
ALTER ROLE db_datawriter ADD MEMBER Kris;
