USE [master]
GO
/****** Object:  Database [charikov]    Script Date: 06.01.2023 20:43:28 ******/
CREATE DATABASE [charikov]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'charikov', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS2019\MSSQL\DATA\charikov.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'charikov_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS2019\MSSQL\DATA\charikov_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [charikov] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [charikov].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [charikov] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [charikov] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [charikov] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [charikov] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [charikov] SET ARITHABORT OFF 
GO
ALTER DATABASE [charikov] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [charikov] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [charikov] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [charikov] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [charikov] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [charikov] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [charikov] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [charikov] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [charikov] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [charikov] SET  ENABLE_BROKER 
GO
ALTER DATABASE [charikov] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [charikov] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [charikov] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [charikov] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [charikov] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [charikov] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [charikov] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [charikov] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [charikov] SET  MULTI_USER 
GO
ALTER DATABASE [charikov] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [charikov] SET DB_CHAINING OFF 
GO
ALTER DATABASE [charikov] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [charikov] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [charikov] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [charikov] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [charikov] SET QUERY_STORE = OFF
GO
USE [charikov]
GO
/****** Object:  Table [dbo].[platforma]    Script Date: 06.01.2023 20:43:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[platforma](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[nazev] [varchar](20) NULL,
	[nickname] [varchar](50) NULL,
	[heslo] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pripojeni]    Script Date: 06.01.2023 20:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pripojeni](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[id_platform] [int] NULL,
	[id_uzivatel] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[uzivatel]    Script Date: 06.01.2023 20:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[uzivatel](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Jmeno] [varchar](20) NOT NULL,
	[Prijmeni] [varchar](20) NOT NULL,
	[Nickname] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[id_member] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[uzivatelConn]    Script Date: 06.01.2023 20:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[uzivatelConn]
as
select uzivatel.ID, uzivatel.Jmeno, uzivatel.Prijmeni, uzivatel.Email, platforma.nazev, platforma.nickname
from uzivatel, platforma, pripojeni
where platforma.ID = id_platform and uzivatel.ID = id_uzivatel;
GO
/****** Object:  Table [dbo].[sesion]    Script Date: 06.01.2023 20:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sesion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[start_time] [date] NOT NULL,
	[end_time] [date] NOT NULL,
	[device] [varchar](50) NOT NULL,
	[wifi_speed] [varchar](50) NOT NULL,
	[id_pc] [int] NULL,
	[id_hra] [int] NULL,
	[id_uzivatel] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hra]    Script Date: 06.01.2023 20:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hra](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nazev] [varchar](50) NOT NULL,
	[Zanr] [varchar](50) NOT NULL,
	[Vyvojar] [varchar](50) NOT NULL,
	[Vydavatel] [varchar](50) NOT NULL,
	[Datum_vydani] [date] NOT NULL,
	[Pocet_hracu] [varchar](20) NOT NULL,
	[Verze] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[clenstvi]    Script Date: 06.01.2023 20:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clenstvi](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nazev] [varchar](20) NOT NULL,
	[Dovoleny_cas] [int] NOT NULL,
	[Cena] [int] NOT NULL,
	[Kvalita_obrazku] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VypisSesion]    Script Date: 06.01.2023 20:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[VypisSesion]
as
select sesion.start_time, sesion.end_time , sesion.id_pc, uzivatel.Nickname,hra.Nazev, hra.Zanr, hra.Pocet_hracu, clenstvi.ID, clenstvi.Dovoleny_cas
from sesion, uzivatel, clenstvi, hra 
where clenstvi.ID = id_member and uzivatel.ID = id_uzivatel and hra.ID = id_hra;
GO
/****** Object:  View [dbo].[MemberFree]    Script Date: 06.01.2023 20:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MemberFree]
AS
SELECT Nazev, uzivatel.Nickname
FROM clenstvi, uzivatel
WHERE Nazev = 'Free' and clenstvi.ID = id_member;
GO
/****** Object:  Table [dbo].[pocitac]    Script Date: 06.01.2023 20:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pocitac](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CPU] [varchar](20) NOT NULL,
	[GPU] [varchar](20) NOT NULL,
	[RAM] [varchar](20) NOT NULL,
	[Memory_Bus] [varchar](20) NOT NULL,
	[Bandwidth] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Proces]    Script Date: 06.01.2023 20:43:30 ******/
CREATE NONCLUSTERED INDEX [Proces] ON [dbo].[sesion]
(
	[ID] ASC,
	[id_uzivatel] ASC,
	[id_pc] ASC,
	[id_hra] ASC,
	[start_time] ASC,
	[device] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [HRAC]    Script Date: 06.01.2023 20:43:30 ******/
CREATE NONCLUSTERED INDEX [HRAC] ON [dbo].[uzivatel]
(
	[ID] ASC,
	[Nickname] ASC,
	[Email] ASC,
	[id_member] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[pripojeni]  WITH CHECK ADD FOREIGN KEY([id_platform])
REFERENCES [dbo].[platforma] ([ID])
GO
ALTER TABLE [dbo].[pripojeni]  WITH CHECK ADD FOREIGN KEY([id_uzivatel])
REFERENCES [dbo].[uzivatel] ([ID])
GO
ALTER TABLE [dbo].[sesion]  WITH CHECK ADD FOREIGN KEY([id_hra])
REFERENCES [dbo].[hra] ([ID])
GO
ALTER TABLE [dbo].[sesion]  WITH CHECK ADD FOREIGN KEY([id_pc])
REFERENCES [dbo].[pocitac] ([ID])
GO
ALTER TABLE [dbo].[sesion]  WITH CHECK ADD FOREIGN KEY([id_uzivatel])
REFERENCES [dbo].[uzivatel] ([ID])
GO
ALTER TABLE [dbo].[uzivatel]  WITH CHECK ADD FOREIGN KEY([id_member])
REFERENCES [dbo].[clenstvi] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[VyberHry]    Script Date: 06.01.2023 20:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VyberHry] ( @Zanr nvarchar(20), @Pocet_hracu nvarchar(20))
AS
select * from hra 
where Zanr = @Zanr AND Pocet_hracu = @Pocet_hracu;
GO
/****** Object:  StoredProcedure [dbo].[ZanrHer]    Script Date: 06.01.2023 20:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ZanrHer] @Zanr nvarchar(30)
AS
SELECT * FROM hra 
WHERE Zanr = @Zanr;
GO
/****** Object:  StoredProcedure [dbo].[Zaznam]    Script Date: 06.01.2023 20:43:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Zaznam]
AS
select sesion.start_time , uzivatel.Nickname , hra.Nazev 
From sesion, uzivatel, hra
WHERE uzivatel.ID = id_uzivatel and hra.ID = id_hra and sesion.start_time <= GETDATE()
order by start_time;
GO
USE [master]
GO
ALTER DATABASE [charikov] SET  READ_WRITE 
GO
