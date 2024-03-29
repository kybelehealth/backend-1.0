USE [Hera]
GO
/****** Object:  UserDefinedFunction [dbo].[db_GetGenderByLang]    Script Date: 11/19/2019 14:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[db_GetGenderByLang](@MemberId int)Returns nvarchar(50)
As
Begin
	Declare @Result nvarchar(50)
	Declare @Lang nvarchar(50),@Gender nvarchar(50)
	Select @Lang = ISNULL(Language,'en'),@Gender=Gender From Member Where Id=@MemberId
	If @Lang='tr'
		Begin
			Select @Result = CASE WHEN @Gender = 'FEMALE' THEN 'Kadın' Else 'Erkek' End
		End
	Else If @Lang='en'
		Begin
			Select @Result = CASE WHEN @Gender = 'FEMALE' THEN 'Female' Else 'Male' End
		End
	Else
		Begin
			Select @Result = CASE WHEN @Gender = 'FEMALE' THEN 'أنثى' Else 'ذكر' End
		End
	
	Return @Result
End
GO
/****** Object:  UserDefinedFunction [dbo].[fn_CalcDistanceKM]    Script Date: 11/19/2019 14:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[fn_CalcDistanceKM](@lat1 FLOAT, @lat2 FLOAT, @lon1 FLOAT, @lon2 FLOAT)
RETURNS FLOAT 
AS
BEGIN

    RETURN ACOS(SIN(PI()*@lat1/180.0)*SIN(PI()*@lat2/180.0)+COS(PI()*@lat1/180.0)*COS(PI()*@lat2/180.0)*COS(PI()*@lon2/180.0-PI()*@lon1/180.0))*6371
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_TruncDate]    Script Date: 11/19/2019 14:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_TruncDate](@Date DATETIME) RETURNS DATETIME    
AS    
BEGIN    
  RETURN(convert(CHAR(8), @Date, 112))    
END
GO
/****** Object:  UserDefinedFunction [dbo].[IsInteger]    Script Date: 11/19/2019 14:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[IsInteger](@Value VarChar(18))
Returns Bit
As 
Begin  
  Declare @Result bit = 0
  SELECT @Result = CASE WHEN ISNUMERIC(@Value) = 1
        THEN CASE WHEN ROUND(@Value,0,1) = @Value
            THEN 1
            ELSE 0
            END
        ELSE 0
        END
  Return @Result
End
GO
/****** Object:  Table [dbo].[App_Screen]    Script Date: 11/19/2019 14:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[App_Screen](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_App_Screen] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[App_Screen_Category]    Script Date: 11/19/2019 14:38:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[App_Screen_Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_App_Screen_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[App_Screen_Text]    Script Date: 11/19/2019 14:38:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[App_Screen_Text](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ScreenId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[IsError] [bit] NOT NULL,
	[Label] [nvarchar](50) NOT NULL,
	[Translation] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_App_Screen_Text] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 11/19/2019 14:38:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ParentId] [int] NOT NULL,
	[Picture] [nvarchar](500) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category_Media]    Script Date: 11/19/2019 14:38:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category_Media](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[MediaTypeId] [int] NOT NULL,
	[FileUrl] [nvarchar](500) NOT NULL,
	[Media] [nvarchar](50) NOT NULL,
	[OrderNo] [int] NOT NULL,
 CONSTRAINT [PK_Category_Media] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category_Question]    Script Date: 11/19/2019 14:38:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category_Question](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Question] [nvarchar](500) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[OrderNo] [int] NOT NULL,
	[AnswerTypeId] [int] NOT NULL,
	[IsConnected] [bit] NOT NULL,
	[ConnectedQuestionId] [int] NULL,
	[ConnectedAnswerId] [int] NULL,
	[AnswerDataTypeId] [int] NULL,
 CONSTRAINT [PK_Category_Question] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category_Question_Answer]    Script Date: 11/19/2019 14:38:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category_Question_Answer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[DataTypeId] [int] NOT NULL,
	[Answer] [nvarchar](500) NOT NULL,
	[OrderNo] [int] NOT NULL,
	[IsDefault] [bit] NOT NULL,
 CONSTRAINT [PK_Category_Question_Answer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CMS_Content]    Script Date: 11/19/2019 14:38:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Content](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[ParentId] [int] NOT NULL,
	[OrderNo] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Picture] [nvarchar](500) NULL,
 CONSTRAINT [PK_CMS_Content] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CMS_Content_Detail]    Script Date: 11/19/2019 14:38:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Content_Detail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContentId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Abstract] [nvarchar](500) NULL,
	[ContentHtml] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_Content_Detail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CMS_Content_Detail_Log]    Script Date: 11/19/2019 14:38:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Content_Detail_Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [int] NOT NULL,
	[ContentId] [int] NOT NULL,
	[ContentDetailId] [int] NOT NULL,
	[OpenTime] [datetime] NOT NULL,
	[CloseTime] [datetime] NULL,
 CONSTRAINT [PK_CMS_Content_Detail_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Health_Center]    Script Date: 11/19/2019 14:38:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Health_Center](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Latitude] [nvarchar](50) NOT NULL,
	[Longitude] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Health_Center] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member]    Script Date: 11/19/2019 14:38:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firstname] [nvarchar](50) NOT NULL,
	[Lastname] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
	[Mobile] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Birthdate] [datetime] NOT NULL,
	[Job] [nvarchar](50) NOT NULL,
	[Photo] [nvarchar](500) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[RegisterDate] [datetime] NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[ApproveCode] [uniqueidentifier] NOT NULL,
	[ApproveDate] [datetime] NULL,
	[Platform] [nvarchar](50) NOT NULL,
	[ForgotPassword] [nvarchar](50) NULL,
	[NotificationUserId] [nvarchar](500) NULL,
	[DeviceToken] [nvarchar](500) NULL,
	[Language] [nvarchar](6) NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Child]    Script Date: 11/19/2019 14:38:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Child](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [int] NOT NULL,
	[NameSurname] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
	[Birthdate] [datetime] NOT NULL,
	[Vaccine] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Member_Child] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Child_Vaccinate]    Script Date: 11/19/2019 14:38:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Child_Vaccinate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [int] NOT NULL,
	[ChildId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[IsCompleted] [bit] NOT NULL,
	[ReminderTitle] [nvarchar](500) NOT NULL,
	[ReminderMessage] [nvarchar](max) NOT NULL,
	[CompletedDate] [datetime] NULL,
	[NotificationId] [int] NOT NULL,
 CONSTRAINT [PK_Member_Child_Vaccinate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Health_Record]    Script Date: 11/19/2019 14:38:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Health_Record](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [int] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Photo] [nvarchar](500) NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Member_Health_Record] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Notification]    Script Date: 11/19/2019 14:38:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [int] NOT NULL,
	[NotificationSentId] [int] NOT NULL,
	[IsRead] [bit] NOT NULL,
	[ReadDate] [datetime] NULL,
	[IsDelete] [bit] NOT NULL,
	[DeleteDate] [datetime] NULL,
 CONSTRAINT [PK_Member_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Notification_Log]    Script Date: 11/19/2019 14:38:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Notification_Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [int] NOT NULL,
	[NotificationId] [int] NOT NULL,
	[TypeId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Member_Notification_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Pregnancy]    Script Date: 11/19/2019 14:38:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Pregnancy](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[IsCompleted] [bit] NOT NULL,
	[CompletedDate] [datetime] NULL,
	[ReminderTitle] [nvarchar](500) NOT NULL,
	[ReminderMessage] [nvarchar](max) NOT NULL,
	[NotificationId] [int] NOT NULL,
 CONSTRAINT [PK_Member_Pregnancy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member_Question_Answer]    Script Date: 11/19/2019 14:38:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member_Question_Answer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[AnswerId] [int] NOT NULL,
	[Answer] [nvarchar](500) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[ChildId] [int] NULL,
 CONSTRAINT [PK_Member_Question_Answer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 11/19/2019 14:38:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MinWeek] [int] NOT NULL,
	[MaxWeek] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[TypeId] [int] NOT NULL,
	[IsWeekly] [bit] NOT NULL,
	[AfterBirth] [int] NOT NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification_Message]    Script Date: 11/19/2019 14:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification_Message](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NotificationId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Message] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Notification_Message] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification_Sent]    Script Date: 11/19/2019 14:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification_Sent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[NotificationTypeId] [int] NULL,
	[NotificationId] [int] NULL,
 CONSTRAINT [PK_Notification_Sent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification_Sent_Detail]    Script Date: 11/19/2019 14:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification_Sent_Detail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SentId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Message] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_Notification_Sent_Detail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SLanguage]    Script Date: 11/19/2019 14:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SLanguage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[MobileCode] [nvarchar](3) NOT NULL,
	[IsoCode] [nvarchar](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_SLanguage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SLocation_City]    Script Date: 11/19/2019 14:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SLocation_City](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CountryId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[PhoneCode] [nvarchar](7) NULL,
 CONSTRAINT [PK_SLocation_City] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SLocation_Country]    Script Date: 11/19/2019 14:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SLocation_Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[PhoneCode] [nvarchar](50) NOT NULL,
	[Flag] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ULocation_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SLocation_Region]    Script Date: 11/19/2019 14:38:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SLocation_Region](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CityId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SLocation_Region] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SResource]    Script Date: 11/19/2019 14:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SResource](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Culture] [nvarchar](8) NOT NULL,
	[Screen] [nvarchar](50) NOT NULL,
	[Label] [nvarchar](50) NOT NULL,
	[Value] [nvarchar](50) NOT NULL,
	[IsError] [bit] NOT NULL,
	[IsLabel] [bit] NOT NULL,
	[IsInfo] [bit] NOT NULL,
 CONSTRAINT [PK_SResource] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SType_Data]    Script Date: 11/19/2019 14:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SType_Data](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SType_Data] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SType_Media]    Script Date: 11/19/2019 14:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SType_Media](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[MinWidth] [int] NOT NULL,
	[MinHeight] [int] NOT NULL,
	[IsVideo] [bit] NOT NULL,
 CONSTRAINT [PK_SType_Media] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SType_Menu]    Script Date: 11/19/2019 14:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SType_Menu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SType_Menu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SType_Notification]    Script Date: 11/19/2019 14:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SType_Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SType_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SType_QuestionAnswer]    Script Date: 11/19/2019 14:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SType_QuestionAnswer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SType_QuestionAnswer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SType_Table]    Script Date: 11/19/2019 14:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SType_Table](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FQN] [nvarchar](50) NOT NULL,
	[HasTranslation] [bit] NOT NULL,
 CONSTRAINT [PK_SType_Table] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SUser]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firstname] [nvarchar](50) NOT NULL,
	[Lastname] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastLogin] [datetime] NOT NULL,
 CONSTRAINT [PK_SUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Translation]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Translation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TableId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[RecordId] [int] NOT NULL,
	[Translation] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Translation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vaccinate]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vaccinate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Vaccinate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vaccinate_Detail]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vaccinate_Detail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VaccinateId] [int] NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Day] [int] NOT NULL,
 CONSTRAINT [PK_Vaccinate_Detail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vaccinate_Message]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vaccinate_Message](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VaccinateDetailId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Message] [nvarchar](max) NULL,
	[IsWeekly] [bit] NOT NULL,
 CONSTRAINT [PK_Vaccinate_Message] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[App_Screen]  WITH CHECK ADD  CONSTRAINT [FK_App_Screen_App_Screen_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[App_Screen_Category] ([Id])
GO
ALTER TABLE [dbo].[App_Screen] CHECK CONSTRAINT [FK_App_Screen_App_Screen_Category]
GO
ALTER TABLE [dbo].[App_Screen_Text]  WITH CHECK ADD  CONSTRAINT [FK_App_Screen_Text_App_Screen] FOREIGN KEY([ScreenId])
REFERENCES [dbo].[App_Screen] ([Id])
GO
ALTER TABLE [dbo].[App_Screen_Text] CHECK CONSTRAINT [FK_App_Screen_Text_App_Screen]
GO
ALTER TABLE [dbo].[App_Screen_Text]  WITH CHECK ADD  CONSTRAINT [FK_App_Screen_Text_SLanguage] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[SLanguage] ([Id])
GO
ALTER TABLE [dbo].[App_Screen_Text] CHECK CONSTRAINT [FK_App_Screen_Text_SLanguage]
GO
ALTER TABLE [dbo].[Category_Media]  WITH CHECK ADD  CONSTRAINT [FK_Category_Media_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Category_Media] CHECK CONSTRAINT [FK_Category_Media_Category]
GO
ALTER TABLE [dbo].[Category_Media]  WITH CHECK ADD  CONSTRAINT [FK_Category_Media_SType_Media] FOREIGN KEY([MediaTypeId])
REFERENCES [dbo].[SType_Media] ([Id])
GO
ALTER TABLE [dbo].[Category_Media] CHECK CONSTRAINT [FK_Category_Media_SType_Media]
GO
ALTER TABLE [dbo].[Category_Question]  WITH CHECK ADD  CONSTRAINT [FK_Category_Question_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Category_Question] CHECK CONSTRAINT [FK_Category_Question_Category]
GO
ALTER TABLE [dbo].[Category_Question]  WITH CHECK ADD  CONSTRAINT [FK_Category_Question_SType_QuestionAnswer] FOREIGN KEY([AnswerTypeId])
REFERENCES [dbo].[SType_QuestionAnswer] ([Id])
GO
ALTER TABLE [dbo].[Category_Question] CHECK CONSTRAINT [FK_Category_Question_SType_QuestionAnswer]
GO
ALTER TABLE [dbo].[Category_Question_Answer]  WITH CHECK ADD  CONSTRAINT [FK_Category_Question_Answer_Category_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Category_Question] ([Id])
GO
ALTER TABLE [dbo].[Category_Question_Answer] CHECK CONSTRAINT [FK_Category_Question_Answer_Category_Question]
GO
ALTER TABLE [dbo].[Category_Question_Answer]  WITH CHECK ADD  CONSTRAINT [FK_Category_Question_Answer_SType_Data] FOREIGN KEY([DataTypeId])
REFERENCES [dbo].[SType_Data] ([Id])
GO
ALTER TABLE [dbo].[Category_Question_Answer] CHECK CONSTRAINT [FK_Category_Question_Answer_SType_Data]
GO
ALTER TABLE [dbo].[CMS_Content_Detail]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Content_Detail_CMS_Content] FOREIGN KEY([ContentId])
REFERENCES [dbo].[CMS_Content] ([Id])
GO
ALTER TABLE [dbo].[CMS_Content_Detail] CHECK CONSTRAINT [FK_CMS_Content_Detail_CMS_Content]
GO
ALTER TABLE [dbo].[CMS_Content_Detail]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Content_Detail_SLanguage] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[SLanguage] ([Id])
GO
ALTER TABLE [dbo].[CMS_Content_Detail] CHECK CONSTRAINT [FK_CMS_Content_Detail_SLanguage]
GO
ALTER TABLE [dbo].[CMS_Content_Detail_Log]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Content_Detail_Log_CMS_Content] FOREIGN KEY([ContentId])
REFERENCES [dbo].[CMS_Content] ([Id])
GO
ALTER TABLE [dbo].[CMS_Content_Detail_Log] CHECK CONSTRAINT [FK_CMS_Content_Detail_Log_CMS_Content]
GO
ALTER TABLE [dbo].[CMS_Content_Detail_Log]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Content_Detail_Log_CMS_Content_Detail] FOREIGN KEY([ContentDetailId])
REFERENCES [dbo].[CMS_Content_Detail] ([Id])
GO
ALTER TABLE [dbo].[CMS_Content_Detail_Log] CHECK CONSTRAINT [FK_CMS_Content_Detail_Log_CMS_Content_Detail]
GO
ALTER TABLE [dbo].[CMS_Content_Detail_Log]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Content_Detail_Log_Member] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([Id])
GO
ALTER TABLE [dbo].[CMS_Content_Detail_Log] CHECK CONSTRAINT [FK_CMS_Content_Detail_Log_Member]
GO
ALTER TABLE [dbo].[Member_Child]  WITH CHECK ADD  CONSTRAINT [FK_Member_Child_Member] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([Id])
GO
ALTER TABLE [dbo].[Member_Child] CHECK CONSTRAINT [FK_Member_Child_Member]
GO
ALTER TABLE [dbo].[Member_Child_Vaccinate]  WITH CHECK ADD  CONSTRAINT [FK_Member_Child_Vaccinate_Member] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([Id])
GO
ALTER TABLE [dbo].[Member_Child_Vaccinate] CHECK CONSTRAINT [FK_Member_Child_Vaccinate_Member]
GO
ALTER TABLE [dbo].[Member_Child_Vaccinate]  WITH CHECK ADD  CONSTRAINT [FK_Member_Child_Vaccinate_Member_Child] FOREIGN KEY([ChildId])
REFERENCES [dbo].[Member_Child] ([Id])
GO
ALTER TABLE [dbo].[Member_Child_Vaccinate] CHECK CONSTRAINT [FK_Member_Child_Vaccinate_Member_Child]
GO
ALTER TABLE [dbo].[Member_Health_Record]  WITH CHECK ADD  CONSTRAINT [FK_Member_Health_Record_Member] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([Id])
GO
ALTER TABLE [dbo].[Member_Health_Record] CHECK CONSTRAINT [FK_Member_Health_Record_Member]
GO
ALTER TABLE [dbo].[Member_Notification]  WITH CHECK ADD  CONSTRAINT [FK_Member_Notification_Member] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([Id])
GO
ALTER TABLE [dbo].[Member_Notification] CHECK CONSTRAINT [FK_Member_Notification_Member]
GO
ALTER TABLE [dbo].[Member_Notification]  WITH CHECK ADD  CONSTRAINT [FK_Member_Notification_Notification_Sent] FOREIGN KEY([NotificationSentId])
REFERENCES [dbo].[Notification_Sent] ([Id])
GO
ALTER TABLE [dbo].[Member_Notification] CHECK CONSTRAINT [FK_Member_Notification_Notification_Sent]
GO
ALTER TABLE [dbo].[Member_Notification_Log]  WITH CHECK ADD  CONSTRAINT [FK_Member_Notification_Log_Member] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([Id])
GO
ALTER TABLE [dbo].[Member_Notification_Log] CHECK CONSTRAINT [FK_Member_Notification_Log_Member]
GO
ALTER TABLE [dbo].[Member_Notification_Log]  WITH CHECK ADD  CONSTRAINT [FK_Member_Notification_Log_Notification] FOREIGN KEY([NotificationId])
REFERENCES [dbo].[Notification] ([Id])
GO
ALTER TABLE [dbo].[Member_Notification_Log] CHECK CONSTRAINT [FK_Member_Notification_Log_Notification]
GO
ALTER TABLE [dbo].[Member_Notification_Log]  WITH CHECK ADD  CONSTRAINT [FK_Member_Notification_Log_SType_Notification] FOREIGN KEY([TypeId])
REFERENCES [dbo].[SType_Notification] ([Id])
GO
ALTER TABLE [dbo].[Member_Notification_Log] CHECK CONSTRAINT [FK_Member_Notification_Log_SType_Notification]
GO
ALTER TABLE [dbo].[Member_Pregnancy]  WITH CHECK ADD  CONSTRAINT [FK_Member_Pregnancy_Member] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([Id])
GO
ALTER TABLE [dbo].[Member_Pregnancy] CHECK CONSTRAINT [FK_Member_Pregnancy_Member]
GO
ALTER TABLE [dbo].[Member_Question_Answer]  WITH CHECK ADD  CONSTRAINT [FK_Member_Question_Answer_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Member_Question_Answer] CHECK CONSTRAINT [FK_Member_Question_Answer_Category]
GO
ALTER TABLE [dbo].[Member_Question_Answer]  WITH CHECK ADD  CONSTRAINT [FK_Member_Question_Answer_Category_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Category_Question] ([Id])
GO
ALTER TABLE [dbo].[Member_Question_Answer] CHECK CONSTRAINT [FK_Member_Question_Answer_Category_Question]
GO
ALTER TABLE [dbo].[Member_Question_Answer]  WITH CHECK ADD  CONSTRAINT [FK_Member_Question_Answer_Member] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([Id])
GO
ALTER TABLE [dbo].[Member_Question_Answer] CHECK CONSTRAINT [FK_Member_Question_Answer_Member]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_SType_Notification] FOREIGN KEY([TypeId])
REFERENCES [dbo].[SType_Notification] ([Id])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_SType_Notification]
GO
ALTER TABLE [dbo].[Notification_Message]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Message_Notification] FOREIGN KEY([NotificationId])
REFERENCES [dbo].[Notification] ([Id])
GO
ALTER TABLE [dbo].[Notification_Message] CHECK CONSTRAINT [FK_Notification_Message_Notification]
GO
ALTER TABLE [dbo].[Notification_Message]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Message_SLanguage] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[SLanguage] ([Id])
GO
ALTER TABLE [dbo].[Notification_Message] CHECK CONSTRAINT [FK_Notification_Message_SLanguage]
GO
ALTER TABLE [dbo].[Notification_Sent_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Sent_Detail_SLanguage] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[SLanguage] ([Id])
GO
ALTER TABLE [dbo].[Notification_Sent_Detail] CHECK CONSTRAINT [FK_Notification_Sent_Detail_SLanguage]
GO
ALTER TABLE [dbo].[SLocation_City]  WITH CHECK ADD  CONSTRAINT [FK_SLocation_City_SLocation_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[SLocation_Country] ([Id])
GO
ALTER TABLE [dbo].[SLocation_City] CHECK CONSTRAINT [FK_SLocation_City_SLocation_Country]
GO
ALTER TABLE [dbo].[SLocation_Region]  WITH CHECK ADD  CONSTRAINT [FK_SLocation_Region_SLocation_City] FOREIGN KEY([CityId])
REFERENCES [dbo].[SLocation_City] ([Id])
GO
ALTER TABLE [dbo].[SLocation_Region] CHECK CONSTRAINT [FK_SLocation_Region_SLocation_City]
GO
ALTER TABLE [dbo].[SResource]  WITH CHECK ADD  CONSTRAINT [FK_SResource_SLanguage] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[SLanguage] ([Id])
GO
ALTER TABLE [dbo].[SResource] CHECK CONSTRAINT [FK_SResource_SLanguage]
GO
ALTER TABLE [dbo].[Translation]  WITH CHECK ADD  CONSTRAINT [FK_Translation_SLanguage] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[SLanguage] ([Id])
GO
ALTER TABLE [dbo].[Translation] CHECK CONSTRAINT [FK_Translation_SLanguage]
GO
ALTER TABLE [dbo].[Translation]  WITH CHECK ADD  CONSTRAINT [FK_Translation_SType_Table] FOREIGN KEY([TableId])
REFERENCES [dbo].[SType_Table] ([Id])
GO
ALTER TABLE [dbo].[Translation] CHECK CONSTRAINT [FK_Translation_SType_Table]
GO
ALTER TABLE [dbo].[Vaccinate_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Vaccinate_Detail_Vaccinate] FOREIGN KEY([VaccinateId])
REFERENCES [dbo].[Vaccinate] ([Id])
GO
ALTER TABLE [dbo].[Vaccinate_Detail] CHECK CONSTRAINT [FK_Vaccinate_Detail_Vaccinate]
GO
ALTER TABLE [dbo].[Vaccinate_Message]  WITH CHECK ADD  CONSTRAINT [FK_Vaccinate_Message_SLanguage] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[SLanguage] ([Id])
GO
ALTER TABLE [dbo].[Vaccinate_Message] CHECK CONSTRAINT [FK_Vaccinate_Message_SLanguage]
GO
ALTER TABLE [dbo].[Vaccinate_Message]  WITH CHECK ADD  CONSTRAINT [FK_Vaccinate_Message_Vaccinate_Detail] FOREIGN KEY([VaccinateDetailId])
REFERENCES [dbo].[Vaccinate_Detail] ([Id])
GO
ALTER TABLE [dbo].[Vaccinate_Message] CHECK CONSTRAINT [FK_Vaccinate_Message_Vaccinate_Detail]
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Member_Calendar]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[sp_Get_Member_Calendar] (@MemberId int)
As
Select Id,'' As NameInfo, Date,Title,Message,IsCompleted,CompletedDate,ReminderTitle,ReminderMessage From Member_Pregnancy P Where MemberId=@MemberId
Union All
Select V.Id,C.NameSurname As NameInfo,V.Date,V.Title,V.Message,IsCompleted,CompletedDate,ReminderTitle,ReminderMessage From Member_Child_Vaccinate V
Inner Join Member_Child C on C.Id=V.ChildId
Where V.MemberId=@MemberId
GO
/****** Object:  StoredProcedure [dbo].[sp_Manage_Dashboard_AVG_Child]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Create Proc sp_Manage_Dashboard_Member_Age
As
Select Count(Id) As Count, DATEDIFF(YY,Birthdate,GETDATE()) As Age From Member Group By DATEDIFF(YY,Birthdate,GETDATE()) Order by 1 Desc
*/

