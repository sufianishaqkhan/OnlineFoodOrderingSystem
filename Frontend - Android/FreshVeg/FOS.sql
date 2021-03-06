USE [master]
GO
/****** Object:  Database [OnlineFoodOrderingSystem]    Script Date: 08/07/2020 19:26:46 ******/
CREATE DATABASE [OnlineFoodOrderingSystem] ON  PRIMARY 
( NAME = N'OnlineFoodOrderingSystem', FILENAME = N'c:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS2008\MSSQL\DATA\OnlineFoodOrderingSystem.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'OnlineFoodOrderingSystem_log', FILENAME = N'c:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS2008\MSSQL\DATA\OnlineFoodOrderingSystem_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OnlineFoodOrderingSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET ANSI_NULLS OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET ANSI_PADDING OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET ARITHABORT OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET  DISABLE_BROKER
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET  READ_WRITE
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET RECOVERY SIMPLE
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET  MULTI_USER
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [OnlineFoodOrderingSystem] SET DB_CHAINING OFF
GO
USE [OnlineFoodOrderingSystem]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 08/07/2020 19:26:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[u_id] [int] IDENTITY(1,1) NOT NULL,
	[u_name] [nvarchar](50) NULL,
	[u_email] [nvarchar](200) NULL,
	[u_pass] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[u_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 08/07/2020 19:26:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Products](
	[p_id] [int] IDENTITY(1,1) NOT NULL,
	[p_name] [nvarchar](50) NULL,
	[p_category] [int] NULL,
	[p_unitprice] [decimal](18, 2) NULL,
	[p_qty] [int] NULL,
	[p_weight] [nvarchar](50) NULL,
	[p_pic] [varbinary](max) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[p_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 08/07/2020 19:26:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[od_id] [int] IDENTITY(1,1) NOT NULL,
	[od_user_id] [int] NULL,
	[od_pid] [int] NULL,
	[od_qty] [int] NULL,
	[od_delivered_loc] [nvarchar](max) NULL,
	[od_price] [decimal](18, 2) NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[od_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderAssigns]    Script Date: 08/07/2020 19:26:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderAssigns](
	[oa_id] [int] IDENTITY(1,1) NOT NULL,
	[oa_u_id] [int] NULL,
	[oa_db_id] [int] NULL,
	[oa_status] [nvarchar](50) NULL,
 CONSTRAINT [PK_OrderAssigns] PRIMARY KEY CLUSTERED 
(
	[oa_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeliveryBoys]    Script Date: 08/07/2020 19:26:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeliveryBoys](
	[db_id] [int] IDENTITY(1,1) NOT NULL,
	[db_name] [nvarchar](50) NULL,
	[db_email] [nvarchar](200) NULL,
	[db_password] [nvarchar](100) NULL,
	[db_shiftstart] [nvarchar](50) NULL,
	[db_shiftend] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_DeliveryBoys] PRIMARY KEY CLUSTERED 
(
	[db_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 08/07/2020 19:26:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[c_id] [int] IDENTITY(1,1) NOT NULL,
	[c_categorytype] [nvarchar](50) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[c_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 08/07/2020 19:26:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[a_id] [int] IDENTITY(1,1) NOT NULL,
	[a_name] [nvarchar](50) NULL,
	[a_email] [nvarchar](200) NULL,
	[a_password] [nvarchar](100) NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[a_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[USP_USERS_LOGIN_USER]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_USERS_LOGIN_USER]
(
@u_email NVARCHAR(200)
,@u_pass NVARCHAR(100)
)
AS
BEGIN
		SELECT [u_id]
		  FROM [OnlineFoodOrderingSystem].[dbo].[Users]
		  WHERE u_email = @u_email AND u_pass = @u_pass
END
GO
/****** Object:  StoredProcedure [dbo].[USP_USERS_INSERT_USERS]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- INSERT USERS STORE PROCEDURES
CREATE PROC [dbo].[USP_USERS_INSERT_USERS]
(
@u_name NVARCHAR(50)
,@u_email NVARCHAR(200)
,@u_pass NVARCHAR(100)
)
AS
BEGIN
		INSERT INTO [OnlineFoodOrderingSystem].[dbo].[Users]
				   ([u_name]
				   ,[u_email]
				   ,[u_pass]
				   ,[CreatedDate])
			 VALUES
				   (@u_name
				   ,@u_email
				   ,@u_pass
				   ,GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[USP_USERS_FORGET_PASSWORD]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_USERS_FORGET_PASSWORD]
(
@u_email NVARCHAR(200)
,@u_pass NVARCHAR(50)
)
AS
BEGIN
		UPDATE [OnlineFoodOrderingSystem].[dbo].[Users]
		   SET [u_pass] = @u_pass
		 WHERE [u_email] = @u_email
END
GO
/****** Object:  StoredProcedure [dbo].[USP_PRODUCTS_VIEW_PRODUCTS]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_PRODUCTS_VIEW_PRODUCTS]
AS
BEGIN
		SELECT [p_id]
			  ,[p_name]
			  ,C.C_CATEGORYTYPE AS [p_category]
			  ,[p_unitprice]
			  ,[p_qty]
			  ,[p_weight]
			  ,[CreatedDate]
		  FROM [OnlineFoodOrderingSystem].[dbo].[Products] P
		  LEFT JOIN CATEGORIES C ON C.C_ID = P.p_category
END
GO
/****** Object:  StoredProcedure [dbo].[USP_PRODUCTS_UPDATE_STOCK]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---	UPDATING STOCK STORE PROCEDURE
CREATE PROC [dbo].[USP_PRODUCTS_UPDATE_STOCK]
(
@od_user_id INT
,@od_pid INT
)
AS
BEGIN

DECLARE @od_qty INT = (SELECT 
							od_qty 
						FROM OrderDetails 
						WHERE od_user_id = @od_user_id AND od_pid = @od_pid)

		UPDATE [OnlineFoodOrderingSystem].[dbo].[Products]
		SET [p_qty] = (p_qty - @od_qty)
		WHERE p_id = @od_pid
END
GO
/****** Object:  StoredProcedure [dbo].[USP_PRODUCTS_INSERT_PRODUCT]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_PRODUCTS_INSERT_PRODUCT]
(
@p_name NVARCHAR(50)
,@p_category INT
,@p_unitprice DECIMAL(18,2)
,@p_qty INT
,@p_weight NVARCHAR(50) 
)
AS
BEGIN
		INSERT INTO [OnlineFoodOrderingSystem].[dbo].[Products]
				   ([p_name]
				   ,[p_category]
				   ,[p_unitprice]
				   ,[p_qty]
				   ,[p_weight]
				   ,[CreatedDate])
			 VALUES
				   (@p_name
				   ,@p_category
				   ,@p_unitprice
				   ,@p_qty
				   ,@p_weight
				   ,GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ORDERDETAILS_FULL_ORDER_DETAILS]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ORDERDETAILS_FULL_ORDER_DETAILS]
AS
BEGIN
		SELECT [od_id]
		      ,U.U_NAME 
		      ,P.P_NAME 
		      ,[od_qty]
		      ,[od_delivered_loc]
		      ,[od_price]
		  FROM [OnlineFoodOrderingSystem].[dbo].[OrderDetails] OD
		  LEFT JOIN PRODUCTS P ON P.P_ID = OD.od_pid
		  LEFT JOIN Users U ON U.U_ID = OD.od_user_id  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ORDERDETAILS_BUY_PRODUCTS_DETAILS]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ORDERDETAILS_BUY_PRODUCTS_DETAILS]
(
 @od_user_id int
,@od_pid int
,@od_qty int
,@od_delivered_loc nvarchar(max)
,@od_price decimal(18,2)
)
AS
BEGIN
		INSERT INTO [OnlineFoodOrderingSystem].[dbo].[OrderDetails]
				   ([od_user_id]
				   ,[od_pid]
				   ,[od_qty]
				   ,[od_delivered_loc]
				   ,[od_price])
			 VALUES
				   (@od_user_id
				   ,@od_pid
				   ,@od_qty
				   ,@od_delivered_loc
				   ,@od_price)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ORDERASSIGNS_PLACE_ORDER]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ORDERASSIGNS_PLACE_ORDER]
(
@oa_u_id int
)
AS
BEGIN
		INSERT INTO [OnlineFoodOrderingSystem].[dbo].[OrderAssigns]
				   ([oa_u_id]
				   ,[oa_status])
			 VALUES
				   (@oa_u_id
				   ,'PENDING')
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ORDERASSIGNS_DISP_USER_ORDER]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ORDERASSIGNS_DISP_USER_ORDER]
AS
BEGIN
		SELECT [oa_id]
			  ,U.u_name
			  ,P.p_name
			  ,OD.od_qty
			  ,OD.od_price
			  ,[oa_db_id]
			  ,[oa_status]
		  FROM [OnlineFoodOrderingSystem].[dbo].[OrderAssigns] OA
		  LEFT JOIN OrderDetails OD ON OD.od_user_id = OA.oa_u_id
		  LEFT JOIN Products P ON P.p_id = OD.od_pid
		  LEFT JOIN Users U ON U.u_id = OA.oa_u_id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ORDERASSIGNS_COMPLETED_ORDER]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ORDERASSIGNS_COMPLETED_ORDER]
(
@oa_u_id INT
)
AS
BEGIN
		UPDATE [OnlineFoodOrderingSystem].[dbo].[OrderAssigns]
		   SET [oa_status] = 'DELIVERED'
		 WHERE oa_u_id = @oa_u_id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ORDERASSIGNS_ASSIGN_ORDER]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ORDERASSIGNS_ASSIGN_ORDER]
(
 @oa_u_id INT
,@oa_db_id INT
)
AS
BEGIN
		UPDATE [OnlineFoodOrderingSystem].[dbo].[OrderAssigns]
		   SET [oa_db_id] = @oa_db_id
			  ,[oa_status] = 'ACCEPTTED'
		 WHERE oa_u_id = @oa_u_id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DELIVERYBOYS_VIEW_DELIVERYBOYS]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_DELIVERYBOYS_VIEW_DELIVERYBOYS]
AS
BEGIN
		SELECT [db_id]
		      ,[db_name]
		      ,[db_email]
		      ,[db_password]
		      ,[db_shiftstart]
		      ,[db_shiftend]
		      ,[CreatedBy]
		      ,[CreatedDate]
		  FROM [OnlineFoodOrderingSystem].[dbo].[DeliveryBoys]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DELIVERYBOYS_LOGIN_DELIVERYBOY]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_DELIVERYBOYS_LOGIN_DELIVERYBOY]
(
@db_email NVARCHAR(200)
,@db_password NVARCHAR(100)
)
AS
BEGIN
		SELECT [DB_ID]
		  FROM [OnlineFoodOrderingSystem].[dbo].[DeliveryBoys]
		  WHERE @db_email = db_email AND @db_password = db_password
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DELIVERYBOYS_INSERT_DELIVERYBOYS]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- INSERT DELIVERY BOY STORE PROCEDURE
CREATE PROC [dbo].[USP_DELIVERYBOYS_INSERT_DELIVERYBOYS]
(
@db_name nvarchar(50)
,@db_email nvarchar(200)
,@db_password nvarchar(100)
,@db_shiftstart nvarchar(50)
,@db_shiftend nvarchar(50)
)
AS
BEGIN
		INSERT INTO [OnlineFoodOrderingSystem].[dbo].[DeliveryBoys]
				   ([db_name]
				   ,[db_email]
				   ,[db_password]
				   ,[db_shiftstart]
				   ,[db_shiftend]
				   ,[CreatedBy]
				   ,[CreatedDate])
			 VALUES
				   (@db_name
				   ,@db_email
				   ,@db_password
				   ,@db_shiftstart
				   ,@db_shiftend
				   ,'Admin'
				   ,GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[USP_CATEGORIES_VIEW_CATEGORIES]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_CATEGORIES_VIEW_CATEGORIES]
AS
BEGIN
		SELECT [c_id]
			  ,[c_categorytype]
		  FROM [OnlineFoodOrderingSystem].[dbo].[Categories]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_CATEGORIES_INSERT_CATEGORY]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_CATEGORIES_INSERT_CATEGORY]
(
@c_categorytype NVARCHAR(50)
)
AS
BEGIN

				INSERT INTO [OnlineFoodOrderingSystem].[dbo].[Categories]
						   ([c_categorytype])
					 VALUES
						   (@c_categorytype)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ADMIN_LOGIN_ADMIN]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ADMIN_LOGIN_ADMIN]
(
@a_email NVARCHAR(200)
,@a_password NVARCHAR(100)
)
AS
BEGIN
		SELECT [a_id]
		  FROM [OnlineFoodOrderingSystem].[dbo].[Admin]
		  WHERE @a_email = a_email AND @a_password = a_password
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ADMIN_INSERT_ADMIN]    Script Date: 08/07/2020 19:26:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ADMIN_INSERT_ADMIN]
AS 
BEGIN
			INSERT INTO [OnlineFoodOrderingSystem].[dbo].[Admin]
			           ([a_name]
			           ,[a_email]
			           ,[a_password])
			     VALUES
			           ('ALI'
			           ,'ali321@gmail.com'
			           ,'ali321')
END
GO
/****** Object:  Default [DF_OrderAssigns_oa_db_id]    Script Date: 08/07/2020 19:26:48 ******/
ALTER TABLE [dbo].[OrderAssigns] ADD  CONSTRAINT [DF_OrderAssigns_oa_db_id]  DEFAULT ((0)) FOR [oa_db_id]
GO
