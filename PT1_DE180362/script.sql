USE [master]
GO
/****** Object:  Database [Books_DE180362]    Script Date: 02/10/2024 14:58:59 ******/
CREATE DATABASE [Books_DE180362]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Books_DE180362', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Books_DE180362.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Books_DE180362_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Books_DE180362_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Books_DE180362] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Books_DE180362].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Books_DE180362] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Books_DE180362] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Books_DE180362] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Books_DE180362] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Books_DE180362] SET ARITHABORT OFF 
GO
ALTER DATABASE [Books_DE180362] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Books_DE180362] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Books_DE180362] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Books_DE180362] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Books_DE180362] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Books_DE180362] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Books_DE180362] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Books_DE180362] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Books_DE180362] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Books_DE180362] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Books_DE180362] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Books_DE180362] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Books_DE180362] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Books_DE180362] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Books_DE180362] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Books_DE180362] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Books_DE180362] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Books_DE180362] SET RECOVERY FULL 
GO
ALTER DATABASE [Books_DE180362] SET  MULTI_USER 
GO
ALTER DATABASE [Books_DE180362] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Books_DE180362] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Books_DE180362] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Books_DE180362] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Books_DE180362] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Books_DE180362] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Books_DE180362', N'ON'
GO
ALTER DATABASE [Books_DE180362] SET QUERY_STORE = ON
GO
ALTER DATABASE [Books_DE180362] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Books_DE180362]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 02/10/2024 14:58:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[id] [int] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[author] [nvarchar](255) NOT NULL,
	[publication_date] [date] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK__Books__3213E83F3B5E9E9B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loans]    Script Date: 02/10/2024 14:58:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loans](
	[id] [int] NOT NULL,
	[book_id] [int] NULL,
	[borrower_name] [varchar](255) NOT NULL,
	[loan_date] [date] NOT NULL,
	[return_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Books] ([id], [title], [author], [publication_date], [quantity]) VALUES (1, N'Nắng', N'Huân', CAST(N'2002-09-10' AS Date), 182)
INSERT [dbo].[Books] ([id], [title], [author], [publication_date], [quantity]) VALUES (2, N'1984', N'George Orwell', CAST(N'1949-06-08' AS Date), 5)
INSERT [dbo].[Books] ([id], [title], [author], [publication_date], [quantity]) VALUES (3, N'To Kill a Mockingbird', N'Harper Lee', CAST(N'1960-07-11' AS Date), 2)
INSERT [dbo].[Books] ([id], [title], [author], [publication_date], [quantity]) VALUES (4, N'Pride and Prejudice', N'Jane Austen', CAST(N'1813-01-28' AS Date), 4)
INSERT [dbo].[Books] ([id], [title], [author], [publication_date], [quantity]) VALUES (5, N'Moby-Dick', N'Herman Melville', CAST(N'1851-10-18' AS Date), 1)
INSERT [dbo].[Books] ([id], [title], [author], [publication_date], [quantity]) VALUES (6, N'The Great Gatsby', N'F. Scott Fitzgerald', CAST(N'1925-04-10' AS Date), 3)
GO
INSERT [dbo].[Loans] ([id], [book_id], [borrower_name], [loan_date], [return_date]) VALUES (1, 1, N'Alice Johnson', CAST(N'2024-09-01' AS Date), CAST(N'2024-09-15' AS Date))
INSERT [dbo].[Loans] ([id], [book_id], [borrower_name], [loan_date], [return_date]) VALUES (2, 2, N'Bob Smith', CAST(N'2024-09-10' AS Date), CAST(N'2024-09-20' AS Date))
INSERT [dbo].[Loans] ([id], [book_id], [borrower_name], [loan_date], [return_date]) VALUES (3, 3, N'Charlie Brown', CAST(N'2024-09-05' AS Date), CAST(N'2024-09-12' AS Date))
INSERT [dbo].[Loans] ([id], [book_id], [borrower_name], [loan_date], [return_date]) VALUES (4, 4, N'Diana Prince', CAST(N'2024-09-15' AS Date), CAST(N'2024-09-25' AS Date))
INSERT [dbo].[Loans] ([id], [book_id], [borrower_name], [loan_date], [return_date]) VALUES (5, 5, N'Eve Adams', CAST(N'2024-09-12' AS Date), CAST(N'2024-09-30' AS Date))
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD  CONSTRAINT [FK__Loans__book_id__398D8EEE] FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([id])
GO
ALTER TABLE [dbo].[Loans] CHECK CONSTRAINT [FK__Loans__book_id__398D8EEE]
GO
USE [master]
GO
ALTER DATABASE [Books_DE180362] SET  READ_WRITE 
GO
