USE [master]
GO

/****** Object:  Database [LSA_DB]    Script Date: 23/8/2021 6:43:19 pm ******/
CREATE DATABASE [LSA_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LSA_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\LSA_DB.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LSA_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\LSA_DB_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [LSA_DB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LSA_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LSA_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LSA_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LSA_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LSA_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LSA_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [LSA_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LSA_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LSA_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LSA_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LSA_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LSA_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LSA_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LSA_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LSA_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LSA_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LSA_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LSA_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LSA_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LSA_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LSA_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LSA_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LSA_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LSA_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LSA_DB] SET  MULTI_USER 
GO
ALTER DATABASE [LSA_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LSA_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LSA_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LSA_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LSA_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LSA_DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [LSA_DB] SET QUERY_STORE = OFF
GO
USE [LSA_DB]
GO


/****** Object:  Table [dbo].[AccessRgts]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccessRgts](
	[AccessID] [int] IDENTITY(1,1) NOT NULL,
	[ProgID] [int] NULL,
	[LoginID] [varchar](20) NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AccessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUser]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUser](
	[LoginID] [varchar](20) NOT NULL,
	[Email] [varchar](30) NULL,
	[PasswordHash] [varchar](100) NULL,
	[PasswordSalt] [varchar](50) NULL,
	[IV] [varchar](100) NULL,
	[Key] [varchar](100) NULL,
	[UsrName] [varchar](20) NULL,
	[UsrShtName] [varchar](20) NULL,
	[UsrType] [varchar](20) NULL,
	[UsrRole] [varchar](20) NULL,
	[UsrStatus] [varchar](20) NULL,
	[LockStatus] [varchar](20) NULL,
	[LockUntil] [datetime] NULL,
	[LastLogin] [datetime] NULL,
	[LastPwdSet] [datetime] NULL,
	[AccessRgt] [varchar](20) NULL,
	[AccessRgtGrp] [varchar](20) NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL,
 CONSTRAINT [PK_AppUser] PRIMARY KEY CLUSTERED 
(
	[LoginID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facility]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facility](
	[FacilityID] [varchar](50) NOT NULL,
	[FacilityCode] [varchar](20) NULL,
	[ProjPhaseID] [int] NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL,
 CONSTRAINT [PK_Facility] PRIMARY KEY CLUSTERED 
(
	[FacilityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lesson]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lesson](
	[LessonID] [int] IDENTITY(1,1) NOT NULL,
	[LessonType] [varchar](20) NULL,
	[ModuleCode] [varchar](20) NULL,
	[ModuleGrp1] [varchar](20) NULL,
	[ModuleGrp2] [varchar](20) NULL,
	[ModuleGrp3] [varchar](20) NULL,
	[ModuleGrp4] [varchar](20) NULL,
	[ModuleGrp5] [varchar](20) NULL,
	[ModuleGrp6] [varchar](20) NULL,
	[ModuleGrp7] [varchar](20) NULL,
	[ModuleGrp8] [varchar](20) NULL,
	[TIC1] [varchar](20) NULL,
	[TIC2] [varchar](20) NULL,
	[TIC3] [varchar](20) NULL,
	[TIC4] [varchar](20) NULL,
	[FacilityID] [varchar](50) NULL,
	[DayOfWeek] [varchar](20) NULL,
	[ELearnEvenWeek] [varchar](20) NULL,
	[TimeStart] [datetime] NULL,
	[TimeEnd] [datetime] NULL,
	[WeekStart] [int] NULL,
	[WeekEnd] [int] NULL,
	[Semester] [varchar](20) NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LessonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parameter]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parameter](
	[ParaCode1] [varchar](20) NOT NULL,
	[ParaCode2] [varchar](20) NOT NULL,
	[ParaCode3] [varchar](20) NOT NULL,
	[Desc1] [varchar](100) NULL,
	[Desc2] [varchar](100) NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Program]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program](
	[ProgID] [int] IDENTITY(1,1) NOT NULL,
	[ProgName] [varchar](20) NULL,
	[ProgDesc] [varchar](50) NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProgID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectPhase]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectPhase](
	[ProjPhaseID] [int] NOT NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[ProjectLead] [varchar](20) NULL,
	[Member2] [varchar](20) NULL,
	[Member3] [varchar](20) NULL,
	[Member4] [varchar](20) NULL,
	[ProjectSupervisor] [varchar](20) NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL,
 CONSTRAINT [PK_ProjectPhase] PRIMARY KEY CLUSTERED 
(
	[ProjPhaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Questionnaire]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questionnaire](
	[QnsID] [int] IDENTITY(1,1) NOT NULL,
	[QnsNo] [int] NULL,
	[Type] [varchar](20) NULL,
	[Category] [varchar](20) NULL,
	[Desc] [varchar](200) NULL,
	[HasQnsGroup] [varchar](20) NULL,
	[QnsGroupID] [int] NULL,
	[Optional] [varchar](20) NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[QnsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionnaireGroup]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionnaireGroup](
	[QnsGroupID] [int] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](20) NULL,
	[Desc] [varchar](200) NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[QnsGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Response]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Response](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ResponseID] [varchar](50) NULL,
	[DateTimeStamp] [datetime] NULL,
	[FacilityID] [varchar](50) NULL,
	[RespondentID] [varchar](20) NULL,
	[QnsID] [int] NULL,
	[RespDesc] [varchar](200) NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SensorDevice]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SensorDevice](
	[DeviceID] [varchar](50) NOT NULL,
	[DeviceMAC] [varchar](50) NULL,
	[DeviceName] [varchar](50) NULL,
	[FacilityID] [varchar](50) NULL,
	[DevicePosition] [varchar](20) NULL,
	[FirstSeen] [datetime] NULL,
	[LastHeard] [datetime] NULL,
	[LastHeartBeat] [datetime] NULL,
	[AlarmRecognition] [varchar](20) NULL,
	[PowerSaveMode] [varchar](20) NULL,
	[ListeningMode] [varchar](20) NULL,
	[ActiveStatus] [varchar](20) NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL,
 CONSTRAINT [PK_SensorDevice] PRIMARY KEY CLUSTERED 
(
	[DeviceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SensorReading]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SensorReading](
	[DateTimeStamp] [datetime] NOT NULL,
	[Sound] [float] NULL,
	[Humidity] [float] NULL,
	[Temperature] [float] NULL,
	[Motion] [float] NULL,
	[DeviceID] [varchar](50) NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[StudentID] [int] IDENTITY(1,1) NOT NULL,
	[AdminNo] [varchar](20) NULL,
	[PEMGrp] [varchar](20) NULL,
	[Course] [varchar](20) NULL,
	[Age] [int] NULL,
	[Gender] [varchar](20) NULL,
	[GPAS1] [float] NULL,
	[GPAS2] [float] NULL,
	[CreateBy] [varchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[AmendBy] [varchar](20) NULL,
	[AmendDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[AppUser] ([LoginID], [Email], [PasswordHash], [PasswordSalt], [IV], [Key], [UsrName], [UsrShtName], [UsrType], [UsrRole], [UsrStatus], [LockStatus], [LockUntil], [LastLogin], [LastPwdSet], [AccessRgt], [AccessRgtGrp], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'admin1', N'192529t@mymail.nyp.edu.sg', N'iLQ2cPrFByGOJxphptBVovpWi4OkObOMLm/qVJ3RbHpNUu0AJvCQygqDH9OY3fXfmdbYVcjhd8ThtpPT3apreg==', N'CM+4ykyj5Jc=', N'LYStrCMFpRjW/+w/eF1XLA==', N'Eis34ziKjVFojpWLWpoPCLfTuKWkgoaIGXIFGoieVpE=', N'Admin1', N'Admin1', N'I', N'AM', N'A', N'U', NULL, NULL, CAST(N'2021-08-23T18:42:00.313' AS DateTime), N'G', N'A', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[AppUser] ([LoginID], [Email], [PasswordHash], [PasswordSalt], [IV], [Key], [UsrName], [UsrShtName], [UsrType], [UsrRole], [UsrStatus], [LockStatus], [LockUntil], [LastLogin], [LastPwdSet], [AccessRgt], [AccessRgtGrp], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'jkoh21', N'joanna_koh@nyp.edu.sg', N'+WwiK2F9hZw7NC6ttW19gGTrIHqOj2t+MfE+X+pkRvfw9mbZFRMHmKDnwZtrSe2uvigNyfRFpidjbEGe4NYoKw==', N'dGWWgMJQAmg=', N'SVJKGEl2rdsQZGrIGRdyTQ==', N'SGtea56QNYkHhSVJp63c4Pw6CIGQCA7ID3e5UTek1t0=', N'Joanna Koh', N'JKOH', N'I', N'PS', N'A', N'U', NULL, NULL, CAST(N'2021-08-23T18:42:00.313' AS DateTime), N'G', N'L', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[AppUser] ([LoginID], [Email], [PasswordHash], [PasswordSalt], [IV], [Key], [UsrName], [UsrShtName], [UsrType], [UsrRole], [UsrStatus], [LockStatus], [LockUntil], [LastLogin], [LastPwdSet], [AccessRgt], [AccessRgtGrp], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'nazr21', N'192529t@mymail.nyp.edu.sg', N'a0lCqqBr0LLXOUqX8MO49kiwwfAeZAXLDEydoKsD/eLgJmLIEHoHTFaKvnZlbEchPcv4RjH0btFnOWd4spqEwQ==', N'BaADwUL0gYc=', N'0+msR7BQvxFhjfmw84EgCA==', N'yr+MoV9FOaSmJ/umh44uH5l+QRmYi2gbsHxVgyV0whY=', N'M Nazrie Daud', N'mnaz', N'I', N'PL', N'A', N'U', NULL, NULL, CAST(N'2021-08-23T18:42:00.313' AS DateTime), N'G', N'S', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Facility] ([FacilityID], [FacilityCode], [ProjPhaseID], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'60dd25fc41c10d28a00d9833', N'L530', 1, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Facility] ([FacilityID], [FacilityCode], [ProjPhaseID], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'L504_dmyid', N'L504', 1, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Facility] ([FacilityID], [FacilityCode], [ProjPhaseID], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'L506_dmyid', N'L506', 1, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Facility] ([FacilityID], [FacilityCode], [ProjPhaseID], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'N711_dmyid', N'N711', 1, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Lesson] ON 

INSERT [dbo].[Lesson] ([LessonID], [LessonType], [ModuleCode], [ModuleGrp1], [ModuleGrp2], [ModuleGrp3], [ModuleGrp4], [ModuleGrp5], [ModuleGrp6], [ModuleGrp7], [ModuleGrp8], [TIC1], [TIC2], [TIC3], [TIC4], [FacilityID], [DayOfWeek], [ELearnEvenWeek], [TimeStart], [TimeEnd], [WeekStart], [WeekEnd], [Semester], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (1, N'LAB', N'ITB411', N'01', N'02', NULL, NULL, NULL, NULL, NULL, NULL, N'WANGLC', N'TEOMT', NULL, NULL, N'60dd25fc41c10d28a00d9833', N'MON', N'true', CAST(N'1990-01-01T09:00:00.000' AS DateTime), CAST(N'1990-01-01T12:00:00.000' AS DateTime), 11, 17, N'2021S1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Lesson] ([LessonID], [LessonType], [ModuleCode], [ModuleGrp1], [ModuleGrp2], [ModuleGrp3], [ModuleGrp4], [ModuleGrp5], [ModuleGrp6], [ModuleGrp7], [ModuleGrp8], [TIC1], [TIC2], [TIC3], [TIC4], [FacilityID], [DayOfWeek], [ELearnEvenWeek], [TimeStart], [TimeEnd], [WeekStart], [WeekEnd], [Semester], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (2, N'LAB', N'ITB811', N'01', N'02', NULL, NULL, NULL, NULL, NULL, NULL, N'WANGLC', N'WINSTONL', N'IRISC', N'TEOMT', N'60dd25fc41c10d28a00d9833', N'MON', N'true', CAST(N'1990-01-01T09:00:00.000' AS DateTime), CAST(N'1990-01-01T12:00:00.000' AS DateTime), 4, 8, N'2021S1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Lesson] ([LessonID], [LessonType], [ModuleCode], [ModuleGrp1], [ModuleGrp2], [ModuleGrp3], [ModuleGrp4], [ModuleGrp5], [ModuleGrp6], [ModuleGrp7], [ModuleGrp8], [TIC1], [TIC2], [TIC3], [TIC4], [FacilityID], [DayOfWeek], [ELearnEvenWeek], [TimeStart], [TimeEnd], [WeekStart], [WeekEnd], [Semester], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (3, N'LAB', N'ITB211', N'03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'AGNESN', N'KOHNS', NULL, NULL, N'60dd25fc41c10d28a00d9833', N'MON', N'true', CAST(N'1990-01-01T12:00:00.000' AS DateTime), CAST(N'1990-01-01T15:00:00.000' AS DateTime), 4, 8, N'2021S1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Lesson] ([LessonID], [LessonType], [ModuleCode], [ModuleGrp1], [ModuleGrp2], [ModuleGrp3], [ModuleGrp4], [ModuleGrp5], [ModuleGrp6], [ModuleGrp7], [ModuleGrp8], [TIC1], [TIC2], [TIC3], [TIC4], [FacilityID], [DayOfWeek], [ELearnEvenWeek], [TimeStart], [TimeEnd], [WeekStart], [WeekEnd], [Semester], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (4, N'LAB', N'ITB511', N'03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'CHEWTK', NULL, NULL, NULL, N'60dd25fc41c10d28a00d9833', N'TUE', N'true', CAST(N'1990-01-01T09:00:00.000' AS DateTime), CAST(N'1990-01-01T12:00:00.000' AS DateTime), 4, 17, N'2021S1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Lesson] ([LessonID], [LessonType], [ModuleCode], [ModuleGrp1], [ModuleGrp2], [ModuleGrp3], [ModuleGrp4], [ModuleGrp5], [ModuleGrp6], [ModuleGrp7], [ModuleGrp8], [TIC1], [TIC2], [TIC3], [TIC4], [FacilityID], [DayOfWeek], [ELearnEvenWeek], [TimeStart], [TimeEnd], [WeekStart], [WeekEnd], [Semester], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (5, N'LAB', N'ITB211', N'01', N'02', NULL, NULL, NULL, NULL, NULL, NULL, N'GOHHUILIN', N'WINSTONL', N'PANGNAIKI', N'JAMESC', N'60dd25fc41c10d28a00d9833', N'TUE', N'true', CAST(N'1990-01-01T12:00:00.000' AS DateTime), CAST(N'1990-01-01T15:00:00.000' AS DateTime), 4, 17, N'2021S1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Lesson] ([LessonID], [LessonType], [ModuleCode], [ModuleGrp1], [ModuleGrp2], [ModuleGrp3], [ModuleGrp4], [ModuleGrp5], [ModuleGrp6], [ModuleGrp7], [ModuleGrp8], [TIC1], [TIC2], [TIC3], [TIC4], [FacilityID], [DayOfWeek], [ELearnEvenWeek], [TimeStart], [TimeEnd], [WeekStart], [WeekEnd], [Semester], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (6, N'LAB', N'ITB111', N'03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'DAWNF', N'GRACECHAN', NULL, NULL, N'60dd25fc41c10d28a00d9833', N'TUE', N'true', CAST(N'1990-01-01T15:00:00.000' AS DateTime), CAST(N'1990-01-01T18:00:00.000' AS DateTime), 4, 17, N'2021S1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Lesson] ([LessonID], [LessonType], [ModuleCode], [ModuleGrp1], [ModuleGrp2], [ModuleGrp3], [ModuleGrp4], [ModuleGrp5], [ModuleGrp6], [ModuleGrp7], [ModuleGrp8], [TIC1], [TIC2], [TIC3], [TIC4], [FacilityID], [DayOfWeek], [ELearnEvenWeek], [TimeStart], [TimeEnd], [WeekStart], [WeekEnd], [Semester], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (7, N'LAB', N'ITB611', N'01', N'02', NULL, NULL, NULL, NULL, NULL, NULL, N'BALAC', N'SEAHSH', NULL, NULL, N'60dd25fc41c10d28a00d9833', N'WED', N'true', CAST(N'1990-01-01T09:00:00.000' AS DateTime), CAST(N'1990-01-01T12:00:00.000' AS DateTime), 4, 17, N'2021S1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Lesson] ([LessonID], [LessonType], [ModuleCode], [ModuleGrp1], [ModuleGrp2], [ModuleGrp3], [ModuleGrp4], [ModuleGrp5], [ModuleGrp6], [ModuleGrp7], [ModuleGrp8], [TIC1], [TIC2], [TIC3], [TIC4], [FacilityID], [DayOfWeek], [ELearnEvenWeek], [TimeStart], [TimeEnd], [WeekStart], [WeekEnd], [Semester], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (8, N'LAB', N'ITB411', N'03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'WANGMF', NULL, NULL, NULL, N'60dd25fc41c10d28a00d9833', N'WED', N'true', CAST(N'1990-01-01T12:00:00.000' AS DateTime), CAST(N'1990-01-01T15:00:00.000' AS DateTime), 11, 17, N'2021S1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Lesson] ([LessonID], [LessonType], [ModuleCode], [ModuleGrp1], [ModuleGrp2], [ModuleGrp3], [ModuleGrp4], [ModuleGrp5], [ModuleGrp6], [ModuleGrp7], [ModuleGrp8], [TIC1], [TIC2], [TIC3], [TIC4], [FacilityID], [DayOfWeek], [ELearnEvenWeek], [TimeStart], [TimeEnd], [WeekStart], [WeekEnd], [Semester], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (9, N'LAB', N'ITB811', N'03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'GINNYP', N'WANGMF', NULL, NULL, N'60dd25fc41c10d28a00d9833', N'WED', N'true', CAST(N'1990-01-01T12:00:00.000' AS DateTime), CAST(N'1990-01-01T15:00:00.000' AS DateTime), 4, 8, N'2021S1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Lesson] ([LessonID], [LessonType], [ModuleCode], [ModuleGrp1], [ModuleGrp2], [ModuleGrp3], [ModuleGrp4], [ModuleGrp5], [ModuleGrp6], [ModuleGrp7], [ModuleGrp8], [TIC1], [TIC2], [TIC3], [TIC4], [FacilityID], [DayOfWeek], [ELearnEvenWeek], [TimeStart], [TimeEnd], [WeekStart], [WeekEnd], [Semester], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (10, N'LAB', N'ITB111', N'01', N'02', NULL, NULL, NULL, NULL, NULL, NULL, N'CLAIRET', N'LEECY', N'EUGENEL', N'LIMAH', N'60dd25fc41c10d28a00d9833', N'WED', N'true', CAST(N'1990-01-01T15:00:00.000' AS DateTime), CAST(N'1990-01-01T18:00:00.000' AS DateTime), 4, 17, N'2021S1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Lesson] ([LessonID], [LessonType], [ModuleCode], [ModuleGrp1], [ModuleGrp2], [ModuleGrp3], [ModuleGrp4], [ModuleGrp5], [ModuleGrp6], [ModuleGrp7], [ModuleGrp8], [TIC1], [TIC2], [TIC3], [TIC4], [FacilityID], [DayOfWeek], [ELearnEvenWeek], [TimeStart], [TimeEnd], [WeekStart], [WeekEnd], [Semester], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (11, N'LAB', N'ITB511', N'01', N'02', NULL, NULL, NULL, NULL, NULL, NULL, N'MAHKW', N'FONGCW', NULL, NULL, N'60dd25fc41c10d28a00d9833', N'THU', N'true', CAST(N'1990-01-01T12:00:00.000' AS DateTime), CAST(N'1990-01-01T15:00:00.000' AS DateTime), 4, 17, N'2021S1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Lesson] ([LessonID], [LessonType], [ModuleCode], [ModuleGrp1], [ModuleGrp2], [ModuleGrp3], [ModuleGrp4], [ModuleGrp5], [ModuleGrp6], [ModuleGrp7], [ModuleGrp8], [TIC1], [TIC2], [TIC3], [TIC4], [FacilityID], [DayOfWeek], [ELearnEvenWeek], [TimeStart], [TimeEnd], [WeekStart], [WeekEnd], [Semester], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (12, N'LAB', N'ITB611', N'03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'BALAC', NULL, NULL, NULL, N'60dd25fc41c10d28a00d9833', N'FRI', N'true', CAST(N'1990-01-01T09:00:00.000' AS DateTime), CAST(N'1990-01-01T12:00:00.000' AS DateTime), 4, 17, N'2021S1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Lesson] OFF
GO
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'COURSE', N'SIT', N'C36', N'Common ICT Programme', N'CIP', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'COURSE', N'SIT', N'C35', N'Business & Financial Technology', N'DBFT', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'COURSE', N'SIT', N'C43', N'Business Intelligence & Analytics', N'DBA', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'COURSE', N'SIT', N'C54', N'Cybersecurity & Digital Forensics', N'DCS', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'COURSE', N'SIT', N'C80', N'Infocomm & Security', N'DIS', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'COURSE', N'SIT', N'C85', N'Information Technology', N'DIT', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'IT2151', N'CMATH', N'Computing Mathematics', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'IT2152', N'WEBDEV', N'Web Development', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'IT2153', N'INFOSEC', N'Infocomm Security', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'IT2154', N'PROGESS', N'Programming Essentials', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITB111', N'UXD', N'UX Design', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITB211', N'SRM', N'Statistical Research Methods', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITB411', N'DMOD', N'Data Modelling', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITB511', N'PROG', N'Programming', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITB611', N'NETA', N'Network Administration', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITB811', N'BNA', N'Business Needs Analysis', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITB131', N'', N'Data Visualisation', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITB221', N'', N'Decision Analysis', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITB421', N'', N'Data Storage Administration', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITB521', N'', N'Data Structures & Algorithms', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITB621', N'', N'Operating Systems Administration', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITB911', N'', N'Applied Cryptography', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'MODULE', N'SIT', N'ITBW21', N'', N'Visual Analytics Project', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SEMESTER', N'StartToEndDate', N'2021S1', N'2021-04-19T08:00:00', N'2021-08-20T21:00:00', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SEMESTER', N'StartToEndDate', N'2021S2', N'2021-08-23T08:00:00', N'2021-12-19T21:00:00', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'ACADEMICYEAR', N'PROJECTSTART', N'', N'2021', N'Year of project start', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'ACADEMICYEAR', N'PROJECTEND', N'', N'2025', N'Year of project end', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'LESSON', N'TYPE', N'LEC', N'Lecture', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'LESSON', N'TYPE', N'ELEC', N'E-Lecture', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'LESSON', N'TYPE', N'TUT', N'Tutorial', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'LESSON', N'TYPE', N'ETUT', N'E-Tutorial', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'LESSON', N'TYPE', N'LAB', N'Lab', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'LESSON', N'TYPE', N'ELAB', N'E-Lab', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'PASSWORD', N'AGE', N'MAXIMUM', N'180', N'180 days', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'PASSWORD', N'AGE', N'MINIMUM', N'1', N'1 day', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'PASSWORD', N'DEFAULT', N'', N'L$@naly+!cz', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'USRTYPE', N'I', N'', N'Individual', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'USRTYPE', N'G', N'', N'Group', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'USRROLE', N'G', N'', N'Guest', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'USRROLE', N'PL', N'', N'Project Lead', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'USRROLE', N'PM2', N'', N'Project Member 2', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'USRROLE', N'PM3', N'', N'Project Member 3', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'USRROLE', N'PM4', N'', N'Project Member 4', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'USRROLE', N'PS', N'', N'Project Supervisor', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'USRROLE', N'AM', N'', N'Administrator', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'USRSTATUS', N'A', N'', N'Active', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'USRSTATUS', N'I', N'', N'Inactive', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'LOCKSTATUS', N'L', N'', N'Locked', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'LOCKSTATUS', N'U', N'', N'Unlocked', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'ACCESSRGT', N'I', N'', N'Individual', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'ACCESSRGT', N'G', N'', N'Group', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'ACCESSRGTGRP', N'A', N'', N'Administrator', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'ACCESSRGTGRP', N'G', N'', N'Guest', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'ACCESSRGTGRP', N'L', N'', N'Lecturer', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'ACCESSRGTGRP', N'S', N'', N'Student', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'CUSTOMEVER', N'100', N'100% of the module or every lesson', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'CUSTOMEVER', N'75', N'75% of the module', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'CUSTOMEVER', N'50', N'50% of the module', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'CUSTOMEVER', N'25', N'25% of the module', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'CUSTOMEVER', N'EVER', N'Never or hardly ever', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'CUSTOMWILL', N'100', N'100% of the module or every lesson', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'CUSTOMWILL', N'75', N'75% of the module', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'CUSTOMWILL', N'50', N'50% of the module', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'CUSTOMWILL', N'25', N'25% of the module', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'CUSTOMWILL', N'WILL', N'Never or hardly will', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QUAL', N'SD', N'Strongly Disagree', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QUAL', N'D', N'Disagree', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QUAL', N'A', N'Agree', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QUAL', N'SA', N'Strongly Agree', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QUAN', N'NV', N'Never', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QUAN', N'R', N'Rarely', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QUAN', N'O', N'Often', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QUAN', N'A', N'Always', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORSTU', N'1', N'The temperature is just right', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORSTU', N'2', N'The colour(s) are just right', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORSTU', N'3', N'The furniture is comfortable', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORSTU', N'4', N'The tables are easily configurable', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORSTU', N'5', N'The chairs have castors (wheels) on them', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORSTU', N'6', N'I can see outside', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORSTU', N'7', N'I have freedom to move around in this space', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORSTU', N'8', N'I can easily collaborate with other students in small groups', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORSTU', N'9', N'It is well equipped with everything to help me learn', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORSTU', N'10', N'There are sufficient whiteboards', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORSTU', N'11', N'Others', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORLEC', N'1', N'The temperature is just right', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORLEC', N'2', N'The lighting is just right', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORLEC', N'2', N'The colour(s) are just right', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORLEC', N'3', N'The instructor table/chair is comfortable', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORLEC', N'4', N'The tables are easily configurable', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORLEC', N'6', N'I can see outside', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORLEC', N'7', N'I can move around this space easily', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORLEC', N'8', N'I can see every student from the instructor desk', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORLEC', N'9', N'It is well equipped with everything to help me teach', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORLEC', N'10', N'There are sufficient whiteboards', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'FACTORLEC', N'11', N'Others', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QNSTYPE', N'QUAL', N'Qualitative', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QNSTYPE', N'QUAN', N'Quantitative', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QNSTYPE', N'OPEN', N'Open-Ended', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QNSTYPE', N'FACTORSTU', N'Factors Listed on Stu''s Survey', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QNSTYPE', N'FACTORLEC', N'Factors Listed on Lec''s Survey', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QNSTYPE', N'CUSTOMEVER', N'Custom Frequency Scale (Ever)', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'QNSTYPE', N'CUSTOMWILL', N'Custom Frequency (Will)', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'CATEGORY', N'STU', N'Student', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SURVEY', N'CATEGORY', N'LEC', N'Lecturer', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'FACILITY', N'', N'', N'#Auto-generated', N'#This is an auto-generated Facility. Please update sensor-device FacilityCode ASAP.', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'FACILITY', N'L', N'530', N'L530', N'Block L, School of IT Lab 530', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'FACILITY', N'L', N'504', N'L504', N'Block L, School of IT Lab 504', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'FACILITY', N'L', N'506', N'L506', N'Block L, School of IT Lab 506', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'FACILITY', N'N', N'711', N'N711', N'Block N, FYPJ Lab 711', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'FACILITY', N'N', N'714', N'N714', N'Block N, FYPJ Lab 714', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'FACILITY', N'N', N'715', N'N715', N'Block N, FYPJ Lab 715', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'CALENDAR', N'DAY', N'SUN', N'Sunday', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'CALENDAR', N'DAY', N'MON', N'Monday', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'CALENDAR', N'DAY', N'TUE', N'Tuesday', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'CALENDAR', N'DAY', N'WED', N'Wednesday', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'CALENDAR', N'DAY', N'THU', N'Thursday', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'CALENDAR', N'DAY', N'FRI', N'Friday', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'CALENDAR', N'DAY', N'SAT', N'Saturday', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'SWITCHMODE', N'off', N'OFF', N'0', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'SWITCHMODE', N'on', N'ON', N'1', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'SWITCHMODE', N'interval', N'INTERVAL', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'POSITION', N'', N'#Auto-generated', N'#This is an auto-generated Value. Please update sensor-device Position ASAP.', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'POSITION', N'FL', N'Front-Left', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'POSITION', N'FM', N'Front-Middle', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'POSITION', N'FR', N'Front-Right', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'POSITION', N'CL', N'Center-Left', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'POSITION', N'CM', N'Center-Middle', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'POSITION', N'CR', N'Center-Right', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'POSITION', N'BL', N'Back-Left', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'POSITION', N'BM', N'Back-Middle', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Parameter] ([ParaCode1], [ParaCode2], [ParaCode3], [Desc1], [Desc2], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'SENSOR', N'POSITION', N'BR', N'Back-Right', NULL, N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[ProjectPhase] ([ProjPhaseID], [StartDate], [EndDate], [ProjectLead], [Member2], [Member3], [Member4], [ProjectSupervisor], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (1, CAST(N'2021-05-31T00:00:00.000' AS DateTime), CAST(N'2021-08-20T00:00:00.000' AS DateTime), N'nazr21', NULL, NULL, NULL, N'jkoh21', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[ProjectPhase] ([ProjPhaseID], [StartDate], [EndDate], [ProjectLead], [Member2], [Member3], [Member4], [ProjectSupervisor], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (2, CAST(N'2021-08-23T00:00:00.000' AS DateTime), CAST(N'2021-10-12T00:00:00.000' AS DateTime), N'alex21', NULL, NULL, NULL, N'jkoh21', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Questionnaire] ON 

INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (1, 1, N'QUAL', N'STU', N'I can hear the lecturer''s voice clearly.', N'true', 1, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (2, 2, N'QUAL', N'STU', N'I can hear my peers clearly during group discussion.', N'true', 1, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (3, 3, N'QUAL', N'STU', N'I can hear other students clearly when they are in their group discussion.', N'true', 1, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (4, 4, N'QUAL', N'STU', N'I can hear other students clearly when they are talking to the class.', N'true', 1, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (5, 5, N'QUAL', N'STU', N'I am disturbed by noise from outside the space.', N'true', 1, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (6, 6, N'QUAL', N'STU', N'I can see what is drawn or written on the whiteboard without difficulty.', N'true', 2, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (7, 7, N'QUAL', N'STU', N'I can see what is displayed on the lecturer''s screen (e.g. LCD screen; TV screen; projection screen) without difficulty.', N'true', 2, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (8, 8, N'QUAL', N'STU', N'I can see my peer''s screen clearly when we are having our group discussion.', N'true', 2, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (9, 9, N'QUAL', N'STU', N'The chairs are versatile, and it allows me to transit from one activity to next quickly.', N'true', 3, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (10, 10, N'QUAL', N'STU', N'The chairs are comfortable to sit on and it''s just the right size for me.', N'true', 3, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (11, 11, N'QUAL', N'STU', N'The tables support team activities and individual focus without much interruption.', N'true', 3, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (12, 12, N'QUAL', N'STU', N'The tables are big enough to support my learning.', N'true', 3, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (13, 13, N'QUAL', N'STU', N'The learning space motivates me to do better in my studies.', N'true', 4, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (14, 14, N'QUAL', N'STU', N'As a whole, I find the learning space conducive.', N'true', 4, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (15, 15, N'FACTORSTU', N'STU', N'What are the factors that apply in this learning space that help you learn best?', N'true', 4, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (16, 1, N'OPEN', N'LEC', N'Please tick the Competency Unit(s) you are teaching in 2021S1.', N'false', NULL, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (17, 2, N'QUAL', N'LEC', N'The design of the learning spaces supports collaboration with other lecturers.', N'true', 5, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (18, 3, N'QUAL', N'LEC', N'The design of the learning spaces supports the use of a variety of teaching practices (such as seminar-style T&L, small & large group discussions).', N'true', 5, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (19, 4, N'QUAL', N'LEC', N'The learning spaces suit my preferred teaching practice.', N'true', 5, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (20, 5, N'QUAL', N'LEC', N'I am provided with time to plan collaboratively with other lecturers.', N'true', 5, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (21, 6, N'QUAL', N'LEC', N'I can hear the students clearly when they speak.', N'true', 6, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (22, 7, N'QUAL', N'LEC', N'I can teach comfortably in this space without speaking above-normal volume.', N'true', 6, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (23, 8, N'QUAL', N'LEC', N'I am disturbed by noise from outside the space.', N'true', 6, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (24, 9, N'QUAL', N'LEC', N'Sound echoes too much in the classroom.', N'true', 6, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (25, 10, N'CUSTOMEVER', N'LEC', N'Type A layouts that support explicit instruction/ presentation.', N'true', 7, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (26, 11, N'CUSTOMEVER', N'LEC', N'Type B layouts that support students working in small groups.', N'true', 7, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (27, 12, N'CUSTOMEVER', N'LEC', N'Type C layouts that support students working independently.', N'true', 7, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (28, 13, N'CUSTOMEVER', N'LEC', N'Type D layouts that support team teaching.', N'true', 7, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (29, 14, N'OPEN', N'LEC', N'Other layout.', N'true', 7, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (30, 15, N'CUSTOMWILL', N'LEC', N'Type A layouts that support explicit instruction/ presentation.', N'true', 8, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (31, 16, N'CUSTOMWILL', N'LEC', N'Type B layouts that support students working in small groups.', N'true', 8, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (32, 17, N'CUSTOMWILL', N'LEC', N'Type C layouts that support students working independently.', N'true', 8, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (33, 18, N'CUSTOMWILL', N'LEC', N'Type D layouts that support team teaching.', N'true', 8, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (34, 19, N'OPEN', N'LEC', N'Other layout.', N'true', 8, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (35, 20, N'CUSTOMEVER', N'LEC', N'Need to rearrange tables or chairs prior to the start of a lesson because a previous user had them in a different position.', N'true', 9, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (36, 21, N'CUSTOMEVER', N'LEC', N'Change the layout of the space for different classes, according to activities you had planned (e.g. re-configure table layout).', N'true', 9, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (37, 22, N'CUSTOMEVER', N'LEC', N'Rearrange the layout of a space during a class (e.g. tables and chairs get moved into different positions).', N'true', 9, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (38, 23, N'CUSTOMEVER', N'LEC', N'Encourage students to move the furniture during class to suit group formation or participation in activities.', N'true', 9, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (39, 24, N'CUSTOMEVER', N'LEC', N'Encourage students to move around a space during a class.', N'true', 9, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (40, 25, N'QUAL', N'LEC', N'It is easy to move the furniture.', N'true', 10, N'true', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (41, 26, N'QUAL', N'LEC', N'There is enough time to rearrange the furniture before classes begin.', N'true', 10, N'true', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (42, 27, N'QUAL', N'LEC', N'There is enough space to arrange the furniture in different ways.', N'true', 10, N'true', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (43, 28, N'QUAL', N'LEC', N'The furniture can easily be moved during lesson time.', N'true', 10, N'true', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (44, 29, N'CUSTOMEVER', N'LEC', N'The ability to project sound and vision for a group of students (such as a projector or large TV with audio).', N'true', 11, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (45, 30, N'CUSTOMEVER', N'LEC', N'Wireless internet access.', N'true', 11, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (46, 31, N'CUSTOMEVER', N'LEC', N'Desktop computer provided in the room.', N'true', 11, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (47, 32, N'CUSTOMEVER', N'LEC', N'Office laptops.', N'true', 11, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (48, 33, N'CUSTOMEVER', N'LEC', N'Tablets (e.g. iPad, Surfacebook).', N'true', 11, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (49, 34, N'CUSTOMEVER', N'LEC', N'Charge points (for mobile devices).', N'true', 11, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (50, 35, N'OPEN', N'LEC', N'If you use other types of technologies in the spaces/rooms in which you teach, please briefly describe here:', N'true', 11, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (51, 36, N'CUSTOMWILL', N'LEC', N'Share digital information of all kinds from any source and wirelessly from your own mobile devices (smartphones, tablets and personal laptops) to instructor''s screen (projector or TV).', N'true', 12, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (52, 37, N'CUSTOMWILL', N'LEC', N'Enable students to share digital information of all kinds from their own mobile devices  wirelessly to the other student''s screens.', N'true', 12, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (53, 38, N'CUSTOMWILL', N'LEC', N'Enable students to connect their own mobile devices wirelessly to the instructor''s screen.', N'true', 12, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (54, 39, N'CUSTOMWILL', N'LEC', N'Connect to a Zoom meeting lesson concurrently with the face to face lesson (supporting hybrid lesson).', N'true', 12, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (55, 40, N'CUSTOMWILL', N'LEC', N'Annotate on-screen and share the content wirelessly with student''s device.', N'true', 12, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (56, 41, N'CUSTOMWILL', N'LEC', N'Enable multiple students to annotate on-screen at the same time from their own device if required.', N'true', 12, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (57, 42, N'FACTORLEC', N'LEC', N'What are the factors that apply in this learning space that support my teaching?', N'true', 12, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (58, 43, N'QUAL', N'LEC', N'As a whole, I find L530 is a conducive learning space that supports my teaching needs.', N'true', 12, N'false', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[Questionnaire] ([QnsID], [QnsNo], [Type], [Category], [Desc], [HasQnsGroup], [QnsGroupID], [Optional], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (59, 44, N'OPEN', N'LEC', N'Do leave your suggestion here if you have any ideas to improve this learning space.', N'true', 12, N'true', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Questionnaire] OFF
GO
SET IDENTITY_INSERT [dbo].[QuestionnaireGroup] ON 

INSERT [dbo].[QuestionnaireGroup] ([QnsGroupID], [Category], [Desc], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (1, N'STU', N'How well can you hear in the spaces where you have lessons, or study?', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[QuestionnaireGroup] ([QnsGroupID], [Category], [Desc], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (2, N'STU', N'How well can you see in the spaces where you have lessons, or study?', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[QuestionnaireGroup] ([QnsGroupID], [Category], [Desc], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (3, N'STU', N'How mobile and comfortable are the desks/tables and chairs in the spaces you use?', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[QuestionnaireGroup] ([QnsGroupID], [Category], [Desc], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (4, N'STU', N'Overall learning experience', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[QuestionnaireGroup] ([QnsGroupID], [Category], [Desc], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (5, N'LEC', N'To what extent do you agree with the following statements about the learning environment?', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[QuestionnaireGroup] ([QnsGroupID], [Category], [Desc], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (6, N'LEC', N'How well can you hear when you teach in L.530?', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[QuestionnaireGroup] ([QnsGroupID], [Category], [Desc], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (7, N'LEC', N'Thinking about your current teaching, how often do you actually use the following spatial arrangements?', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[QuestionnaireGroup] ([QnsGroupID], [Category], [Desc], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (8, N'LEC', N'If they were readily available, how often would you use the following spatial arrangements to support your approach to learning and teaching?', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[QuestionnaireGroup] ([QnsGroupID], [Category], [Desc], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (9, N'LEC', N'While teaching in L530, how often do you:', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[QuestionnaireGroup] ([QnsGroupID], [Category], [Desc], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (10, N'LEC', N'Does the learning space in L530 supports or hinders the use of different spatial settings, how much do you agree with the following statements?', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[QuestionnaireGroup] ([QnsGroupID], [Category], [Desc], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (11, N'LEC', N'How often do you use the following technologies in L530?', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[QuestionnaireGroup] ([QnsGroupID], [Category], [Desc], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (12, N'LEC', N'If they were readily available, how often would you use the following technologies in the spaces/rooms in which you teach?', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[QuestionnaireGroup] OFF
GO
INSERT [dbo].[SensorDevice] ([DeviceID], [DeviceMAC], [DeviceName], [FacilityID], [DevicePosition], [FirstSeen], [LastHeard], [LastHeartBeat], [AlarmRecognition], [PowerSaveMode], [ListeningMode], [ActiveStatus], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'60f827aad7710d21b6b3f91d', N'704a0e648d6c', N'Front Middle', N'60dd25fc41c10d28a00d9833', N'FM', CAST(N'2021-07-21T21:56:58.000' AS DateTime), CAST(N'2021-08-18T02:45:22.000' AS DateTime), CAST(N'2021-08-18T02:45:23.000' AS DateTime), N'on', N'off', N'interval', N'True', N'admin1', CAST(N'2021-08-18T03:32:23.603' AS DateTime), NULL, NULL)
INSERT [dbo].[SensorDevice] ([DeviceID], [DeviceMAC], [DeviceName], [FacilityID], [DevicePosition], [FirstSeen], [LastHeard], [LastHeartBeat], [AlarmRecognition], [PowerSaveMode], [ListeningMode], [ActiveStatus], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'60fa85cf1c60f7489badcb45', N'704a0e64b9b4', N'BackRight', N'60dd25fc41c10d28a00d9833', N'BR', CAST(N'2021-07-23T17:03:11.000' AS DateTime), CAST(N'2021-08-18T02:50:17.000' AS DateTime), CAST(N'2021-08-18T02:50:17.000' AS DateTime), N'on', N'off', N'interval', N'True', N'admin1', CAST(N'2021-08-18T03:32:23.603' AS DateTime), NULL, NULL)
INSERT [dbo].[SensorDevice] ([DeviceID], [DeviceMAC], [DeviceName], [FacilityID], [DevicePosition], [FirstSeen], [LastHeard], [LastHeartBeat], [AlarmRecognition], [PowerSaveMode], [ListeningMode], [ActiveStatus], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'f57332jf4432423asayKKj_dmy', N'704a0e64d9Q_dmy', N'sensorA_dmy', N'L504_dmyid', N'CM', CAST(N'2021-08-23T18:42:00.393' AS DateTime), CAST(N'2021-08-23T18:42:00.393' AS DateTime), CAST(N'2021-08-23T18:42:00.393' AS DateTime), N'interval', N'off', N'off', N'True', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
INSERT [dbo].[SensorDevice] ([DeviceID], [DeviceMAC], [DeviceName], [FacilityID], [DevicePosition], [FirstSeen], [LastHeard], [LastHeartBeat], [AlarmRecognition], [PowerSaveMode], [ListeningMode], [ActiveStatus], [CreateBy], [CreateDate], [AmendBy], [AmendDate]) VALUES (N'g7fdfe34qasssfas19iuVx_dmy', N'704a8nnhz9S_dmy', N'sensorB_dmy', N'L504_dmyid', N'CM', CAST(N'2021-08-23T18:42:00.393' AS DateTime), CAST(N'2021-08-23T18:42:00.393' AS DateTime), CAST(N'2021-08-23T18:42:00.393' AS DateTime), N'interval', N'off', N'off', N'True', N'admin1', CAST(N'2021-06-05T16:31:52.537' AS DateTime), NULL, NULL)
GO
ALTER TABLE [dbo].[AccessRgts]  WITH CHECK ADD  CONSTRAINT [FK_AccessRgts_ProgID] FOREIGN KEY([ProgID])
REFERENCES [dbo].[Program] ([ProgID])
GO
ALTER TABLE [dbo].[AccessRgts] CHECK CONSTRAINT [FK_AccessRgts_ProgID]
GO
ALTER TABLE [dbo].[Facility]  WITH CHECK ADD  CONSTRAINT [FK_Facility_ProjPhaseID] FOREIGN KEY([ProjPhaseID])
REFERENCES [dbo].[ProjectPhase] ([ProjPhaseID])
GO
ALTER TABLE [dbo].[Facility] CHECK CONSTRAINT [FK_Facility_ProjPhaseID]
GO
ALTER TABLE [dbo].[Lesson]  WITH CHECK ADD  CONSTRAINT [FK_Lesson_FacilityID] FOREIGN KEY([FacilityID])
REFERENCES [dbo].[Facility] ([FacilityID])
GO
ALTER TABLE [dbo].[Lesson] CHECK CONSTRAINT [FK_Lesson_FacilityID]
GO
ALTER TABLE [dbo].[Questionnaire]  WITH CHECK ADD  CONSTRAINT [FK_Questionnaire_QnsGroupID] FOREIGN KEY([QnsGroupID])
REFERENCES [dbo].[QuestionnaireGroup] ([QnsGroupID])
GO
ALTER TABLE [dbo].[Questionnaire] CHECK CONSTRAINT [FK_Questionnaire_QnsGroupID]
GO
ALTER TABLE [dbo].[Response]  WITH CHECK ADD  CONSTRAINT [FK_Response_FacilityID] FOREIGN KEY([FacilityID])
REFERENCES [dbo].[Facility] ([FacilityID])
GO
ALTER TABLE [dbo].[Response] CHECK CONSTRAINT [FK_Response_FacilityID]
GO
ALTER TABLE [dbo].[Response]  WITH CHECK ADD  CONSTRAINT [FK_Response_QnsID] FOREIGN KEY([QnsID])
REFERENCES [dbo].[Questionnaire] ([QnsID])
GO
ALTER TABLE [dbo].[Response] CHECK CONSTRAINT [FK_Response_QnsID]
GO
ALTER TABLE [dbo].[SensorDevice]  WITH CHECK ADD  CONSTRAINT [FK_SensorDevice_FacilityID] FOREIGN KEY([FacilityID])
REFERENCES [dbo].[Facility] ([FacilityID])
GO
ALTER TABLE [dbo].[SensorDevice] CHECK CONSTRAINT [FK_SensorDevice_FacilityID]
GO
ALTER TABLE [dbo].[SensorReading]  WITH CHECK ADD  CONSTRAINT [FK_SensorReading_DeviceID] FOREIGN KEY([DeviceID])
REFERENCES [dbo].[SensorDevice] ([DeviceID])
GO
ALTER TABLE [dbo].[SensorReading] CHECK CONSTRAINT [FK_SensorReading_DeviceID]
GO
/****** Object:  StoredProcedure [dbo].[addAccessRgts]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addAccessRgts]
	@ProgID int,
	@LoginID varchar(20),
	@CreateBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
			INSERT INTO AccessRgts VALUES (@ProgID, @LoginID, @CreateBy, GETDATE(), NULL, NULL)
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[addAppUser]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addAppUser]
	@LoginID varchar(20),
	@Email varchar(30),
	@PasswordHash varchar(100),
	@PasswordSalt varchar(50),
	@IV varchar(100),
	@Key varchar(100),
	@UsrName varchar(20),
	@UsrShtName varchar(20),
	@UsrType varchar(20),
	@UsrRole varchar(20),
	@UsrStatus varchar(20),
	@LockStatus varchar(20),
	@AccessRgt varchar(20),
	@AccessRgtGrp varchar(20),
	@CreateBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
			INSERT INTO AppUser VALUES (@LoginID, @Email, @PasswordHash, @PasswordSalt, @IV, @Key, @UsrName, @UsrShtName, @UsrType, @UsrRole, @UsrStatus, @LockStatus, NULL, NULL, GETDATE(), @AccessRgt, @AccessRgtGrp, @CreateBy, GETDATE(), NULL, NULL)
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[addFacility]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addFacility]
	@FacilityID varchar(50),
	@FacilityCode varchar(20),
	@ProjPhaseID int,
	@CreateBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
			INSERT INTO Facility VALUES(@FacilityID, @FacilityCode, @ProjPhaseID, @CreateBy, GETDATE(), NULL, NULL)
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[addLesson]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addLesson]
	@LessonType varchar(20) NULL,
	@ModuleCode varchar(20) NULL,
	@ModuleGrp1 varchar(20) NULL,
	@ModuleGrp2 varchar(20) NULL,
	@ModuleGrp3 varchar(20) NULL,
	@ModuleGrp4 varchar(20) NULL,
	@ModuleGrp5 varchar(20) NULL,
	@ModuleGrp6 varchar(20) NULL,
	@ModuleGrp7 varchar(20) NULL,
	@ModuleGrp8 varchar(20) NULL,
	@TIC1 varchar(20) NULL,
	@TIC2 varchar(20) NULL,
	@TIC3 varchar(20) NULL,
	@TIC4 varchar(20) NULL,
	@FacilityID varchar(50) NULL,
	@DayOfWeek varchar(20) NULL,
	@ELearnEvenWeek varchar(20) NULL,
	@TimeStart datetime NULL,
	@TimeEnd datetime NULL,
	@WeekStart int NULL,
	@WeekEnd int NULL,
	@Semester varchar(20) NULL,
	@CreateBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		INSERT INTO [dbo].[Lesson] VALUES (@LessonType, @ModuleCode, @ModuleGrp1, @ModuleGrp2, @ModuleGrp3, @ModuleGrp4, @ModuleGrp5, @ModuleGrp6, @ModuleGrp7, @ModuleGrp8, @TIC1, @TIC2, @TIC3, @TIC4, @FacilityID, @DayOfWeek, @ELearnEvenWeek, @TimeStart, @TimeEnd, @WeekStart, @WeekEnd, @Semester, @CreateBy, GETDATE(), NULL, NULL)
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[addParameter]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addParameter]
	@ParaCode1 varchar(20),
	@ParaCode2 varchar(20),
	@ParaCode3 varchar(20),
	@Desc1 varchar(100),
	@Desc2 varchar(100),
	@CreateBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            INSERT INTO Parameter VALUES (@ParaCode1, @ParaCode2, @ParaCode3, @Desc1, @Desc2, @CreateBy, GETDATE(), NULL, NULL)
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[addProgram]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addProgram]
	@ProgName varchar(20),
	@ProgDesc varchar(50),
	@CreateBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            INSERT INTO Program VALUES (@ProgName, @ProgDesc, @CreateBy, GETDATE(), NULL, NULL)
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[addProjectPhase]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addProjectPhase]
	@ProjPhaseID int,
	@StartDate datetime,
	@EndDate datetime,
	@ProjectLead varchar(20),
	@Member2 varchar(20),
	@Member3 varchar(20),
	@Member4 varchar(20),
	@ProjectSupervisor varchar(20),
	@CreateBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            INSERT INTO ProjectPhase VALUES (@ProjPhaseID, @StartDate, @EndDate, @ProjectLead, @Member2, @Member3, @Member4, @ProjectSupervisor, @CreateBy, GETDATE(), NULL, NULL)
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[addQuestionnaire]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addQuestionnaire]
	@QnsNo int,
	@Type varchar(20),
	@Category varchar(20),
	@Desc varchar(200),
	@HasQnsGroup varchar(20),
	@QnsGroupID int,
	@Optional varchar(20),
	@CreateBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		INSERT INTO Questionnaire VALUES (@QnsNo, @Type, @Category, @Desc, @HasQnsGroup, @QnsGroupID, @Optional, @CreateBy, GETDATE(), NULL, NULL)
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[addResponse]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addResponse]
	@ResponseID varchar(50),
	@DateTimeStamp datetime,
	@FacilityID varchar(50),
	@RespondentID varchar(20),
	@QnsID int,
	@RespDesc varchar(200),
	@CreateBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            INSERT INTO Response VALUES (@ResponseID, @DateTimeStamp, @FacilityID, @RespondentID, @QnsID, @RespDesc, @CreateBy, GETDATE(), NULL, NULL)
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[addSensorDevice]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addSensorDevice]
@DeviceID varchar(50), 
@DeviceMAC varchar(20), 
@DeviceName varchar(50), 
@FacilityID varchar(50),
@DevicePosition varchar(20),
@FirstSeen datetime,
@LastHeard datetime,
@LastHeartBeat datetime,
@AlarmRecognition varchar(20), 
@PowerSaveMode varchar(20), 
@ListeningMode varchar(20),
@ActiveStatus varchar(20),
@CreateBy varchar(20),
@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		INSERT INTO [dbo].[SensorDevice] VALUES (@DeviceID, @DeviceMAC, @DeviceName, @FacilityID, @DevicePosition, @FirstSeen, @LastHeard, @LastHeartBeat, @AlarmRecognition, @PowerSaveMode, @ListeningMode, @ActiveStatus, @CreateBy, GETDATE(), NULL, NULL)
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[addSensorReading]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addSensorReading]
	@DateTimeStamp datetime,
	@Sound float,
	@Humidity float,
	@Temperature float,
	@Motion float,
	@DeviceID varchar(50),
	@CreateBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		INSERT INTO SensorReading VALUES (@DateTimeStamp, @Sound, @Humidity, @Temperature, @Motion, @DeviceID,  @CreateBy, GETDATE(), NULL, NULL)
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;

		RETURN ERROR_MESSAGE();
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[addStudent]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addStudent]
@AdminNo varchar(20), 
@PEMGrp varchar(20), 
@Course varchar(20), 
@Age int, 
@Gender varchar(20), 
@GPAS1 float,
@GPAS2 float, 
@CreateBy varchar(20),
@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		INSERT INTO [dbo].[Student] VALUES (@AdminNo, @PEMGrp, @Course, @Age, @Gender, @GPAS1, @GPAS2, @CreateBy, GETDATE(), NULL, NULL)
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[delAccessRgts]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[delAccessRgts]
	@AccessID int,
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            DELETE AccessRgts WHERE AccessID =  @AccessID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[delAppUser]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[delAppUser]
	@LoginID varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            DELETE AppUser WHERE LoginID =  @LoginID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[delFacility]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[delFacility]
	@FacilityID varchar(50),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            DELETE Facility WHERE FacilityID =  @FacilityID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[delLesson]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[delLesson]
@LessonID int, 
@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		DELETE [dbo].[Lesson] WHERE LessonID =  @LessonID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[delParameter]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[delParameter]
	@ParaCode1 varchar(20),
	@ParaCode2 varchar(20),
	@ParaCode3 varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            DELETE Parameter WHERE ParaCode1 = @Paracode1 AND ParaCode2 = @Paracode2 AND ParaCode3 = @Paracode3
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		PRINT ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[delProgram]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[delProgram]
	@ProgID int,
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            DELETE Program WHERE ProgID =  @ProgID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[delProjectPhase]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[delProjectPhase]
	@ProjPhaseID int,
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            DELETE ProjectPhase WHERE ProjPhaseID =  @ProjPhaseID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[delQuestionnaire]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[delQuestionnaire]
	@QnsID int,
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		 DELETE Questionnaire WHERE QnsID =  @QnsID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[delSensorDevice]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delSensorDevice]
@DeviceID varchar(50), 
@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		DELETE SensorDevice WHERE DeviceID =  @DeviceID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[delStudent]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[delStudent]
@StudentID int, 
@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		DELETE Student WHERE StudentID =  @StudentID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[updAppUser]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updAppUser]
	@LoginID varchar(20),
	@Email varchar(30),
	@PasswordHash varchar(100),
	@PasswordSalt varchar(50),
	@IV varchar(100),
	@Key varchar(100),
	@UsrName varchar(20),
	@UsrShtName varchar(20),
	@UsrType varchar(20),
	@UsrRole varchar(20),
	@UsrStatus varchar(20),
	@LockStatus varchar(20),
	@LockUntil datetime,
	@LastLogin datetime,
	@LastPwdSet datetime,
	@AccessRgt varchar(20),
	@AccessRgtGrp varchar(20),
	@AmendBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            UPDATE AppUser SET Email = @Email, UsrName = @UsrName, UsrShtName = @UsrShtName, PasswordHash = @PasswordHash, PasswordSalt = @PasswordSalt, IV = @IV, [Key] = @Key, UsrType = @UsrType, UsrRole = @UsrRole, UsrStatus = @UsrStatus, LockStatus = @LockStatus, LockUntil = @LockUntil, LastLogin = @LastLogin, LastPwdSet = @LastPwdSet, AccessRgt = @AccessRgt, AccessRgtGrp = @AccessRgtGrp, AmendBy = @AmendBy, AmendDate = GETDATE() WHERE LoginID = @LoginID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[updFacility]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updFacility]
	@FacilityID varchar(50),
	@FacilityCode varchar(20),
	@ProjPhaseID int,
	@AmendBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            UPDATE Facility SET FacilityCode = @FacilityCode, ProjPhaseID = @ProjPhaseID, AmendBy = @AmendBy, AmendDate = GETDATE() WHERE FacilityID = @FacilityID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[updLesson]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updLesson]
	@LessonID int NULL,
	@LessonType varchar(20) NULL,
	@ModuleCode varchar(20) NULL,
	@ModuleGrp1 varchar(20) NULL,
	@ModuleGrp2 varchar(20) NULL,
	@ModuleGrp3 varchar(20) NULL,
	@ModuleGrp4 varchar(20) NULL,
	@ModuleGrp5 varchar(20) NULL,
	@ModuleGrp6 varchar(20) NULL,
	@ModuleGrp7 varchar(20) NULL,
	@ModuleGrp8 varchar(20) NULL,
	@TIC1 varchar(20) NULL,
	@TIC2 varchar(20) NULL,
	@TIC3 varchar(20) NULL,
	@TIC4 varchar(20) NULL,
	@FacilityID varchar(50) NULL,
	@DayOfWeek varchar(20) NULL,
	@ELearnEvenWeek varchar(20) NULL,
	@TimeStart datetime NULL,
	@TimeEnd datetime NULL,
	@WeekStart int NULL,
	@WeekEnd int NULL,
	@Semester varchar(20) NULL,
	@AmendBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		UPDATE [dbo].[Lesson] SET LessonType = @LessonType, ModuleCode = @ModuleCode, ModuleGrp1 = @ModuleGrp1, ModuleGrp2 = @ModuleGrp2, ModuleGrp3 = @ModuleGrp3, ModuleGrp4 = @ModuleGrp4, ModuleGrp5 = @ModuleGrp5, ModuleGrp6 = @ModuleGrp6, ModuleGrp7 = @ModuleGrp7, ModuleGrp8 = @ModuleGrp8, TIC1 = @TIC1, TIC2 = @TIC2, TIC3 = @TIC3, TIC4 = @TIC4, FacilityID =  @FacilityID, [DayOfWeek] = @DayOfWeek, ELearnEvenWeek = @ELearnEvenWeek, TimeStart = @TimeStart, TimeEnd = @TimeEnd, WeekStart = @WeekStart, WeekEnd = @WeekEnd, Semester = @Semester, AmendBy = @AmendBy, AmendDate = GETDATE() WHERE LessonID =  @LessonID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[updParameter]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updParameter]
	@ParaCode1 varchar(20),
	@ParaCode2 varchar(20),
	@ParaCode3 varchar(20),
	@Desc1 varchar(100),
	@Desc2 varchar(100),
	@AmendBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            UPDATE Parameter SET Desc1 = @Desc1, Desc2 = @Desc2, AmendBy = @AmendBy, AmendDate = GETDATE() WHERE ParaCode1 = @Paracode1 AND ParaCode2 = @Paracode2 AND ParaCode3 = @Paracode3
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[updProgram]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updProgram]
	@ProgID int,
	@ProgName varchar(20),
	@ProgDesc varchar(50),
	@AmendBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            UPDATE Program SET ProgName = @ProgName, ProgDesc = @ProgDesc, AmendBy = @AmendBy, AmendDate = GETDATE() WHERE ProgID = @ProgID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[updProjectPhase]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updProjectPhase]
	@ProjPhaseID int,
	@StartDate datetime,
	@EndDate datetime,
	@ProjectLead varchar(20),
	@Member2 varchar(20),
	@Member3 varchar(20),
	@Member4 varchar(20),
	@ProjectSupervisor varchar(20),
	@AmendBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
            UPDATE ProjectPhase SET StartDate = @StartDate, EndDate = @EndDate, ProjectLead = @ProjectLead, Member2 = @Member2, Member3 = @Member3, Member4 = @Member4,  ProjectSupervisor = @ProjectSupervisor, AmendBy = @AmendBy, AmendDate = GETDATE() WHERE ProjPhaseID = @ProjPhaseID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[updQuestionnaire]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updQuestionnaire]
	@QnsID int,
	@QnsNo int,
	@Type varchar(20),
	@Category varchar(20),
	@Desc varchar(200),
	@HasQnsGroup varchar(20),
	@QnsGroupID int,
	@Optional varchar(20),
	@AmendBy varchar(20),
	@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		 UPDATE Questionnaire SET [QnsNo] = @QnsNo, [Type] = @Type, Category = @Category, [Desc] = @Desc, HasQnsGroup = @HasQnsGroup, QnsGroupID = @QnsGroupID, Optional = @Optional, AmendBy = @AmendBy, AmendDate = GETDATE() WHERE QnsID = @QnsID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[updSensorDevice]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updSensorDevice]
@DeviceID varchar(50),
@DeviceMAC varchar(20), 
@DeviceName varchar(50), 
@FacilityID varchar(50),
@DevicePosition varchar(20),
@FirstSeen datetime,
@LastHeard datetime,
@LastHeartBeat datetime,
@AlarmRecognition varchar(20),
@PowerSaveMode varchar(20), 
@ListeningMode varchar(20),
@ActiveStatus varchar(20),
@AmendBy varchar(20),
@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		UPDATE SensorDevice SET DeviceMAC = @DeviceMAC, DeviceName = @DeviceName, FacilityID = @FacilityID, DevicePosition = @DevicePosition, FirstSeen = @FirstSeen, LastHeard = @LastHeard, LastHeartBeat = @LastHeartBeat, AlarmRecognition = @AlarmRecognition, PowerSaveMode = @PowerSaveMode, ListeningMode = @ListeningMode, ActiveStatus = @ActiveStatus, AmendBy = @AmendBy, AmendDate = GETDATE() WHERE DeviceID = @DeviceID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
/****** Object:  StoredProcedure [dbo].[updStudent]    Script Date: 23/8/2021 6:43:19 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updStudent]
@StudentID int,
@AdminNo varchar(20), 
@PEMGrp varchar(20), 
@Course varchar(20), 
@Age int, 
@Gender varchar(20), 
@GPAS1 float,
@GPAS2 float, 
@AmendBy varchar(20),
@RtnValue int OUTPUT
AS
SET @RtnValue = 0
BEGIN
	BEGIN TRY
		UPDATE Student SET AdminNo = @AdminNo, PEMGrp = @PEMGrp, Course = @Course, Age = @Age, Gender = @Gender, GPAS1 = @GPAS1, GPAS2 = @GPAS2, AmendBy = @AmendBy, AmendDate = GETDATE() WHERE StudentID =  @StudentID
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION; 
		IF ((ERROR_SEVERITY()) > 16)
			SET @RtnValue = 2;
		ELSE
			SET @RtnValue = 1;
		RETURN ERROR_MESSAGE()
	END CATCH

	RETURN @RtnValue
END
GO
USE [master]
GO
ALTER DATABASE [LSA_DB] SET  READ_WRITE 
GO