--exec sp_Manage_Dashboard_Member_Age

Create Proc [dbo].[sp_Manage_Dashboard_AVG_Child]
As
Declare @MemberCount int=0,
		@ChildCount int=0
Select @MemberCount=COUNT(Id) From Member
Select @ChildCount= COUNT(Id) From Member_Child
Select @MemberCount As MemberCount,@ChildCount As ChildCount, Round((CAST(@MemberCount as float) / Cast(@ChildCount as float)),2) As AVGChildCount

GO
/****** Object:  StoredProcedure [dbo].[sp_Manage_Dashboard_Member_Age]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[sp_Manage_Dashboard_Member_Age]
As
Select Count(Id) As Count, DATEDIFF(YY,Birthdate,GETDATE()) As Age, Count(Id)*DATEDIFF(YY,Birthdate,GETDATE()) As SubTotalAge
From Member Group By DATEDIFF(YY,Birthdate,GETDATE()) Order by 1 Desc
GO
/****** Object:  StoredProcedure [dbo].[sp_Mobile_Member_Language_Change]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[sp_Mobile_Member_Language_Change](@MemberId int)
As

Declare @LanguageId int 

Select @LanguageId = CASE Language	WHEN 'tr' THEN 1
									WHEN 'ar' THEN 2
									ELSE 3 END
									FROM Member Where Id=@MemberId

Update V Set 
Title=M.Title,
Message=REPLACE(M.Message,'XXX',C.NameSurname)
From Member_Child_Vaccinate V
Inner Join Member_Child C on C.Id=V.ChildId
Inner Join Notification N on N.Id=V.NotificationId
Inner Join Notification_Message M on M.NotificationId=N.Id
Where V.MemberId=@MemberId And M.LanguageId=@LanguageId

Update V Set 
ReminderTitle=M.Title,
ReminderMessage=REPLACE(M.Message,'XXX',C.NameSurname)
From Member_Child_Vaccinate V
Inner Join Member_Child C on C.Id=V.ChildId
Inner Join Notification X on X.Id=V.NotificationId
Inner Join Notification N on N.Name=X.Name
Inner Join Notification_Message M on M.NotificationId=N.Id
Where V.MemberId=@MemberId And M.LanguageId=@LanguageId And N.IsWeekly=1

Update P Set 
Title=M.Title,
Message=M.Message
From Member_Pregnancy P
Inner Join Notification N on N.Id=P.NotificationId
Inner Join Notification_Message M on M.NotificationId=N.Id
Where P.MemberId=@MemberId And M.LanguageId=@LanguageId

Update P Set 
ReminderTitle=M.Title,
ReminderMessage=M.Message
From Member_Pregnancy P
Inner Join Notification X on X.Id=P.NotificationId
Inner Join Notification N on N.Name=X.Name
Inner Join Notification_Message M on M.NotificationId=N.Id
Where P.MemberId=@MemberId And M.LanguageId=@LanguageId And N.IsWeekly=1

Select * From Member_Pregnancy Where MemberId=@MemberId

GO
/****** Object:  StoredProcedure [dbo].[sp_Mobile_NearByHealthCenter]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[sp_Mobile_NearByHealthCenter] (@Latitude float,@Longitude float)            
As            
Select Top 20          
H.Name,        
H.Address,
H.Phone,
H.Latitude,
H.Longitude,
dbo.fn_CalcDistanceKM(@Latitude,CONVERT(float,H.Latitude),@Longitude,CONVERT(float,H.Longitude)) As Distance           
From Health_Center H
Order By Distance


GO
/****** Object:  StoredProcedure [dbo].[sp_Mobile_Translation_List]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[sp_Mobile_Translation_List](@LanguageId int)  
As  
Select S.Name As Screen,T.Label,T.IsError,T.Translation From App_Screen_Text T   
Inner Join App_Screen S on S.Id=T.ScreenId  
Where T.LanguageId=@LanguageId  
  
GO
/****** Object:  StoredProcedure [dbo].[sp_Notification_Job_ChildVaccinate]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[sp_Notification_Job_ChildVaccinate]    
As    
Select V.Id,V.MemberId,V.ChildId,V.Title,V.Message,V.ReminderTitle,V.ReminderMessage,V.NotificationId,M.NotificationUserId,V.IsCompleted,M.Language From Member_Child_Vaccinate V  
Inner Join Member_Child MC on MC.Id=V.ChildId  
Inner Join Member M on M.Id=MC.MemberId  
Where dbo.fn_TruncDate(V.Date)=dbo.fn_TruncDate(GETDATE()) AND V.IsCompleted<>1 And LEN(ISNULL(M.NotificationUserId,''))>5  
GO
/****** Object:  StoredProcedure [dbo].[sp_Notification_Job_RutineMessages]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[sp_Notification_Job_RutineMessages]  
As  
  
Declare @tblMessage Table  
(  
 NotificationUserId nvarchar(500),  
 Message nvarchar(max)  
)  
  
Declare @MemberId int,@NotificationUserId nvarchar(500),@LanguageId int,@NotificationId int,@Message nvarchar(max)  
DECLARE memberCursor CURSOR FOR   
  
Select M.Id,M.NotificationUserId,L.Id From Member M  
Inner Join SLanguage L on L.MobileCode=M.Language  
Where M.NotificationUserId Is Not Null And ISNULL(M.Language,'xx')<>'xx'  
  
OPEN memberCursor  FETCH NEXT FROM memberCursor INTO @MemberId,@NotificationUserId,@LanguageId    
  
WHILE @@FETCH_STATUS = 0    
BEGIN    
   Select Top 1 @Message=M.Message,@NotificationId= N.Id From Notification N   
   Inner Join Notification_Message M on M.NotificationId=N.Id  
   Where N.TypeId=2 And LanguageId=@LanguageId And M.NotificationId Not In (Select NotificationId From Member_Notification_Log Where MemberId=@MemberId)  
   Order By N.Id  
  
   Declare @Notification_SentId int  
   Insert Notification_Sent (Date,Type,NotificationTypeId,NotificationId) Values (GETDATE(),'System',2,@NotificationId)  
   Select @Notification_SentId = IDENT_CURRENT('Notification_Sent')  
  
   Insert Notification_Sent_Detail Values (@Notification_SentId,@LanguageId,@Message)  
   Insert Member_Notification Values (@MemberId,@Notification_SentId,0,NULL,0,NULL)  
   Insert Member_Notification_Log Values (@MemberId,@NotificationId,2,GETDATE())  
  
   Insert @tblMessage Values (@NotificationUserId,@Message)  
  
   FETCH NEXT FROM memberCursor INTO @MemberId,@NotificationUserId,@LanguageId     
END   
  
CLOSE memberCursor    
DEALLOCATE memberCursor   
  
Select * From @tblMessage  
  
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Child_Vaccinate]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[sp_Set_Child_Vaccinate](@ChildId int)  
As  
Delete From Member_Child_Vaccinate Where ChildId=@ChildId  
Declare @MemberId int,@BirthDate datetime,@LanguageId int,@ChildName nvarchar(100)  
  
Select @MemberId=M.Id,@ChildName=C.NameSurname, @BirthDate=C.Birthdate,@LanguageId=CASE M.Language WHEN 'tr' THEN 1  
                   WHEN 'ar' THEN 2  
                   WHEN 'en' THEN 3  
                   ELSE 1 END  
From Member_Child C  
Inner Join Member M on M.Id=C.MemberId  
Where C.Id=@ChildId  
  
Insert Member_Child_Vaccinate (MemberId,ChildId,Date,Title,Message,IsCompleted,ReminderTitle,ReminderMessage,CompletedDate,NotificationId)  
Select @MemberId As MemberId,@ChildId As ChildId,DATEADD(DAY,N.AfterBirth,@BirthDate) As VaccinateDate,NM.Title,  
REPLACE(NM.Message,'XXX',@ChildName) As Message,0 As IsCompleted,N.Name As ReminderTitle,''As ReminderMessage,NULL,N.Id  
From Notification N   
Inner Join Notification_Message NM on NM.NotificationId=N.Id  
Where N.TypeId=3 And NM.LanguageId=@LanguageId And N.IsWeekly=0  
Order By 1,LanguageId  
  
Update V Set V.ReminderTitle=NM.Title,V.ReminderMessage=REPLACE(NM.Message,'XXX',@ChildName) From Member_Child_Vaccinate V  
Inner Join Notification N on N.Name=V.ReminderTitle  
Inner Join Notification_Message NM on NM.NotificationId=N.Id  
Where NM.LanguageId=@LanguageId And V.ChildId=@ChildId And N.IsWeekly=1
GO
/****** Object:  StoredProcedure [dbo].[sp_Set_Member_Pregnancy]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[sp_Set_Member_Pregnancy](@MemberId int,@LastDate datetime)  
As  
  
Declare @LanguageId int  
  
Select @LanguageId=CASE M.Language WHEN 'tr' THEN 1 WHEN 'ar' THEN 2 WHEN 'en' THEN 3 ELSE 1 END  
From Member M Where M.Id=@MemberId  

If Exists (Select Id From Member_Pregnancy Where MemberId=@MemberId)
	Begin
		Update P Set P.Date = DATEADD(DAY,N.MinWeek*7,@LastDate) From Member_Pregnancy P
		Inner Join Notification N on N.Id=P.NotificationId
		Where P.MemberId=@MemberId
	End
Else
	Begin
		Insert Member_Pregnancy (MemberId,Date,Title,Message,IsCompleted,CompletedDate,ReminderTitle,ReminderMessage,NotificationId)  
		Select @MemberId,DATEADD(DAY,N.MinWeek*7,@LastDate),NM.Title,NM.Message,0 As IsCompleted,NULL,N.Name As ReminderTitle,''As ReminderMessage,N.Id  
		From Notification N   
		Inner Join Notification_Message NM on NM.NotificationId=N.Id  
		Where N.TypeId=1 And NM.LanguageId=@LanguageId And N.IsWeekly=0  
		Order By 1,LanguageId  
  
		Update V Set V.ReminderTitle=NM.Title,V.ReminderMessage=NM.Message From Member_Pregnancy V  
		Inner Join Notification N on N.Name=V.ReminderTitle  
		Inner Join Notification_Message NM on NM.NotificationId=N.Id  
		Where NM.LanguageId=@LanguageId And V.MemberId=@MemberId And N.IsWeekly=1
	End
  
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Child_Vaccinate]    Script Date: 11/19/2019 14:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[sp_Update_Child_Vaccinate](@ChildId int,@OldName nvarchar(50),@NewName nvarchar(50),@Birthdate datetime,@NameIsChanged bit,@BirthdateIsChanged bit)
As
If @NameIsChanged=1
	Begin
		Update Member_Child_Vaccinate Set Message=REPLACE(Message,@OldName,@NewName),ReminderMessage=REPLACE(ReminderMessage,@OldName,@NewName) Where ChildId=@ChildId
	End
If @BirthdateIsChanged=1
	Begin
		Update V Set Date = DATEADD(DAY,N.AfterBirth,@BirthDate) From Member_Child_Vaccinate V
		Inner Join Notification N on N.Id=V.NotificationId		
	End
GO
