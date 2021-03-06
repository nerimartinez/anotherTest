USE [master]
GO
/****** Object:  Database [avnon]    Script Date: 5/9/2016 11:08:06 PM ******/
CREATE DATABASE [avnon]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'avnon', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\avnon.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'avnon_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\avnon_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [avnon] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [avnon].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [avnon] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [avnon] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [avnon] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [avnon] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [avnon] SET ARITHABORT OFF 
GO
ALTER DATABASE [avnon] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [avnon] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [avnon] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [avnon] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [avnon] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [avnon] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [avnon] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [avnon] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [avnon] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [avnon] SET  DISABLE_BROKER 
GO
ALTER DATABASE [avnon] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [avnon] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [avnon] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [avnon] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [avnon] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [avnon] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [avnon] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [avnon] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [avnon] SET  MULTI_USER 
GO
ALTER DATABASE [avnon] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [avnon] SET DB_CHAINING OFF 
GO
ALTER DATABASE [avnon] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [avnon] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [avnon] SET DELAYED_DURABILITY = DISABLED 
GO
USE [avnon]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 5/9/2016 11:08:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contact](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](200) NULL,
	[Email] [varchar](100) NULL,
	[Phone] [varchar](50) NULL,
	[Skype] [varchar](50) NULL,
	[CompanyName] [varchar](100) NULL,
	[Position] [varchar](100) NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContactTag]    Script Date: 5/9/2016 11:08:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NULL,
	[TagId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tag]    Script Date: 5/9/2016 11:08:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
 CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Contact] ON 

INSERT [dbo].[Contact] ([Id], [FirstName], [LastName], [Email], [Phone], [Skype], [CompanyName], [Position]) VALUES (1, N'John', N'William', N'john@sample1.com', N'12345678', N'JohnW', N'Sample Company 1', N'CEO')
INSERT [dbo].[Contact] ([Id], [FirstName], [LastName], [Email], [Phone], [Skype], [CompanyName], [Position]) VALUES (2, N'Susan', N'Green', N'susang@sample2.com', N'48225684', N'SusanG', N'Sample Company 2', N'Marketing Manager')
INSERT [dbo].[Contact] ([Id], [FirstName], [LastName], [Email], [Phone], [Skype], [CompanyName], [Position]) VALUES (3, N'Sam', N'Smith', N'sams@sample3.com', N'7895556884', N'SanS', N'Sample Company 3', N'Tech Director')
SET IDENTITY_INSERT [dbo].[Contact] OFF
SET IDENTITY_INSERT [dbo].[ContactTag] ON 

INSERT [dbo].[ContactTag] ([Id], [ContactId], [TagId]) VALUES (179, 1, 93)
INSERT [dbo].[ContactTag] ([Id], [ContactId], [TagId]) VALUES (180, 2, 94)
INSERT [dbo].[ContactTag] ([Id], [ContactId], [TagId]) VALUES (181, 2, 93)
INSERT [dbo].[ContactTag] ([Id], [ContactId], [TagId]) VALUES (182, 3, 96)
INSERT [dbo].[ContactTag] ([Id], [ContactId], [TagId]) VALUES (183, 3, 95)
SET IDENTITY_INSERT [dbo].[ContactTag] OFF
SET IDENTITY_INSERT [dbo].[Tag] ON 

INSERT [dbo].[Tag] ([Id], [Name]) VALUES (93, N'Business Associates')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (94, N'Team Member')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (95, N'Marketing Team')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (96, N'Executive Team')
SET IDENTITY_INSERT [dbo].[Tag] OFF
ALTER TABLE [dbo].[ContactTag]  WITH CHECK ADD  CONSTRAINT [FK_ContactTag_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [dbo].[ContactTag] CHECK CONSTRAINT [FK_ContactTag_Contact]
GO
ALTER TABLE [dbo].[ContactTag]  WITH CHECK ADD  CONSTRAINT [FK_ContactTag_Tag] FOREIGN KEY([TagId])
REFERENCES [dbo].[Tag] ([Id])
GO
ALTER TABLE [dbo].[ContactTag] CHECK CONSTRAINT [FK_ContactTag_Tag]
GO
/****** Object:  StoredProcedure [dbo].[AddContactTag]    Script Date: 5/9/2016 11:08:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddContactTag]
	-- Add the parameters for the stored procedure here
	@TagId int,	
	@ContactId int
AS
BEGIN	
	INSERT INTO dbo.ContactTag (ContactId, TagId) VALUES (@ContactId, @TagId)
END

GO
/****** Object:  StoredProcedure [dbo].[AddTag]    Script Date: 5/9/2016 11:08:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddTag]
	-- Add the parameters for the stored procedure here
	@Name varchar (100)
AS
BEGIN
	INSERT INTO DBO.Tag (Name) VALUES (@Name);
	SELECT SCOPE_IDENTITY();
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteContactTag]    Script Date: 5/9/2016 11:08:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteContactTag]
	-- Add the parameters for the stored procedure here
	@TagId int,	
	@ContactId int
AS
BEGIN	
	DELETE FROM dbo.ContactTag 
	WHERE ContactId = @ContactId AND  TagId = @TagId
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteTag]    Script Date: 5/9/2016 11:08:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteTag]
	-- Add the parameters for the stored procedure here
	@Id int	
AS
BEGIN	
	DELETE FROM dbo.ContactTag 
	WHERE TagId = @Id

	DELETE FROM dbo.Tag 
	WHERE Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[EditTag]    Script Date: 5/9/2016 11:08:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EditTag]
	-- Add the parameters for the stored procedure here
	@Id int,
	@Name varchar (100)
AS
BEGIN	
	UPDATE dbo.Tag 
    SET Name = @Name
    WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllTags]    Script Date: 5/9/2016 11:08:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllTags] 
	
AS
BEGIN
	
	SET NOCOUNT ON;
	    
	SELECT * FROM dbo.Tag
END

GO
/****** Object:  StoredProcedure [dbo].[GetContactsWithTagIds]    Script Date: 5/9/2016 11:08:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetContactsWithTagIds] 
	
AS
BEGIN	
	  SELECT Con.Id, Con.FirstName, Con.LastName, Con.Email, Con.Phone, Con.Skype, Con.CompanyName, Con.Position ,TagIds = 
    STUFF((SELECT ', ' + CONVERT(varchar(10), CT.TagId)
           FROM dbo.ContactTag as CT
           WHERE Con.Id = CT.ContactId 
          FOR XML PATH('')), 1, 2, '')
FROM dbo.Contact as Con     
END

GO
USE [master]
GO
ALTER DATABASE [avnon] SET  READ_WRITE 
GO
