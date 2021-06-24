/****** Object:  Table [dbo].[Geo_Cities]    Script Date: 18-06-2021 18:10:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Geo_Cities]
(
    [CityID] [int] NOT NULL,
    [CityName] [nvarchar](50) NOT NULL,
    [StateProvinceID] [int] NOT NULL,
    [Location] [geography] NULL,
    [LatestRecordedPopulation] [bigint] NULL,
    [LastEditedBy] [int] NOT NULL,
    [ValidFrom] [datetime2](7) NOT NULL,
    [ValidTo] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[geo_cities1]    Script Date: 18-06-2021 18:10:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[geo_cities1]
as
    (select CityID as City_ID,
        CityName as City,
        StateProvinceID as Province,
        Location as Loc

    from dbo.Geo_Cities)



GO
/****** Object:  Table [dbo].[Geo_HurricaneCustomerDetails]    Script Date: 18-06-2021 18:10:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Geo_HurricaneCustomerDetails]
(
    [CustomerId] [float] NULL,
    [FirstName] [nvarchar](255) NULL,
    [LastName] [nvarchar](255) NULL,
    [Gender] [nvarchar](255) NULL,
    [EmailId] [nvarchar](255) NULL,
    [ContactNo] [nvarchar](255) NULL,
    [BankName] [nvarchar](255) NULL,
    [LoanNo] [float] NULL,
    [LoanAmount] [float] NULL,
    [PayableAmount] [float] NULL,
    [InterestRate] [float] NULL,
    [TenureInYear] [float] NULL,
    [EMI] [float] NULL,
    [TotalEMI] [float] NULL,
    [EMIPaid] [float] NULL,
    [EMIRemaining] [float] NULL,
    [LoanStatus] [nvarchar](255) NULL,
    [CityID] [float] NULL,
    [HurricaneId] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Geo_HurricaneDetailsFlorida]    Script Date: 18-06-2021 18:10:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Geo_HurricaneDetailsFlorida]
(
    [Id] [float] NULL,
    [Storm] [nvarchar](255) NULL,
    [SaffirSimpsonCategory] [float] NULL,
    [Date] [float] NULL,
    [Month] [float] NULL,
    [Year] [float] NULL,
    [LandfallIntensityInKnots] [float] NULL,
    [LandfallLocation] [nvarchar](255) NULL,
    [CityID] [int] NULL,
    [Location] [geography] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[RiskAreas]    Script Date: 18-06-2021 18:10:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[RiskAreas]
as
    (

    select
        max(h.SaffirSimpsonCategory) as MaxSaffirSimpsonCategory,
        h.CityId as CityId,
        h.LandFallLocation as CityName,
        h.[Location].Lat AS [Latitude],
        h.[Location].Long AS [Longitude],
        WoodGroveCustomerCount = (SELECT sum(case when c.BankName = 'Woodgrove' and (c.LoanStatus = 'Defaulting' or c.LoanStatus = 'Ongoing') then 1 else 0 end)
        FROM [Geo_HurricaneCustomerDetails] c
        where c.CityID = h.CityId)
    from [Geo_HurricaneDetailsFlorida] h
    where h.Location IS NOT NULL
    group by h.CityID, h.LandFallLocation, h.[Location].Lat, h.[Location].Long

);

GO
/****** Object:  Table [dbo].[Geo_StateProvinces]    Script Date: 18-06-2021 18:10:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Geo_StateProvinces]
(
    [StateProvinceID] [int] NOT NULL,
    [StateProvinceCode] [nvarchar](5) NOT NULL,
    [StateProvinceName] [nvarchar](50) NOT NULL,
    [CountryID] [int] NOT NULL,
    [SalesTerritory] [nvarchar](50) NOT NULL,
    [Border] [geography] NULL,
    [LatestRecordedPopulation] [bigint] NULL,
    [LastEditedBy] [int] NOT NULL,
    [ValidFrom] [datetime2](7) NOT NULL,
    [ValidTo] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO