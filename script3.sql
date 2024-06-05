USE [master]
GO
/****** Object:  Database [Firma]    Script Date: 6/5/2024 8:21:50 PM ******/
CREATE DATABASE [Firma]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Firma', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\Firma.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Firma_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\Firma_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Firma] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Firma].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Firma] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Firma] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Firma] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Firma] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Firma] SET ARITHABORT OFF 
GO
ALTER DATABASE [Firma] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Firma] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Firma] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Firma] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Firma] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Firma] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Firma] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Firma] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Firma] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Firma] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Firma] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Firma] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Firma] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Firma] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Firma] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Firma] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Firma] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Firma] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Firma] SET  MULTI_USER 
GO
ALTER DATABASE [Firma] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Firma] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Firma] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Firma] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Firma] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Firma] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Firma] SET QUERY_STORE = ON
GO
ALTER DATABASE [Firma] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Firma]
GO
/****** Object:  UserDefinedFunction [dbo].[CzasTrwaniaProjektu]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CzasTrwaniaProjektu]
    (@ProjektKod NVARCHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @CzasTrwania INT

    SELECT @CzasTrwania = DATEDIFF(DAY, DataRoz, DataZak)
    FROM dbo.Projekt
    WHERE Kod = @ProjektKod

    RETURN @CzasTrwania
END
GO
/****** Object:  UserDefinedFunction [dbo].[LiczbaPracownikowWDziale]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[LiczbaPracownikowWDziale]
    (@DzialKod NVARCHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @LiczbaPracownikow INT

    SELECT @LiczbaPracownikow = COUNT(*)
    FROM dbo.Pracownik
    WHERE DzialKod = @DzialKod

    RETURN @LiczbaPracownikow
END
GO
/****** Object:  Table [dbo].[Pracownik]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pracownik](
	[Imie] [nvarchar](50) NULL,
	[Nazwisko] [nvarchar](50) NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[KierownikId] [int] NULL,
	[DzialKod] [char](3) NULL,
	[OddzialId] [int] NULL,
	[AdresId] [int] NULL,
	[SamochodId] [int] NULL,
	[DataUtworzenia] [datetime] NULL,
	[DataModyfikacji] [datetime] NULL,
 CONSTRAINT [PK_Osoba] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Adres]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Adres](
	[Id] [int] IDENTITY(1,100) NOT NULL,
	[Ulica] [nvarchar](50) NULL,
	[Miejscowosc] [nvarchar](50) NOT NULL,
	[KodPocztowy] [char](10) NULL,
	[KrajKod] [char](2) NOT NULL,
 CONSTRAINT [PK_Adres] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dzial]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dzial](
	[Kod] [char](3) NOT NULL,
	[Nazwa] [nvarchar](50) NOT NULL,
 CONSTRAINT [Dzial_pk] PRIMARY KEY CLUSTERED 
(
	[Kod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Oddzial]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Oddzial](
	[Id] [int] IDENTITY(1,10) NOT NULL,
	[Nazwa] [nvarchar](50) NOT NULL,
	[AdresId] [int] NOT NULL,
 CONSTRAINT [PK_Oddzial] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[PobierzDanePracownikaTabela]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[PobierzDanePracownikaTabela]
    (@Nazwisko NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT p.Imie, p.Nazwisko, p.Id, a.Ulica, a.Miejscowosc, a.KodPocztowy, a.KrajKod,
           d.Nazwa AS DzialNazwa, o.Nazwa AS OddzialNazwa
    FROM dbo.Pracownik p
    JOIN dbo.Adres a ON p.AdresId = a.Id
    JOIN dbo.Dzial d ON p.DzialKod = d.Kod
    JOIN dbo.Oddzial o ON p.OddzialId = o.Id
    WHERE p.Nazwisko = @Nazwisko
)
GO
/****** Object:  Table [dbo].[Kraj]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kraj](
	[Kod] [char](2) NOT NULL,
	[Nazwa] [nvarchar](50) NOT NULL,
 CONSTRAINT [Kraj_pk] PRIMARY KEY CLUSTERED 
(
	[Kod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projekt]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projekt](
	[Kod] [char](5) NOT NULL,
	[Nazwa] [nvarchar](50) NOT NULL,
	[DataRoz] [datetime] NOT NULL,
	[DataZak] [datetime] NULL,
 CONSTRAINT [PK_Projekt] PRIMARY KEY CLUSTERED 
(
	[Kod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projekt_Pracownik]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projekt_Pracownik](
	[ProjektKod] [char](5) NOT NULL,
	[PracownikId] [int] NOT NULL,
 CONSTRAINT [PK_Projekt_Pracownik] PRIMARY KEY CLUSTERED 
(
	[ProjektKod] ASC,
	[PracownikId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Samochod]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Samochod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Marka] [nvarchar](20) NOT NULL,
	[Model] [nvarchar](30) NULL,
	[NrRejestr] [char](10) NOT NULL,
	[PracownikId] [int] NULL,
 CONSTRAINT [PK_Samochod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [UQ_SamochodId]    Script Date: 6/5/2024 8:21:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_SamochodId] ON [dbo].[Pracownik]
(
	[SamochodId] ASC
)
WHERE ([SamochodId] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PracownikId]    Script Date: 6/5/2024 8:21:50 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_PracownikId] ON [dbo].[Samochod]
(
	[PracownikId] ASC
)
WHERE ([PracownikId] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pracownik] ADD  DEFAULT (getdate()) FOR [DataUtworzenia]
GO
ALTER TABLE [dbo].[Adres]  WITH CHECK ADD  CONSTRAINT [Adres_Kraj_Kod_fk] FOREIGN KEY([KrajKod])
REFERENCES [dbo].[Kraj] ([Kod])
GO
ALTER TABLE [dbo].[Adres] CHECK CONSTRAINT [Adres_Kraj_Kod_fk]
GO
ALTER TABLE [dbo].[Oddzial]  WITH CHECK ADD  CONSTRAINT [Oddzial_Adres_Id_fk] FOREIGN KEY([AdresId])
REFERENCES [dbo].[Adres] ([Id])
GO
ALTER TABLE [dbo].[Oddzial] CHECK CONSTRAINT [Oddzial_Adres_Id_fk]
GO
ALTER TABLE [dbo].[Pracownik]  WITH CHECK ADD  CONSTRAINT [Pracownik_Adres_Id_fk] FOREIGN KEY([AdresId])
REFERENCES [dbo].[Adres] ([Id])
GO
ALTER TABLE [dbo].[Pracownik] CHECK CONSTRAINT [Pracownik_Adres_Id_fk]
GO
ALTER TABLE [dbo].[Pracownik]  WITH CHECK ADD  CONSTRAINT [Pracownik_Dzial_Kod_fk] FOREIGN KEY([DzialKod])
REFERENCES [dbo].[Dzial] ([Kod])
GO
ALTER TABLE [dbo].[Pracownik] CHECK CONSTRAINT [Pracownik_Dzial_Kod_fk]
GO
ALTER TABLE [dbo].[Pracownik]  WITH CHECK ADD  CONSTRAINT [Pracownik_Oddzial_Id_fk] FOREIGN KEY([OddzialId])
REFERENCES [dbo].[Oddzial] ([Id])
GO
ALTER TABLE [dbo].[Pracownik] CHECK CONSTRAINT [Pracownik_Oddzial_Id_fk]
GO
ALTER TABLE [dbo].[Pracownik]  WITH CHECK ADD  CONSTRAINT [Pracownik_Pracownik_Id_fk] FOREIGN KEY([KierownikId])
REFERENCES [dbo].[Pracownik] ([Id])
GO
ALTER TABLE [dbo].[Pracownik] CHECK CONSTRAINT [Pracownik_Pracownik_Id_fk]
GO
ALTER TABLE [dbo].[Projekt_Pracownik]  WITH CHECK ADD  CONSTRAINT [Projekt_Pracownik_Pracownik_Id_fk] FOREIGN KEY([PracownikId])
REFERENCES [dbo].[Pracownik] ([Id])
GO
ALTER TABLE [dbo].[Projekt_Pracownik] CHECK CONSTRAINT [Projekt_Pracownik_Pracownik_Id_fk]
GO
ALTER TABLE [dbo].[Projekt_Pracownik]  WITH CHECK ADD  CONSTRAINT [Projekt_Pracownik_Projekt_Kod_fk] FOREIGN KEY([ProjektKod])
REFERENCES [dbo].[Projekt] ([Kod])
GO
ALTER TABLE [dbo].[Projekt_Pracownik] CHECK CONSTRAINT [Projekt_Pracownik_Projekt_Kod_fk]
GO
ALTER TABLE [dbo].[Samochod]  WITH CHECK ADD  CONSTRAINT [Samochod_Pracownik_Id_fk] FOREIGN KEY([PracownikId])
REFERENCES [dbo].[Pracownik] ([Id])
GO
ALTER TABLE [dbo].[Samochod] CHECK CONSTRAINT [Samochod_Pracownik_Id_fk]
GO
/****** Object:  StoredProcedure [dbo].[DodajPracownika]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajPracownika]
    @Imie NVARCHAR(50),
    @Nazwisko NVARCHAR(50),
    @Ulica NVARCHAR(100),
    @Miejscowosc NVARCHAR(50),
    @KodPocztowy NVARCHAR(10),
    @KrajKod NVARCHAR(2),
    @DzialKod NVARCHAR(10),
    @OddzialId INT,
    @SamochodId INT = NULL
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        DECLARE @AdresId INT

        INSERT INTO dbo.Adres (Ulica, Miejscowosc, KodPocztowy, KrajKod)
        VALUES (@Ulica, @Miejscowosc, @KodPocztowy, @KrajKod)

        SET @AdresId = SCOPE_IDENTITY()

        INSERT INTO dbo.Pracownik (Imie, Nazwisko, AdresId, DzialKod, OddzialId, SamochodId)
        VALUES (@Imie, @Nazwisko, @AdresId, @DzialKod, @OddzialId, @SamochodId)

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[PobierzDanePracownika]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PobierzDanePracownika]
    @Nazwisko NVARCHAR(50)
AS
BEGIN
    SELECT p.Imie, p.Nazwisko, p.Id, a.Ulica, a.Miejscowosc, a.KodPocztowy, a.KrajKod,
           d.Nazwa AS DzialNazwa, o.Nazwa AS OddzialNazwa
    FROM dbo.Pracownik p
    JOIN dbo.Adres a ON p.AdresId = a.Id
    JOIN dbo.Dzial d ON p.DzialKod = d.Kod
    JOIN dbo.Oddzial o ON p.OddzialId = o.Id
    WHERE p.Nazwisko = @Nazwisko
END
GO
/****** Object:  StoredProcedure [dbo].[UsunPracownika]    Script Date: 6/5/2024 8:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsunPracownika]
    @PracownikId INT
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        DECLARE @AdresId INT, @SamochodId INT

        SELECT @AdresId = AdresId, @SamochodId = SamochodId FROM dbo.Pracownik WHERE Id = @PracownikId

        DELETE FROM dbo.Projekt_Pracownik WHERE PracownikId = @PracownikId

        UPDATE dbo.Samochod SET PracownikId = NULL WHERE Id = @SamochodId

        DELETE FROM dbo.Pracownik WHERE Id = @PracownikId

        DELETE FROM dbo.Adres WHERE Id = @AdresId

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END
GO
USE [master]
GO
ALTER DATABASE [Firma] SET  READ_WRITE 
GO
