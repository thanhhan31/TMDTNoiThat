USE [master]
GO

CREATE DATABASE [LTWEB_TMDT_NOITHAT]
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LTWEB_TMDT_NOITHAT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET ARITHABORT OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET  MULTI_USER 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET QUERY_STORE = OFF
GO
USE [LTWEB_TMDT_NOITHAT]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItems](
	[idUser] [int] NOT NULL,
	[idProduct] [int] NOT NULL,
	[quantity] [int] NULL,
 CONSTRAINT [PK_Carts] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC,
	[idProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NULL,
	[idProduct] [int] NULL,
	[comment] [nvarchar](max) NULL,
	[rating] [int] NULL,
	[time] [datetime] NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[idOrder] [int] NOT NULL,
	[idProduct] [int] NOT NULL,
	[quantity] [int] NULL,
	[unitPrice] [decimal](19, 5) NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[idOrder] ASC,
	[idProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NOT NULL,
	[idShip] [int] NULL,
	[idSeller] [int] NULL,
	[createTime] [datetime] NULL,
	[totalPrice] [decimal](19, 5) NULL,
	[status] [int] NULL,
	[paidTime] [datetime] NULL,
	[idPaymentMethod] [int] NULL,
	[orderKey] [int] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethods](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
 CONSTRAINT [PK_PaymentMethods] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idProduct] [int] NOT NULL,
	[imageLink] [varchar](max) NULL,
 CONSTRAINT [PK_ProductImage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idCategory] [int] NULL,
	[name] [nvarchar](max) NULL,
	[price] [decimal](19, 3) NULL,
	[description] [nvarchar](max) NULL,
	[createTime] [datetime] NULL,
	[nvisit] [int] NULL,
	[nsold] [int] NULL,
	[active] [int] NULL,
	[idUser] [int] NULL,
	[availableQuantity] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShipInfos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NULL,
	[address] [nvarchar](max) NULL,
 CONSTRAINT [PK_ShipInfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idRole] [int] NOT NULL,
	[username] [nvarchar](max) NOT NULL,
	[password] [char](64) NOT NULL,
	[phone] [char](10) NULL,
	[email] [varchar](max) NULL,
	[avatar] [varchar](max) NULL,
	[registerTime] [datetime] NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[CartItems] ([idUser], [idProduct], [quantity]) VALUES (1, 5, 1)
INSERT [dbo].[CartItems] ([idUser], [idProduct], [quantity]) VALUES (4, 126, 1)
INSERT [dbo].[CartItems] ([idUser], [idProduct], [quantity]) VALUES (5, 6, 1)
INSERT [dbo].[CartItems] ([idUser], [idProduct], [quantity]) VALUES (5, 126, 1)
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([id], [name], [active]) VALUES (1, N'Bàn', 1)
INSERT [dbo].[Categories] ([id], [name], [active]) VALUES (2, N'Ghế', 1)
INSERT [dbo].[Categories] ([id], [name], [active]) VALUES (3, N'Giường', 1)
INSERT [dbo].[Categories] ([id], [name], [active]) VALUES (4, N'Tủ kệ', 1)
INSERT [dbo].[Categories] ([id], [name], [active]) VALUES (5, N'Sản phẩm gắn tường', 1)
INSERT [dbo].[Categories] ([id], [name], [active]) VALUES (6, N'Gương', 1)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([id], [idUser], [idProduct], [comment], [rating], [time]) VALUES (1, 4, 123, N'Sản phẩm rất phù hợp với túi tiền', 4, CAST(N'2021-11-27T12:51:24.257' AS DateTime))
INSERT [dbo].[Comments] ([id], [idUser], [idProduct], [comment], [rating], [time]) VALUES (2, 4, 123, N'Sản phẩm đẹp!', 2, CAST(N'2021-12-07T00:01:23.067' AS DateTime))
SET IDENTITY_INSERT [dbo].[Comments] OFF
GO
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (3, 4, 1, CAST(4490000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (4, 123, 1, CAST(749000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (5, 52, 1, CAST(6990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (6, 123, 2, CAST(749000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (6, 124, 1, CAST(599000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (6, 125, 1, CAST(1190000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (7, 1, 1, CAST(1990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (8, 123, 1, CAST(749000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (8, 124, 1, CAST(599000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (9, 12, 1, CAST(799000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (10, 126, 1, CAST(1095000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (11, 12, 1, CAST(799000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (12, 126, 1, CAST(1095000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (13, 124, 1, CAST(599000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (14, 1, 1, CAST(1990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (15, 1, 1, CAST(1990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (15, 10, 1, CAST(3490000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (29, 1, 1, CAST(1990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (30, 126, 1, CAST(1095000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (31, 1, 1, CAST(1990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (32, 124, 1, CAST(599000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (33, 4, 1, CAST(4490000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (34, 124, 1, CAST(599000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (35, 4, 1, CAST(4490000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (36, 5, 2, CAST(2990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (36, 6, 1, CAST(6990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (37, 7, 1, CAST(5990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (37, 8, 1, CAST(1990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (38, 9, 1, CAST(3490000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (39, 11, 1, CAST(6990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (39, 13, 2, CAST(699000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (40, 94, 1, CAST(99000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (41, 95, 1, CAST(1290000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (41, 96, 1, CAST(299000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (42, 97, 6, CAST(89000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (43, 98, 1, CAST(899000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (43, 99, 1, CAST(699000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (43, 103, 1, CAST(149000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (44, 100, 1, CAST(999000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (44, 101, 1, CAST(899000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (45, 34, 1, CAST(499000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (45, 35, 1, CAST(699000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (46, 36, 3, CAST(499500.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (47, 37, 1, CAST(849000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (47, 38, 2, CAST(1990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (48, 39, 2, CAST(999000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (49, 40, 2, CAST(599000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (49, 41, 2, CAST(3990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (50, 42, 2, CAST(5990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (51, 43, 2, CAST(10900000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (52, 44, 2, CAST(1393000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (53, 45, 1, CAST(6490000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (54, 4, 1, CAST(4490000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (55, 4, 1, CAST(4490000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (56, 5, 1, CAST(2990000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (57, 104, 1, CAST(1790000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (58, 105, 1, CAST(499000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (59, 106, 1, CAST(1190000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (60, 107, 1, CAST(999000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (61, 108, 1, CAST(999000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (62, 109, 1, CAST(129000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (63, 110, 1, CAST(2490000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (64, 111, 1, CAST(1490000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (65, 112, 2, CAST(1690000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (66, 113, 2, CAST(1290000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (67, 114, 3, CAST(600000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (68, 115, 3, CAST(700000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (69, 116, 2, CAST(1590000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (70, 117, 4, CAST(449000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (71, 118, 2, CAST(1190000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (72, 119, 1, CAST(2490000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (73, 120, 2, CAST(999000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (74, 121, 2, CAST(1590000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (75, 122, 3, CAST(999000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (76, 124, 1, CAST(599000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (77, 60, 1, CAST(11900.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (78, 124, 1, CAST(599000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (79, 60, 4, CAST(11900.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (80, 123, 1, CAST(749000.00000 AS Decimal(19, 5)))
INSERT [dbo].[OrderDetails] ([idOrder], [idProduct], [quantity], [unitPrice]) VALUES (81, 13, 1, CAST(699000.00000 AS Decimal(19, 5)))
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (3, 5, 4, 2, CAST(N'2019-06-25T17:31:49.567' AS DateTime), CAST(4490000.00000 AS Decimal(19, 5)), 2, CAST(N'2019-06-30T17:31:49.567' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (4, 5, 4, 3, CAST(N'2019-08-15T17:31:49.670' AS DateTime), CAST(749000.00000 AS Decimal(19, 5)), 2, CAST(N'2019-08-20T17:31:49.670' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (5, 6, 6, 2, CAST(N'2019-09-27T17:33:43.917' AS DateTime), CAST(6990000.00000 AS Decimal(19, 5)), 2, CAST(N'2019-10-01T17:33:43.917' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (6, 4, 1, 3, CAST(N'2019-10-05T17:33:43.940' AS DateTime), CAST(3287000.00000 AS Decimal(19, 5)), 2, CAST(N'2019-10-07T17:33:43.940' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (7, 6, 6, 2, CAST(N'2019-10-18T17:55:14.067' AS DateTime), CAST(1990000.00000 AS Decimal(19, 5)), -1, NULL, NULL, 297645)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (8, 4, 1, 3, CAST(N'2019-10-23T17:55:14.123' AS DateTime), CAST(1348000.00000 AS Decimal(19, 5)), 0, NULL, NULL, 297645)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (9, 5, 4, 2, CAST(N'2019-11-27T18:06:47.807' AS DateTime), CAST(799000.00000 AS Decimal(19, 5)), 0, NULL, NULL, 358627)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (10, 6, 5, 3, CAST(N'2019-11-27T18:06:47.883' AS DateTime), CAST(1095000.00000 AS Decimal(19, 5)), 0, NULL, NULL, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (11, 5, 3, 2, CAST(N'2019-11-27T18:08:44.583' AS DateTime), CAST(799000.00000 AS Decimal(19, 5)), 1, CAST(N'2019-11-28T18:08:44.583' AS DateTime), 2, 602218)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (12, 5, 4, 3, CAST(N'2019-11-27T18:08:44.607' AS DateTime), CAST(1095000.00000 AS Decimal(19, 5)), 0, NULL, NULL, 877790)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (13, 6, 5, 3, CAST(N'2020-02-15T22:49:33.320' AS DateTime), CAST(599000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-02-16T22:49:33.320' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (14, 4, 1, 2, CAST(N'2020-02-22T22:50:29.387' AS DateTime), CAST(1990000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-02-22T22:50:29.387' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (15, 4, 2, 2, CAST(N'2020-04-14T01:12:26.597' AS DateTime), CAST(5480000.00000 AS Decimal(19, 5)), 1, CAST(N'2020-04-14T01:12:26.597' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (29, 5, 4, 2, CAST(N'2020-05-23T01:12:26.597' AS DateTime), CAST(1990000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-05-23T01:12:26.597' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (30, 6, 5, 3, CAST(N'2020-06-08T01:12:26.597' AS DateTime), CAST(1095000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-06-08T01:12:26.597' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (31, 4, 1, 2, CAST(N'2020-06-14T01:12:26.597' AS DateTime), CAST(1990000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-06-17T01:12:26.597' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (32, 5, 4, 3, CAST(N'2020-08-11T01:12:26.597' AS DateTime), CAST(599000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-08-15T01:12:26.597' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (33, 5, 4, 2, CAST(N'2020-09-14T01:12:26.597' AS DateTime), CAST(4490000.00000 AS Decimal(19, 5)), 0, NULL, NULL, 168702)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (34, 4, 1, 3, CAST(N'2020-09-20T01:12:26.597' AS DateTime), CAST(599000.00000 AS Decimal(19, 5)), 0, NULL, NULL, 168702)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (35, 6, 5, 2, CAST(N'2020-10-11T01:12:26.597' AS DateTime), CAST(4490000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-10-12T01:12:26.597' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (36, 5, 3, 2, CAST(N'2020-10-14T01:12:26.597' AS DateTime), CAST(12970000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-10-17T01:12:26.597' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (37, 6, 5, 2, CAST(N'2020-11-11T01:12:26.597' AS DateTime), CAST(7980000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-11-15T01:12:26.597' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (38, 5, 4, 2, CAST(N'2020-12-14T01:12:26.597' AS DateTime), CAST(3490000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-12-15T01:12:26.597' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (39, 6, 5, 2, CAST(N'2020-02-10T21:16:39.517' AS DateTime), CAST(8388000.00000 AS Decimal(19, 5)), 0, NULL, NULL, 53176)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (40, 6, 5, 3, CAST(N'2020-02-12T21:21:10.407' AS DateTime), CAST(99000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-02-14T21:21:10.407' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (41, 4, 1, 3, CAST(N'2020-08-20T21:21:51.620' AS DateTime), CAST(1589000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-08-20T21:21:51.620' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (42, 5, 3, 3, CAST(N'2020-09-28T21:22:14.607' AS DateTime), CAST(534000.00000 AS Decimal(19, 5)), 2, CAST(N'2020-09-28T21:22:14.607' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (43, 5, 4, 3, CAST(N'2021-06-05T21:22:41.917' AS DateTime), CAST(1747000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-06-09T21:22:41.917' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (44, 4, 2, 3, CAST(N'2021-06-08T21:27:14.080' AS DateTime), CAST(1898000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-06-12T21:27:14.080' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (45, 4, 2, 2, CAST(N'2021-06-09T21:30:46.637' AS DateTime), CAST(1198000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-06-11T21:30:46.637' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (46, 6, 5, 2, CAST(N'2021-06-11T21:31:30.327' AS DateTime), CAST(1498500.00000 AS Decimal(19, 5)), 2, CAST(N'2021-06-12T21:31:30.327' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (47, 6, 5, 2, CAST(N'2021-06-15T21:31:51.620' AS DateTime), CAST(4829000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-06-18T21:31:51.620' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (48, 4, 2, 2, CAST(N'2021-06-22T21:32:15.057' AS DateTime), CAST(1998000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-06-24T21:32:15.057' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (49, 5, 3, 2, CAST(N'2021-06-25T21:32:34.923' AS DateTime), CAST(9178000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-06-25T21:32:34.923' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (50, 4, 2, 2, CAST(N'2021-06-29T21:35:14.623' AS DateTime), CAST(11980000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-07-01T21:35:14.623' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (51, 5, 3, 2, CAST(N'2021-11-02T21:35:28.400' AS DateTime), CAST(21800000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-11-04T21:35:28.400' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (52, 6, 6, 2, CAST(N'2021-11-10T21:35:44.887' AS DateTime), CAST(2786000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-11-11T21:35:44.887' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (53, 6, 6, 2, CAST(N'2021-11-15T21:36:00.747' AS DateTime), CAST(6490000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-11-20T21:36:00.747' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (54, 4, 2, 2, CAST(N'2021-11-18T21:41:51.143' AS DateTime), CAST(4490000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-11-20T21:41:51.143' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (55, 5, 3, 2, CAST(N'2021-11-20T21:41:51.143' AS DateTime), CAST(4490000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-11-21T21:41:51.143' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (56, 4, 1, 2, CAST(N'2021-11-22T21:41:51.143' AS DateTime), CAST(2990000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-11-22T21:41:51.143' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (57, 5, 3, 3, CAST(N'2021-11-30T21:41:51.143' AS DateTime), CAST(1790000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-05T21:41:51.143' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (58, 4, 2, 3, CAST(N'2021-10-12T23:22:09.953' AS DateTime), CAST(499000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-10-17T23:22:09.953' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (59, 4, 1, 3, CAST(N'2021-10-15T23:22:23.277' AS DateTime), CAST(1190000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-10-20T23:22:23.277' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (60, 6, 5, 3, CAST(N'2021-10-20T23:22:58.413' AS DateTime), CAST(999000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-10-24T23:22:58.413' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (61, 5, 3, 3, CAST(N'2021-10-25T23:42:10.383' AS DateTime), CAST(999000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-10-27T23:42:10.383' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (62, 5, 4, 3, CAST(N'2021-10-30T23:42:35.607' AS DateTime), CAST(129000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-10-30T23:42:35.607' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (63, 5, 3, 3, CAST(N'2021-12-01T23:43:17.507' AS DateTime), CAST(2490000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-02T23:43:17.507' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (64, 4, 1, 3, CAST(N'2021-12-02T23:43:37.410' AS DateTime), CAST(1490000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-05T23:43:37.410' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (65, 6, 6, 3, CAST(N'2021-12-03T23:44:01.467' AS DateTime), CAST(3380000.00000 AS Decimal(19, 5)), 1, CAST(N'2021-12-08T23:44:01.467' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (66, 6, 5, 3, CAST(N'2021-12-04T23:44:21.017' AS DateTime), CAST(2580000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-09T23:44:21.017' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (67, 5, 4, 3, CAST(N'2021-12-05T23:44:40.473' AS DateTime), CAST(1800000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-08T23:44:40.473' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (68, 5, 3, 3, CAST(N'2021-12-15T23:44:56.897' AS DateTime), CAST(2100000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-15T23:44:56.897' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (69, 5, 3, 3, CAST(N'2021-12-06T23:45:13.623' AS DateTime), CAST(3180000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-11T23:45:13.623' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (70, 4, 2, 3, CAST(N'2021-12-07T23:45:28.323' AS DateTime), CAST(1796000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-09T23:45:28.323' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (71, 4, 1, 3, CAST(N'2021-12-08T23:45:43.697' AS DateTime), CAST(2380000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-09T23:45:43.697' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (72, 6, 5, 3, CAST(N'2021-12-09T23:46:00.827' AS DateTime), CAST(2490000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-12T23:46:00.827' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (73, 5, 4, 3, CAST(N'2021-12-10T23:46:16.713' AS DateTime), CAST(1998000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-11T23:46:16.713' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (74, 4, 2, 3, CAST(N'2021-12-11T23:46:30.013' AS DateTime), CAST(3180000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-13T23:46:30.013' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (75, 6, 5, 3, CAST(N'2021-12-12T23:46:44.370' AS DateTime), CAST(2997000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-12T23:46:44.370' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (76, 5, 3, 3, CAST(N'2021-12-16T10:01:25.617' AS DateTime), CAST(599000.00000 AS Decimal(19, 5)), 0, NULL, NULL, 372943)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (77, 6, 5, 2, CAST(N'2021-12-16T10:11:18.497' AS DateTime), CAST(11900.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-16T10:11:18.497' AS DateTime), 2, 362125)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (78, 6, 6, 3, CAST(N'2021-12-16T10:22:04.470' AS DateTime), CAST(599000.00000 AS Decimal(19, 5)), 1, CAST(N'2021-12-16T10:22:04.470' AS DateTime), 2, 869918)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (79, 5, 3, 2, CAST(N'2021-12-16T12:59:45.430' AS DateTime), CAST(47600.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-16T13:09:17.967' AS DateTime), 1, NULL)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (80, 6, 6, 3, CAST(N'2021-12-16T13:11:41.963' AS DateTime), CAST(749000.00000 AS Decimal(19, 5)), 1, CAST(N'2021-12-16T13:12:09.957' AS DateTime), 2, 647702)
INSERT [dbo].[Orders] ([id], [idUser], [idShip], [idSeller], [createTime], [totalPrice], [status], [paidTime], [idPaymentMethod], [orderKey]) VALUES (81, 6, 6, 2, CAST(N'2021-12-16T13:15:20.810' AS DateTime), CAST(699000.00000 AS Decimal(19, 5)), 2, CAST(N'2021-12-16T13:15:48.470' AS DateTime), 2, 395119)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[PaymentMethods] ON 

INSERT [dbo].[PaymentMethods] ([id], [name]) VALUES (1, N'Thanh toán khi nhận hàng
')
INSERT [dbo].[PaymentMethods] ([id], [name]) VALUES (2, N'Thanh toán trực tuyến
')
SET IDENTITY_INSERT [dbo].[PaymentMethods] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImages] ON 

INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (1, 1, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975149/n5u2npdxjpbvqoosrtss.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (2, 1, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975150/fglwwqk2pe6ipm8ju6vt.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (3, 1, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975152/ffo60lma5ocdkmnj2vui.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (4, 2, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975370/guoti2hdcqd30kkutizy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (5, 2, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975372/lfy5gkw4oo00uqy7dtc5.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (6, 2, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975373/fjt7yg0iwilphococekw.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (7, 3, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975473/wb9juk8xini0jiv8mzps.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (8, 3, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975475/jfuvul32a0czl3lcsffn.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (9, 3, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975477/zwrivbkbbqvdjqd9xtnc.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (10, 4, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975549/plrty5dybbwiftiteszu.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (11, 4, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975551/qxt7wvllyxdzgbj7df9u.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (12, 4, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975554/xu3ssrzuesrc3ay1dzan.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (13, 4, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975556/mgihpget9bk2pd8wezqm.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (14, 5, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975769/upzmipoadiyxogjcyath.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (15, 5, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975771/ehcah3pzehixu82snayr.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (16, 5, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975772/h9xqmakmtv2abn4exjop.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (17, 6, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975835/o7lbd2sipg39bc4jjcp2.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (18, 6, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975837/g2lmjippf6k9cbsoah1e.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (19, 6, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975839/j2ighusqfyvqqr5ocfpx.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (20, 6, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975840/jln0p9pixkkk2skpklgi.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (21, 7, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975912/d0ndw49t7rsdyxqfprk4.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (22, 7, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975914/dycgxcldorf12tk1iras.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (23, 7, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975915/m9brhezystq5plo7cjuz.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (24, 8, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975978/hysjsh67ueesuhjll4lx.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (25, 8, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975980/jaxv91unkzpbzlblxqcp.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (26, 8, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975981/ig8vrs0iskyossozd6qv.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (27, 8, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636975983/kjynhqfwdytaeirwmvzu.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (28, 9, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976036/xvrkf4oxwxiw9oo4zkih.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (29, 9, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976037/exgrykskl6geqi3splgc.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (30, 9, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976039/vpghbwu1qgohftqnmucg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (31, 9, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976041/ymgys33p6hau14ouiqio.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (32, 10, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976137/q3idkwlecsozim1bqoup.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (33, 10, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976139/nbqz0exblfpodnrklbc1.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (34, 10, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976141/sgixljsajit12ibqxchz.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (35, 11, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976209/okkym18thsm1xavs7rbh.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (36, 11, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976211/ztnga7t5cvqiwq4pwxsn.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (37, 11, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976213/n1vu8biu2shhadr2phlt.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (38, 11, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976214/wrwxvbvmdwofofzlmmeo.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (39, 12, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976292/evagbmkfr0ksw6gxol3x.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (40, 12, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976294/vdjll9motfds6kbic6ia.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (41, 12, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976296/sfv5a7gx9rzgxsf8auex.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (42, 13, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976348/wswdfgy3rqoozirkbxqr.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (43, 13, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976349/nlpal9o58v3pvkyvqefy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (44, 13, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976352/vf2hvtxyow8g8vuxjzjk.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (45, 14, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976401/pllefnia5hnjsnxkadna.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (46, 14, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976403/isqj4p1pbkbiou7b12qp.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (47, 14, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976405/y9fkyi93pqwa8aohq0lh.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (48, 15, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976472/fmofu4sw1rjz7jsjawvh.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (49, 15, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976474/eb1i7amhjnk0p7pzlpit.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (50, 15, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976478/zjao6byai3hs3xflmee0.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (51, 15, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976480/b18zagcxun11vkapnjae.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (52, 16, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976559/mu4qw20xgepxgoo1nbdz.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (53, 16, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976561/zwr91bqzfcz53stj2l7w.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (54, 16, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976563/sjt78ccsxgccpzwkz2y2.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (55, 16, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976565/neeu1ehjtyzntyycsutn.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (56, 17, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976647/owgjvpba3ey41dlzp1dg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (57, 17, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976648/wqwvf4iubd87vp0yolth.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (58, 17, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976650/wcczuxbsigb5tthw0poe.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (59, 18, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976806/ekkmx9ynefpamppqtw65.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (60, 18, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976807/wcebdwzrsp9mvfuhxm47.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (61, 18, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976809/rjzhirgnq8qtfcfsrqvx.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (62, 18, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976814/yysesfft5owau2inaqyc.png')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (63, 19, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976938/wxf57zxye5qb4gzdxuef.png')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (64, 19, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976940/r7hwfdozu36li46ixifg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (65, 19, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976942/fqo58mofpmxn0cki7yfe.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (66, 19, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636976944/camzu9nbdyz5pnkogkal.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (67, 20, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977043/arrkwrvkevxmq5pfjy5g.png')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (68, 20, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977045/bj5rmvfd28yyacadqhzp.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (69, 20, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977047/abxwdfbypgjaeytsibvl.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (70, 20, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977049/i1wkhkyloy4v8ps8gqfk.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (71, 21, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977120/fokusrnzdhh6hivyozvy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (72, 21, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977122/vtpuac14ldmxmdk5bhbx.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (73, 22, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977207/whbwv25r5mycsri87mgn.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (74, 22, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977209/ar0p1fx07snjknhjeat1.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (75, 22, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977211/vhbx6dhiwu89nt8ptda1.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (76, 22, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977212/neanx6ijuexnelvumaln.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (77, 23, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977259/ad5nohmbts5rxanlewms.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (78, 24, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977306/c4jwizu7dg8wtd99pdya.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (79, 24, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977308/blggqpla1j12vsdwihpy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (80, 24, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977309/mvan7wydjpo5bpdwoxhy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (81, 24, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977311/hyz0tqlsp3kjlve7xu3q.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (82, 25, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977373/bbkt6b5fdgv8cttoudeu.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (83, 25, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977375/feojmbqjvvg8ygxkprys.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (84, 25, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977377/s37uptn5mcxnzqyguvdg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (85, 25, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977379/t5piabticbcu700gquqv.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (86, 26, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977650/t4ekobgflcvavariw5lm.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (87, 26, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977652/h5djh3q163i9yhtw2izy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (88, 26, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977653/dhx5lepj1yfeurmiprak.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (89, 26, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977655/uenjqbnkbi9ma7aadyye.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (90, 27, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977740/awjvxagyihyvbd8xjegf.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (91, 27, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977742/xtybuukiyhe7qhv4ifg3.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (92, 27, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977744/wiq0czml7tqahwuninfx.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (93, 27, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977746/txjnk76psfcfeafhhb5n.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (94, 28, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977799/vf6avmoaqbgjcdejnwpu.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (95, 28, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977801/xktctyf1pcnttqpht4pb.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (96, 28, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977803/hlof0r2i71bjdsjfaatt.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (97, 28, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977805/cilalcebdshlp3ygic7r.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (98, 29, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977878/wk58v54kg7roqq6tcel5.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (99, 29, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977880/jet7bsx71buqzrfdrb3r.jpg')
GO
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (100, 29, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977882/lqxjvpccd0qt39exh1yp.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (101, 29, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977884/mefrmm7tvakt2xicx8rp.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (102, 30, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977936/l83maboccvnh9o5s11sa.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (103, 30, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977938/lpvjwxpldljf4g23cdpc.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (104, 30, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977940/gmj9hb97jm5frhqsawbu.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (105, 30, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636977942/kwvrargly5xwf5ugyc8g.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (106, 31, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978038/fcmjbhuvxf9c7iib7mi6.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (107, 31, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978040/iavbdow404c87ghi1xu7.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (108, 31, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978041/slm4n4wlocq5ga74n8l0.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (109, 32, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978109/jqebd9a3tfihwxakx90b.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (110, 32, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978111/oveiqlv0ayhthxnsyr9t.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (111, 32, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978113/ijccds0lfxtii3kbuzfs.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (112, 33, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978164/nxuyedawqvzjjb7stkec.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (113, 33, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978165/flpmby6eyv5sca7sda4r.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (114, 33, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978167/f7bg1d9pdohkxei3hhjy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (115, 33, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978169/f9qbmgsp3m7btdxy7hqf.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (116, 34, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978230/ehdrq62icmpgfl5rlzpa.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (117, 34, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978232/enfnkj5yv5lg2othv4et.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (118, 34, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978234/dknaoefdbcekoafbfvka.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (119, 35, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978514/emajhqhqbdwqvcd4bzrw.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (120, 35, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978516/w9xwbb9whh9ynlz05nml.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (121, 35, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978518/ui6cnaheqw7bkpvnec4x.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (122, 35, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978520/ucer60v7wa8qxndoyikp.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (123, 36, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978566/oqfq2kdszg82tvyhu6oh.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (124, 36, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978567/lxr7nyjmupvqqlpyhckd.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (125, 36, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978569/vpczta7jlpxog4ebje59.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (126, 36, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978571/bijnc00zfym390guequj.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (127, 37, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978633/b2cqhaogvevmckdw5xj5.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (128, 37, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978635/lutsk2kb4h0m7hoyqg72.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (129, 37, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978636/k52g9dzlchtvodswgr1h.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (130, 37, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978638/yxy5yu5qlg4a6tv15nnm.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (131, 38, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978688/lasbvmcbjnfbw6r4y5lq.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (132, 38, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978689/lxyjriblzpdy9eaqmuq3.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (133, 38, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978691/iiydpdcagdwgq0lywdxx.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (134, 38, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978694/d4rkpboeyxdq6cjbmk0h.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (135, 39, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978740/mvfpdjfbj5mfh1s4tbly.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (136, 39, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978741/iwi5bult7io2gdmypixq.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (137, 40, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978785/i7xttqmq7opa8pajfc6w.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (138, 40, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978786/agvwkyjzfpnsfyhqvhvq.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (139, 40, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978788/hygfuhd6105i3sidp9hs.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (140, 40, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978789/kabtpwjqwnilj1nvchv7.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (141, 41, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978925/hp3v3y2bwwrjuhceflqg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (142, 41, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978926/v77glzf7s8nkmtxdib8m.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (143, 41, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636978928/fmfehys6uijg9cwfd8dy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (144, 42, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979013/vwqmyicw2xvmm8yxb10m.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (145, 42, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979014/xperlvjyknocfzl7j9zo.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (146, 42, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979016/zsmf1wtkunne0oyo8axv.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (147, 42, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979018/g6vlrjweoslgzgqpdmgg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (148, 43, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979092/bhqcbngfungsfjni2jz6.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (149, 43, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979093/jyhqj29zmmlkepgrkrro.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (150, 43, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979095/llvfnuu4rmlpxkjwqppk.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (151, 43, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979097/mjyvzkobspuomboxwgyp.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (152, 44, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979247/boq9ldyjuswk4oieup8w.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (153, 44, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979249/unlbomgfambku8yoylwb.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (154, 44, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979250/ka7r4vwabpu8h8sesakl.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (155, 44, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979252/zgyuoecuhi3pne5nghhr.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (156, 45, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979301/usmhmvc6xthlcs1ds1ga.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (157, 45, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979302/tdtfcydrwjhgreyatayq.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (158, 45, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979304/gplavq2cl04r0oejp847.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (159, 45, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979306/wvzrudpdewj4cdjcyxez.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (160, 46, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979361/eexbc34mljqfiradasju.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (161, 46, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979362/l0i3elyheimrclppsvp9.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (162, 46, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979364/bafkydeko46ckbraxitj.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (163, 46, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979366/hcvek9ysr09zl00nel8h.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (164, 47, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979429/hsypmygrxmz3t3jxngei.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (165, 47, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979431/c5t1sokctamw3ytaqcu5.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (166, 47, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979432/jgca5wiohcoemwq9o6ze.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (167, 47, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979434/sjokavfobxzmjcgsidin.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (168, 48, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979489/e7lsuq60uxrba8uvsvuc.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (169, 48, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979491/vcixcs8ql3irxqbh8fhc.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (170, 48, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979493/dfdk4ugeplzgiacx31ko.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (171, 48, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979496/znizlft8xaxi1ahzwihf.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (172, 49, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979536/yk4ivvsduqhvs1b5kbyc.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (173, 49, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636979537/u0z0b3ama7cfomhjqoct.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (174, 50, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980463/ff4lcrmxz1jfnwwwrbmp.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (175, 50, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980465/lbx35vjyzcxtachnkkaw.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (176, 50, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980467/jwscgswfqmfubcg7qnah.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (177, 50, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980469/h9uvddm3cl8yculpqtpu.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (178, 51, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980519/w2bcb7lszid9pxxio4lp.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (179, 51, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980520/tkmhnyjo7fkytdkrkivg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (180, 51, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980522/jjmlk1zedeuegmrsfyfi.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (181, 51, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980524/df5mugabsinpxr1ohwa2.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (182, 52, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980575/ij6ll0novpmabk940me7.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (183, 52, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980576/tvlklxq721hh3ygxoyxg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (184, 52, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980578/oqiq1ljmkfvuif9mse6k.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (185, 52, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980580/tvibxsibbt84gzuoqxne.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (186, 53, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980627/zpvu5hj6oeui9be2qn6t.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (187, 53, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980629/hy7hbyfp7a4iazxd3lzh.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (188, 53, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980631/hstrgnir2e5xokjojtr8.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (189, 54, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980681/ue7skujq40tdudmwhqzc.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (190, 54, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980683/njyycws7ry1mkddh6fzw.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (191, 54, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980685/bqcycrlaiskkwcjqoogf.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (192, 54, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980687/wldnt0ny76x47ufr0gvb.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (193, 55, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980739/avvhsa7unbsc94xvszbj.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (194, 55, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980742/iwqtafxhuythcwtnwqt0.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (195, 55, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980744/rsvebfu7r22w4xnitw7r.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (196, 56, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980782/s8qlscl5qqi5n3pxac7v.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (197, 56, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980783/karhuqhizhdya8d3jwre.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (198, 56, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980785/fne8t7vqepwjbzhrvjxb.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (199, 57, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980847/rxeq7mm8lijojtlqjnje.jpg')
GO
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (200, 57, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980849/nyqid0baij1atmunf55x.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (201, 57, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980851/vl17ubqai44jeelujqtc.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (202, 57, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980854/o6dnbgbebxusiemzxiui.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (203, 58, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980899/q4o9mehxku7f8kscjay4.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (204, 58, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980901/hbzg7omliaigaapoyuna.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (205, 58, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980903/exyxq4axfzh2e1uogexo.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (206, 58, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636980905/f5hdwkabptimubjd01sx.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (207, 59, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981118/n8cbm0zzbzcfeezj3peb.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (208, 59, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981120/c0a6asugspssqb6v85e2.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (209, 59, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981122/m6s0qhkugydcpxm4jwcg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (210, 59, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981124/zk1iwmfmbeowtnsls0et.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (211, 60, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981178/tgg9qmq8rouh7tq0zb00.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (212, 60, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981179/xc3oazmbhjerlbtsamxi.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (213, 60, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981181/jxucnbpisvd4naofjmk6.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (214, 60, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981183/jkf4wpacq9mubjghazmb.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (215, 61, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981240/tnovugq1gfua4qnw5cmp.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (216, 61, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981241/f01ngkppom8vryfhkujr.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (217, 61, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981242/f4oddszqamqga2h6rluq.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (218, 61, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981244/nhkzs5gf5o9t0pzpomiu.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (219, 62, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981292/yxumafvnxdfyv2jxojeq.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (220, 62, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981294/d8t9tpafrvtnpzcn19wr.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (221, 62, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981295/zn4lmt5taukab7kilgww.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (222, 62, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981297/hun5pxerauxvjm0bivvj.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (223, 63, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981364/t0s4dvlqwspvxpc68oly.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (224, 63, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981366/u2ffeplmw8d67kkojieh.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (225, 63, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981367/lvaff7pu72tqaws8xhkz.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (226, 63, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981368/op3s9tf2tcziwssd8dce.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (227, 64, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981408/c6xrprpudjp1vw0w2nis.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (228, 64, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981410/iua017bjh9a6goi0amev.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (229, 64, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981412/id8h58apu2nuq4yvvvc3.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (230, 65, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981466/ja6mrn9rgbbjqnugghsv.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (231, 65, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981467/gkwwzdelyxa8pddfby71.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (232, 65, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981468/buzkub77yrbnlygzm22m.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (233, 65, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981470/ygqbynhxcf1dngiqbgtm.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (234, 66, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981525/glyuzlacb0twxc0vh3ku.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (235, 66, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981527/eu5mxsfxxc1krpr4algu.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (236, 66, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981530/rsb8xtnvg0twvyj7o85v.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (237, 66, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981532/xz8nvrlxtujbsimg8rbk.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (238, 67, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981610/l0vtbf4okzzefamliiuz.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (239, 67, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981611/nqsmo9tvbx3rhbqh5ury.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (240, 67, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981613/unvwzoxwlgjgbwgjlkuy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (241, 67, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981615/ogv4nqgrinddzrtsb9da.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (242, 68, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981685/rk1ympvw0lmlm5qrzddy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (243, 68, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981687/bfqn6gsflniquhzmejau.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (244, 68, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981690/t8fpcwom8kmvfyx5k3ru.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (245, 68, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981692/pzzkrtveedtnjeiprjdw.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (246, 69, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981748/yu5haxgtsy3wankfrlum.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (247, 69, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981750/m6iddww6vwabxkgrtyrt.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (248, 69, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981753/mkgbzwvko5anveyfu7gc.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (249, 69, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981756/qaylexyptyzpuwtxixpl.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (250, 70, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981810/ch63fwdfl6nohjlvl2ty.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (251, 70, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981811/mbdk3wrttxoffxttvfe2.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (252, 70, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981813/zjwl2peub13aebaqeyod.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (253, 70, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981815/fifwkvmyrs2k6pfdgs1t.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (254, 71, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981864/v015h3v0uneexp6rlm63.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (255, 71, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981866/zceq9cbcbb5dzv8tdd9s.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (256, 71, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981868/whxsvntuchezqqbsx9i0.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (257, 71, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981870/w7dvxt74keuqydmyfhjy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (258, 72, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981910/ljotza5btpt8ekpomi2a.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (259, 72, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981912/oywm3sjzzscueol8ex59.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (260, 72, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981914/nbj0fjokqelevevv4maq.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (261, 73, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981987/ucflgsfcixs8swplflsf.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (262, 73, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981989/wxwskatxbrhwjju1wgyz.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (263, 73, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981991/i94qyg4xq3nd4lvqchlw.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (264, 73, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636981993/evb8pm44wdxgwtv5am8a.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (265, 74, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982040/irv61p6rarsoq5bkjrfw.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (266, 74, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982042/bgco0hxfrwtw4rte2l4f.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (267, 74, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982043/mxxi707nmaavasdrculv.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (268, 75, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982077/foewj8tio7xk5xk3eaz6.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (269, 76, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982125/dj7qecudoyrmt70ykjic.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (270, 76, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982127/pc6tvbrwevby16f9rwao.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (271, 77, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982172/yi11xaepbbm3nrtz7uht.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (272, 77, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982174/kkv01jpfntemusas4vxk.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (273, 77, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982175/soohodq9tzrgcqubrukf.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (274, 77, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982177/akujdsjozgma5mbsc8eh.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (275, 78, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982241/s0aq40ylwntmh9anjncv.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (276, 78, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982242/dsby1fkqyuk36eajbs1z.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (277, 78, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982244/tk5nrqmw9c3y7g7haanm.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (278, 78, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982246/evl6lt2dgrsbeogxidia.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (279, 79, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982293/e8b6plitcyw5dbmgniwm.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (280, 79, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982295/brs9tewar2oreipcplcr.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (281, 79, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982297/njgtxsmsvcti07ptepzn.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (282, 79, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982299/f1xelfzonmwwjd3tdjag.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (283, 80, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982361/ahlrcnlblclxfwx0g6ug.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (284, 80, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982363/s4ace1ylkaexkvaydlyw.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (285, 80, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982364/wl7yt81uc69mhfi1qk4a.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (286, 80, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982366/sd8bwhxrtwgznngm8ru0.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (287, 81, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982412/pa3cgnrdnb1pvkuecdey.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (288, 81, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982414/damw4xmlar3puw4sj5sr.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (289, 81, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982416/ju7xhjj9jne9lraqe85f.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (290, 81, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982418/mzxcqnj8jvjptrksl7hg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (291, 82, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982462/lznjqczqvtv4oczuajv0.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (292, 82, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982464/dykwjkeareajattcc1am.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (293, 82, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982466/crejlamrbascytlioxjn.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (294, 82, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982468/omkcdgedgxeuw2dttmsa.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (295, 83, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982513/kacbitrs2ubzlwctkmtk.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (296, 83, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982520/uaq9jovorljv5zr5kbmj.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (297, 83, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982530/hxvdcapgx5wpfhuk79of.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (298, 83, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982532/sp1kihbacgo5j86qhetm.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (299, 84, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982532/jufqyzkr6wwuvv0q4omq.jpg')
GO
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (300, 84, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982542/t2ijpt85hoilp34zjiys.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (301, 84, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982544/oftpnjr2nn7dq2pm1kmh.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (302, 84, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982546/jfeoie6hass4o5z3pmqr.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (303, 85, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982576/mkblncf9ovprukxkj2yd.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (304, 85, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982577/zoiypwx87qpkqwmakof8.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (305, 85, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982579/h1fwtl9qyrogzs6zso1y.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (306, 86, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982624/vlmxntdb8u3gld0jqeux.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (307, 86, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982626/cck68yjzqymbtvn8pvxm.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (308, 86, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982628/mffy0r8mtgyuuy3ivcsa.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (309, 86, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982631/j1q6j8qyies8segpqtyb.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (310, 87, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982694/r55rmifcxkkmrkcchgqn.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (311, 87, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982695/eclwsrygjzy2eswscqdy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (312, 87, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982697/catnxl20sv1lukhtfuww.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (313, 87, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982699/i01y6xm7jj349emfok6y.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (314, 88, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982779/xo9rvl6rmbw00w7q4i2g.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (315, 88, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982780/ezjyg5obiw3efccns48d.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (316, 88, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982782/fqltvxyzbv6rdavldvjt.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (317, 88, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982784/vcrglcmkehpqkxfhrdgn.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (318, 89, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982840/zhkrz2gtqqrgmikarzuf.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (319, 89, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982842/o51ignrhmtclidudtfkx.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (320, 89, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982844/jt0vafidrbtyvbbtxaxc.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (321, 89, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982847/zgokrmlneyxgawghniye.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (322, 90, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982914/xhye1sqzz7ei0vn9yiq1.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (323, 90, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982916/sqcxydiv50h4qfatbukg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (324, 90, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982917/cecnoacesn8hlgajrw6f.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (325, 90, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636982919/rg1nuzul2zypvg8wb00i.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (326, 91, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983387/vnm9e3og1m6gpylv3m2x.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (327, 91, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983389/julykdu7albtljjdoax5.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (328, 91, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983392/eqebwifpt5xlpvcv0z7w.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (329, 92, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983678/yyjwbkqhnvghvq8jifdd.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (330, 92, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983683/oztgxaumwat5tsemmdve.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (331, 92, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983688/cwcafqt6cr1zte8xiidy.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (332, 92, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983691/y4ljztxzydkuxyldttbf.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (333, 93, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983737/cp63uzbe69tiqjrhoyp8.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (334, 93, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983740/jgd1fbivbhewbsnrdwit.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (335, 93, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983743/dzhw7rbptwfml3bk9sau.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (336, 94, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983783/nw0bdvjpwalfjz1jbji2.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (337, 94, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983787/lahzvhwlthkwnyswjg0m.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (338, 94, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983799/lyjt5kdwlhq7bxun3pnh.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (339, 94, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983804/fjqfq98ejxmeql4xcyzg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (340, 95, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983857/qpu4mzufxwric4tsm3y0.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (341, 95, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983860/qdnsbybxh6zfr1yzrdvg.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (342, 95, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983862/mpkiearqgx2bu4pw2myq.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (343, 95, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983866/mxsmlwh4ymnljmkmhpfe.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (344, 96, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983904/ynueu1srfxpxqankzgc9.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (345, 96, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983910/pootfokaf6u7mmydn9s1.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (346, 97, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983942/saoq5leprudmk1azupg5.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (347, 97, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983944/rvnwmscaycrjnfryucsi.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (348, 98, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983977/n6f2dgvhvspeni6r0jse.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (349, 98, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636983979/xbnpxvoyljycg6imhojt.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (350, 99, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984015/vkrtrpgcdtfdfwchz9sv.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (351, 99, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984017/utunqoz1rffjyfoy9uxh.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (352, 99, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984020/ebi9heflsknc8nqwuw4u.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (353, 100, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984070/zgx5ejr4rb2ad94qzgck.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (354, 100, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984072/ltilkx7j0u4jei2juk7g.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (355, 100, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984074/ekphlfnnytzdiqzi9gmz.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (356, 101, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984107/k8gcglyqofz21jwasggz.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (357, 101, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984110/z1l3okw9jyx74juhc78f.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (358, 101, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984113/dfevgxkgc7mbywswm0ut.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (359, 102, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984171/vwglhhbpa6qsj5iijb0g.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (360, 102, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984173/sf61oq4hxfe5fl8edlsn.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (361, 102, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984184/v0g9pxf1pzpkn3732kli.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (362, 102, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984190/zgmmwg31401ybjxfrmn0.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (363, 103, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984233/p0a4mgiiwhkva8ivphds.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (364, 103, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984235/ceemgyij8pphsqhfahx2.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (365, 103, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984237/iju1cwnedbbtloczd14i.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (366, 104, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984274/vvrtrpl4tllmg87a771i.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (367, 104, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984281/yhxrxpdy8kmnwzmeyyuw.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (368, 104, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984286/z35gsujulgt4dmeoqqdz.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (369, 105, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984318/kxgey8esnkdt8frwlrgf.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (370, 105, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984321/e6m6lgoy58hf4sbviqtm.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (371, 106, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984375/tnrxsmg0iip9ly3l4wdj.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (372, 106, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984381/hjvtvxiyox23pdwzsemo.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (373, 106, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984383/zuggqvqw81ulcukly9nv.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (374, 106, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984386/mzmgcmmcy3cukeggpnt5.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (375, 107, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984428/ggwg2yj6upds8saynysb.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (376, 107, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984430/ebvhkts7lhye3es3mohn.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (377, 108, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984480/evlr6iana4n6ytktrn1j.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (378, 108, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984484/nvujoh0bmrvohcdeid8i.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (379, 108, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984487/ig1ncjzb0vwdppwkrqon.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (380, 109, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984522/p3flmrxewxez9soabctf.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (381, 109, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984524/mvjgbdu3esmb38jqrxzm.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (382, 110, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984605/yahjnnvcxdkkzz5fgqhf.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (383, 110, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984610/bz03ddhleur1fdry7psf.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (384, 110, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984612/apldf1hmtyali2yvefhq.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (385, 111, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984647/snazhd2vmjoiby4ziil6.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (386, 111, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984649/vhmsnbihfjmiadbwa3ol.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (387, 111, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984651/h58lxz3pc44sar9wybrm.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (388, 112, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984682/y5nixuflghzunxg5llcr.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (389, 112, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984684/zskkohdtz76gm3ptxgyh.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (390, 112, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984686/noim6hifxy4t2d3lbc1b.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (391, 113, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984789/hb61zjdtq9ssldqgn8r3.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (392, 113, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984791/b37yiclzelvaic0iknb3.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (393, 113, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984793/i5uqaefz38vahlpfd0ys.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (394, 114, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984878/ndo8jfqlu4zjnkqm4yy7.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (395, 115, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984902/ivco2hem8sntkpxk0v1z.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (396, 116, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984968/kfu1gmqqekufbshwaunu.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (397, 116, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984970/tdgtwwwwcdrv6zimqlvc.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (398, 116, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984972/pg6wxk9iffwgzrtdcygq.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (399, 116, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636984974/zaunyxpmkdngxjzzxqml.jpg')
GO
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (400, 117, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985013/h7s1xyqn4kryuk9olbhr.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (401, 117, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985016/nvd8tjdnza17jhprrl53.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (402, 118, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985051/qoqpublkwfmmbtenbxzs.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (403, 118, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985053/wh7pxxf1in2jqcqo3vjx.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (404, 119, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985096/dkzybnodzkrfq36y9dtc.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (405, 119, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985100/otzlnmmxwfslqrgur6ob.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (406, 119, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985103/assbuq7jtl9ttsskboaw.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (407, 119, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985105/xv83eqmk3hb3e0lfqwj9.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (408, 120, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985140/xnxvhxybcrdhbvjmchuz.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (409, 120, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985143/ydxpi89apieg0pgbvm7j.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (410, 120, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985148/z2n8plbxahd359wh59qt.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (411, 121, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985198/rembkhm9hizh9srxstwh.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (412, 121, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985199/lu9tpemvrhpt1q4qch1q.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (413, 121, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985203/z7vlu031jvssrfc28vff.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (414, 122, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985242/pbcmnsl0vemdltgf3sk1.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (415, 122, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985243/xmfgolpgod1atmulun2g.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (416, 122, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985246/zbdollxh3cai6akan1pr.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (417, 123, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985278/lcaibzx1lx2y9lut8o4v.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (418, 123, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985281/gickhc16bty2zfbzqwgn.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (419, 124, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985327/dwgcuoa9ojkacqbnppka.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (420, 124, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985329/hcobddtleti2r9utpkhx.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (421, 124, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985331/ed3ed9ym0oh04ywlzvgm.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (422, 125, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985356/hg21ybqr40rn2d5chlqt.jpg')
INSERT [dbo].[ProductImages] ([id], [idProduct], [imageLink]) VALUES (423, 126, N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636985389/uzsz8falzoptubyf4ylw.jpg')
SET IDENTITY_INSERT [dbo].[ProductImages] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (1, 1, N'BÀN ĂN VERONA', CAST(1990000.000 AS Decimal(19, 3)), N'Bàn ăn VERONA nổi bật với màu trắng tinh khôi được làm từ gỗ công nghiệp bền chắc. Rất phù hợp với những gia đình ít người và không gian phòng bếp hạn chế. Mặt bàn được xử lý kỹ càng, mang vẻ đẹp tinh xảo. Chân bàn làm từ kim loại, cho độ cứng cáp và chắc chắn cao. Bạn có thể kết hợp bàn cùng các sản phẩm khác trong cùng bộ sưu tập VERONA để hoàn thiện nội thất phòng ăn của gia đình bạn.', CAST(N'2021-11-15T18:19:13.857' AS DateTime), 40, 6, -1, 2, 194)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (2, 1, N'BỘ BÀN HỌC SUND', CAST(1490000.000 AS Decimal(19, 3)), N'• Bộ bàn học SUND được thiết kế với một bên đầu bàn gắn liền với giá sách 3 tầng SUND, đầu bàn còn lại kết nối với giá sách 2 tầng có chức năng như chân bàn. Việc kết hợp bàn học với 2 giá sách giúp bạn tối đa hóa không gian lưu trữ, tùy ý sắp xếp sách vở, tài liệu và các vật dụng trang trí.

• Đặc biệt phần giá sách 2 tầng có thể được tùy chỉnh linh hoạt, xoay ra phía ngoài hoặc vào trong theo mong muốn của người sử dụng.

• Một điểm cực kỳ mới nữa là với bàn học SUND này khách hàng có nhiều lựa chọn hơn trước vì Baya có bán rời phần mặt bàn và giá sách 2 tầng. Nếu bạn đã có sẵn một giá sách SUND 3 tầng, chỉ cần mua thêm phần rời này là có thể có một bàn học đa năng ở nhà rồi. Hoặc bạn cũng có thể lựa chọn hai màu khác nhau cho giá sách SUND 3 tầng và phần còn lại (mặt bàn + giá sách 2 tầng) để phối màu thành một bàn học kiêm giá sách dễ thương theo cách bạn muốn.', CAST(N'2021-11-15T18:22:55.293' AS DateTime), 3, 1, 0, 2, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (3, 1, N'BÀN ĂN PHILLIP', CAST(3490000.000 AS Decimal(19, 3)), N'Nhắc tới những mẫu bàn ăn sáng tạo, đầy ấn tượng của BAYA thì nhất định không thể thiếu sản phẩm bàn ăn PHILLIP. Đừng bỏ qua sản phẩm nếu bạn muốn đem tới cho không gian sống của mình cảm giác đơn giản, ấm áp, tinh tế mà vẫn mang đậm phong cách riêng.
Với thiết kế gọn gàng bên cạnh sắc màu sáng tự nhiên của gỗ, bàn ăn PHILLIP dễ dàng phù hợp cho bất kì không gian tổ ấm nào.
Chất liệu: Mặt bàn từ gỗ công nghiệp MFC, chân bàn và khung kết nối bằng sắt sơn tĩnh điện màu đen chắc chắn.
Tính năng: Chỉ có thể sử dụng trong nhà, phù hợp cho 4 người ngồi.
Chất liệu: Vì sử dụng cốt ván dăm nên gỗ MFC có khả năng chịu lực tốt, đặc biệt là lực thẳng đứng. Thêm vào đó, bề mặt Melamine có tác dụng chống trầy xước, chống mài mòn hiệu quả, giúp đồ nội thất được bền lâu và có tính thẩm mỹ cao.
Sản phẩm có thể kết hợp: Sản phẩm nên được sử dụng cùng với các mẫu ghế ăn, ghế đôn làm từ gỗ, có kích thước nhỏ gọn. Ngoài ra, bạn có thể kết hợp thêm các vật dụng trang trí khác như khăn trải bàn Nelly hay bộ tách trà REGATTA để góp phần làm tăng thêm vẻ đẹp tinh tế, trang nhã cho không gian gia đình.
Bàn ăn PHILLIP là thiết kế độc quyền đến từ BAYA, hướng tới những ai yêu thích không gian đơn giản, ấm áp, mang hơi thở hiện đại. Chắc chắn sản phẩm sẽ góp phần giúp căn nhà bạn trở nên ấn tượng hơn rất nhiều.', CAST(N'2021-11-15T18:24:39.147' AS DateTime), 0, 0, 1, 2, 0)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (4, 1, N'BÀN ĂN PHILLIP', CAST(4490000.000 AS Decimal(19, 3)), N'Nhắc tới những mẫu bàn ăn sáng tạo, đầy ấn tượng của BAYA thì nhất định không thể thiếu sản phẩm bàn ăn PHILLIP. Đừng bỏ qua sản phẩm nếu bạn muốn đem tới cho không gian sống của mình cảm giác đơn giản, ấm áp, tinh tế mà vẫn mang đậm phong cách riêng.
Với thiết kế gọn gàng bên cạnh sắc màu sáng tự nhiên của gỗ, bàn ăn PHILLIP dễ dàng phù hợp cho bất kì không gian tổ ấm nào.
Chất liệu: Mặt bàn từ gỗ công nghiệp MFC, chân bàn và khung làm từ kim loại chắc chắn
Tính năng: Chỉ có thể sử dụng trong nhà, phù hợp cho 4 -6 người ngồi.
Chất liệu: Vì sử dụng cốt ván dăm nên gỗ MFC có khả năng chịu lực tốt, đặc biệt là lực thẳng đứng. Thêm vào đó, bề mặt Melamine có tác dụng chống trầy xước, chống mài mòn hiệu quả, giúp đồ nội thất được bền lâu và có tính thẩm mỹ cao.
Sản phẩm có thể kết hợp: Sản phẩm nên được sử dụng cùng với các mẫu ghế ăn, ghế đôn làm từ gỗ, có kích thước nhỏ gọn. Ngoài ra, bạn có thể kết hợp thêm các vật dụng trang trí khác như khăn trải bàn Hung-Vuong hay bộ tách trà REGATTA để góp phần làm tăng thêm vẻ đẹp tinh tế, trang nhã cho không gian gia đình.
Bàn ăn PHILLIP là thiết kế độc quyền đến từ BAYA, hướng tới những ai yêu thích không gian đơn giản, ấm áp, mang hơi thở hiện đại. Chắc chắn sản phẩm sẽ góp phần giúp căn nhà bạn trở nên ấn tượng hơn rất nhiều.', CAST(N'2021-11-15T18:25:58.530' AS DateTime), 9, 5, 1, 2, 195)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (5, 1, N'BÀN ĂN ANNE', CAST(2990000.000 AS Decimal(19, 3)), N'Với đường kính 1m1 và thiết kế gọn gàng bên cạnh sắc màu sáng tự nhiên của gỗ, bàn ăn ANNE dễ dàng phù hợp cho bất kì không gian tổ ấm nào.
Chất liệu: Chân từ gỗ bạch đàn, khung thép kết nối giữa mặt và chân bàn; mặt bàn từ Duranite.
Tính năng: Có thể sử dụng trong nhà và ngoài trời, phù hợp cho 4 người ngồi.
Bạn có biết?
Tấm Duranite là tấm xi măng sợi chất lượng cao, được phủ nhiều lớp với lớp polymer là lớp cơ bản trước khi trải qua quá trình phủ cuối cùng bao gồm quá trình làm cứng đặc biệt. Nhờ vậy mà mặt bàn được làm từ chất liệu này luôn đảm bảo thời gian sử dụng lâu dài, giữ được màu sắc nguyên bản.', CAST(N'2021-11-15T18:29:33.863' AS DateTime), 0, 3, 1, 2, 197)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (6, 1, N'BÀN ĂN PRINCETON', CAST(6990000.000 AS Decimal(19, 3)), N'Đơn giản và hiện đại, bàn ăn PRINCETON là lựa chọn hợp lý cho phòng ăn của gia đình bạn. Bàn được làm từ gỗ cao su, bề mặt phủ veneer sồi màu sẫm đẹp mắt. Chân bàn thu hút với thiết kế lạ mắt, là điểm nhấn ấn tượng cho không gian bàn ăn thêm sang trọng. Hãy kết hợp bàn với các sản phẩm khác trong cùng bộ sưu tập PRINCETON của BAYA.', CAST(N'2021-11-15T18:30:41.937' AS DateTime), 2, 1, 1, 2, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (7, 1, N'BÀN ĂN VENICE', CAST(5990000.000 AS Decimal(19, 3)), N'Bàn ăn VENICE là một thiết kế đặc biệt theo phong cách hiện đại và ấn tượng. Sản phẩm được làm từ gỗ thông/MDF phủ veneer sồi cao cấp. Bàn phối màu gỗ đậm với hoạ tiết vân gỗ tự nhiên độc đáo, sang trọng thích hợp với nhiều không gian dùng bữa khác nhau. Hãy kết hợp với các sản phẩm khác trong bộ sưu tập phòng ăn để hoàn thiện nội thất cho tổ ấm của bạn.', CAST(N'2021-11-15T18:31:57.117' AS DateTime), 0, 1, 1, 2, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (8, 1, N'BÀN GÓC ACCORD', CAST(1990000.000 AS Decimal(19, 3)), N'Tiện nghi ngay trong tầm tay với chiếc bàn góc ACCORD gọn gàng có thể đặt ngay cạnh sofa! Tuy thiết kế đơn giản, chiếc bàn cà phê vẫn thu hút sự tập trung của ta bởi chính sự đơn giản ấy khiến cho từng cạnh, góc bàn nổi trội một cách ấn tượng.
Còn gì nữa ư?
Với chiếc hộc tủ rộng rãi ngay phía dưới mặt bàn, bạn có thể đựng những đồ vật nhỏ không cần thiết, giúp mang lại cảm giác thoáng đãng hơn cho căn phòng.', CAST(N'2021-11-15T18:33:04.557' AS DateTime), 0, 1, 1, 2, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (9, 1, N'BÀN CAO NOTTING-HILL', CAST(3490000.000 AS Decimal(19, 3)), N'Bàn cao đa chức năng màu gỗ tối có thể dùng làm bàn ăn hai người hoặc bàn làm việc đều tiện lợi. Sản phẩm thiết kế đẹp mắt rất phù hợp cho không gian phòng ăn nhỏ, đa chức năng sinh hoạt, đi kèm góc chứa đồ tiện lợi bên hông, có thể để sách vở, tạp chí hoặc dụng cụ bàn ăn khi cần.', CAST(N'2021-11-15T18:34:02.667' AS DateTime), 0, 1, 1, 2, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (10, 1, N'BÀN GÓC CARINE', CAST(3490000.000 AS Decimal(19, 3)), N'Bạn đang tìm kiếm "bạn đồng hành" cho chiếc sofa của mình ư? Không cần phải tìm đâu xa nữa, chiếc bàn góc CARINE chắc hẳn sẽ là lựa chọn lý tưởng, đảm bảo phù hợp với hầu hết các không gian phòng!
Gồm 2 kệ với kích cỡ khác nhau, một dành cho ly thức uống ưu thích của bạn (hay bất kì gì bạn thích), và tầng còn lại cho sách, tạp chí, remote tv... bên cạnh thiết kế tròn trịa thanh lịch, không gì có thể sánh được chiếc bàn góc này đâu!
Sản phẩm là một thiết kế độc quyền của BAYA.', CAST(N'2021-11-15T18:35:42.933' AS DateTime), 20, 1, 1, 2, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (11, 1, N'BÀN TRANG ĐIỂM CARINE', CAST(6990000.000 AS Decimal(19, 3)), N'Góc làm đẹp của bạn xứng đáng được chăm chút tỉ mỉ khi ngày nào mình cũng dành thời gian nơi góc thân thuộc ấy!
Với vẻ ngoài gọn gàng, thanh mảnh, bàn trang điểm CARINE sẽ giúp tâm trạng mình luôn được thoải mái hơn bên cạnh thiết kế thông minh gồm nhiều ngăn kéo và hộc tủ giúp bạn cất giữ đồ mỹ phẩm và những vật dụng cần thiết.
Sản phẩm là một thiết kế độc quyền của BAYA.', CAST(N'2021-11-15T18:36:56.270' AS DateTime), 0, 1, 1, 2, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (12, 1, N'BÀN GÓC KINGSTON', CAST(799000.000 AS Decimal(19, 3)), N'Là sản phẩm của nội thất BAYA, bàn góc KINGSTON thích hợp với các không gian phòng mang hơi thở hiện đại, sang trọng và đầy trang nhã. Bàn được làm từ gỗ ván ép phủ veneer màu nâu đậm, vừa đẹp mắt vừa đảm bảo độ bền lâu dài khi sử dụng. Hãy kết hợp cùng các sản phẩm khác trong bộ sưu tập KINGSTON đến từ BAYA.', CAST(N'2021-11-15T18:38:17.813' AS DateTime), 0, 2, 1, 2, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (13, 1, N'BÀN NGOÀI TRỜI RIVIERA', CAST(699000.000 AS Decimal(19, 3)), N'Bàn ngoài trời RIVIERA là lựa chọn hoàn hảo cho khu vườn nhà của bạn. Thiết kế đơn giản, ấn tượng với khung kim loại bền bỉ có thể gấp gọn và dễ di chuyển giúp tiết kiệm diện tích. Sản phẩm sở hữu mặt gỗ với màu sắc hiện đại, đẹp mắt và góp phần hoàn thiện không gian sống của gia đình bạn.', CAST(N'2021-11-15T18:39:13.543' AS DateTime), 1, 3, 1, 2, 197)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (14, 1, N'BÀN TRANG TRÍ CONNEMARA', CAST(2290000.000 AS Decimal(19, 3)), N'Bàn trang trí CONNEMARA - một thiết kế đặc biệt của BAYA cho bạn tùy ý sắp đặt một lọ hoa hoặc món uống ưa thích như lời chào đầu tiên đến các vị khách quý. Mặt bàn phủ veneer gỗ sồi với vân gỗ đối xứng, cùng những đường bo cạnh và kiểu dáng chân bàn hiện đại mang lại vẻ đẹp sang trọng, ấm cúng cho phòng khách và khu vực sảnh – lối vào.', CAST(N'2021-11-15T18:40:06.673' AS DateTime), 1, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (15, 1, N'TỦ ĐẦU GIƯỜNG SUECIA', CAST(1990000.000 AS Decimal(19, 3)), N'Tủ đầu giường SUECIA mang phong cách châu Âu đương đại gồm 1 ngăn kéo và 1 ngăn chứa mở. Chân gỗ vững chãi phủ sơn xám đem lại vẻ đẹp sang trọng cho căn phòng. Không chỉ là nơi để bạn đặt đèn ngủ hay cuốn sách đọc dang dở, nếu khéo léo sắp xếp và biến tấu đây sẽ là điểm nhấn thu hút của toàn bộ không gian.', CAST(N'2021-11-15T18:41:22.223' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (16, 1, N'BÀN CÀ PHÊ SKAGEN', CAST(1445000.000 AS Decimal(19, 3)), N'Bàn cà phê là món đồ dùng không thể thiếu trong bất kỳ phòng khách nào. Bàn cà phê SKAGEN có kích thước 120x60x50cm với vẻ đẹp mộc mạc và tự nhiên từ gỗ keo. Bàn có thiết kế đơn giản, màu gỗ sáng trang nhã giúp tạo điểm nhấn cho không gian phòng khách. Kết hợp bàn cùng các sản phẩm khác trong cùng bộ sưu tập để hoàn thiện nội thất gia đình bạn.', CAST(N'2021-11-15T18:42:46.483' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (17, 1, N'BÀN NGOÀI TRỜI CAFE-ROYALE', CAST(1790000.000 AS Decimal(19, 3)), N'Là thiết kế của BAYA, bàn ngoài trời CAFE ROYALE là lựa chọn hoàn hảo cho khu vườn nhà của bạn. Được làm bằng thép sơn tĩnh điện giúp hạn chế rỉ sét, bàn phù hợp để sử dụng ngoài trời. Bàn có thiết kế hiện đại với mặt bàn bo tròn và phần chân cứng cáp, góp phần làm đẹp thêm cho khu vườn. Hãy kết hợp sản phẩm trong cùng bộ sưu tập CAFE ROYALE để hoàn thiện không gian sống.', CAST(N'2021-11-15T18:44:12.277' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (18, 1, N'BỘ BÀN TRANG ĐIỂM HARRIS', CAST(5490000.000 AS Decimal(19, 3)), N'BỘ BÀN TRANG ĐIỂM HARRIS gồm:
BÀN TRANG ĐIỂM HARRIS
Bàn trang điểm HARRIS từ gỗ sồi sẽ giúp góc làm đẹp của bạn thêm sang trọng, ấn tượng. Sẽ hoàn hảo hơn khi kết hợp chiếc bàn này cùng trang điểm HARRIS.
• Kích cỡ: L100xD40xH76.
• Chất liệu: Sồi veneer / Sồi / MDF.
GƯƠNG ĐỂ BÀN TRANG ĐIỂM HARRIS
Gương HARRIS từ gỗ sồi sẽ giúp góc làm đẹp của bạn thêm sang trọng, ấn tượng.
• Kích cỡ: D9xW55xH59.
• Chất liệu: Sồi veneer / Sồi / MDF.
GHẾ ĐÔN HARRIS
Chiếc ghế đẩu từ gỗ sồi và phủ sồi với đệm ngồi êm ái. Sản phẩm có độ bền cao, dễ vệ sinh và di chuyển.
• Kích cỡ: L41xW41xH46.
• Chất liệu: Sồi veneer / Sồi / MDF.', CAST(N'2021-11-15T18:46:56.390' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (19, 1, N'BỘ BÀN TRANG ĐIỂM ANN-LOUISE', CAST(5090000.000 AS Decimal(19, 3)), N'BỘ BÀN TRANG ĐIỂM ANN-LOUISE gồm:
BÀN TRANG ĐIỂM ANN-LOUISE
Bàn trang điểm ANN LOUISE thích hợp với các không gian phòng mang hơi thở hiện đại, sang trọng và đầy trang nhã. Bàn được làm từ gỗ keo phủ MDF trắng kèm hộc kéo tiện dụng, vừa đẹp mắt vừa đảm bảo độ bền lâu dài khi sử dụng.
• Kích cỡ: D40xW100xH75.
• Chất liệu: Gỗ keo/ MDF.
GƯƠNG ĐỂ BÀN TRANG ĐIỂM ANN-LOUISE
Nội thất BAYA mang đến gương trang điểm ANN LOUISE khung gỗ sơn trắng, kiểu dáng tinh tế trang nhã, mặt gương cho hình ảnh phản chiếu sắc nét trung thực. Gương được làm từ chất liệu gỗ keo phủ MDF bền chắc.
• Kích cỡ: D13xW55xH59.
• Chất liệu: Gỗ keo/ MDF.
GHẾ ĐÔN ANN-LOUISE
Ghế đẩu ANN LOUISE thích hợp với các không gian phòng mang hơi thở hiện đại, sang trọng và đầy trang nhã. Ghế được làm từ gỗ keo phủ MDF trắng, vừa đẹp mắt vừa đảm bảo độ bền lâu dài khi sử dụng.
• Kích cỡ: D36xW36xH42.
• Chất liệu: Gỗ keo/ MDF.', CAST(N'2021-11-15T18:49:05.687' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (20, 1, N'BỘ BÀN TRANG ĐIỂM KITKA', CAST(4290000.000 AS Decimal(19, 3)), N'BỘ BÀN TRANG ĐIỂM KITKA gồm:
BÀN TRANG ĐIỂM KITKA
Bàn trang điểm KITKA là sản phẩm độc quyền đến từ nội thất BAYA với gam màu gỗ nâu đậm đẹp mắt. Sản phẩm được làm từ gỗ cao su cao cấp, phủ lớp veneer vừa tăng độ bền vừa khiến bàn thêm phần bóng đẹp. Bàn có 2 hộc kéo tiện dụng.
• Kích cỡ: D40xW100xH75.
• Chất liệu: MDF/ gỗ cao su.
GƯƠNG TREO TƯỜNG KITKA
Gương treo tường KITKA đơn giản mang đến phong cách hiện đại cho bất kỳ không gian nào của gia đình bạn. Sản phẩm có khung làm từ gỗ cao su chắc chắn, giữ cho gương luôn được cố định vị trí. Đặt gương vào vị trí phù hợp, bạn có thể thoải mái bổ sung các vật dụng khác để hoàn thiện căn phòng.
• Kích cỡ: D10xW50xH55.
• Chất liệu: MDF/ gỗ cao su.
GHẾ ĐÔN NAGASAKI
Ghế đôn phong cách Nhật Bản với gỗ và đệm ngồi êm ái bọc polyester. Có thể chồng nhiều ghế lên nhau để tiết kiệm không gian.
• Kích cỡ: D40xW43xH44.
• Chất liệu: Ván ép/ vải tổng hợp.', CAST(N'2021-11-15T18:50:50.820' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (21, 1, N'BÀN LÀM VIỆC STUDENT', CAST(2990000.000 AS Decimal(19, 3)), N'Bàn máy tính STUDENT là lựa chọn lý tưởng cho góc làm việc/ học tập của bạn vẻ đẹp mộc mạc và ấn tượng. Sản phẩm được làm từ gỗ công nghiệp bền chắc với họa tiết vân gỗ tự nhiên, cùng khung bằng thép sơn tĩnh điện vững chãi mang lại nét hiện đại cho không gian. Phần kệ bên trên giúp bạn sắp xếp gọn gàng các vật dụng văn phòng hoặc trang trí nhỏ xinh.', CAST(N'2021-11-15T18:52:04.187' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (22, 2, N'GHẾ ĂN VERONA', CAST(999000.000 AS Decimal(19, 3)), N'Ghế ăn VERONA nổi bật với thiết kế ấn tượng cùng chất liệu gỗ ván ép phủ sơn bền chắc, màu sắc tươi sáng. Bề mặt sản phẩm nhẵn đẹp và khung kim loại vững chãi mang lại vẻ sang trọng thích hợp với nhiều không gian nội thất khác nhau.
Hãy kết hợp ghế với các sản phẩm khác trong cùng bộ sưu tập VERONA của BAYA.', CAST(N'2021-11-15T18:53:34.053' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (23, 2, N'GHẾ ĂN PHILLIP', CAST(899000.000 AS Decimal(19, 3)), N'Không gian phòng ăn luôn là nơi lý tưởng cho những khoảnh khắc quây quần bên nhau ấm áp của gia đình, bạn bè và người thân. Một bộ bàn ăn phong cách, đẹp mắt và tinh tế sẽ là chất xúc tác tuyệt vời để mọi giây phút thêm trọn vẹn.
Một chiếc ghế ăn được coi là phù hợp khi chúng đem tới cảm giác thoải mái, dễ chịu vừa vặn cho người ngồi trong suốt bữa ăn. Nhưng nếu chúng còn mang tới nét thẩm mỹ đặc sắc và ấn tượng cho căn phòng của bạn nữa thì đây chắc chắn là một chiếc ghế tuyệt vời mà bạn đang kiếm tìm. Thiết kế tinh tế, độ bền cao, màu sắc trang nhã, ghế ăn PHILLIP bọc vải chân sắt là một trong những sản phẩm được bán chạy của BAYA. Sản phẩm thích hợp sử dụng làm ghế ăn, ghế café, ghế trang điểm, ghế văn phòng, nhà hàng... Vẻ hiện đại không kém phần thanh lịch và đơn giản sẽ là lựa chọn an toàn và vừa vặn cho một căn bếp nhỏ xinh, tạo nên cái nhìn tổng thể nhẹ nhàng, gọn gàng và ngăn nắp cho phòng ăn nhà bạn.', CAST(N'2021-11-15T18:54:20.347' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (24, 2, N'GHẾ CAO NOTTING-HILL', CAST(1690000.000 AS Decimal(19, 3)), N'Nằm trong bộ sưu tập NOTTING HILL làm từ chất liệu gỗ cao su tự nhiên bền chắc, ghế cao NOTTING HILL có kiểu dáng hiện đại trẻ trung. Mặt ghế được bọc vải mềm mại với gam màu xám đẹp mắt và sang trọng. Sản phẩm thích hợp với những gia đình có nội thất theo phong cách châu Á hiện đại tối giản đầy tinh tế.', CAST(N'2021-11-15T18:55:12.863' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (25, 2, N'GHẾ ĂN SACRAMENTO', CAST(1790000.000 AS Decimal(19, 3)), N'Mẫu ghế ăn SACRAMENTO được thiết kế với phần đệm ngồi rộng, tựa lưng cao và bao trọn lưng người ngồi giúp giảm thiểu những áp lực tại các bộ phần từ cổ, vai gáy, lưng người ngồi. Khi sử dụng ghế phòng ăn, người ngồi có thể thoải mái ngả lưng, thả lỏng cơ thể để cảm nhận độ êm ái của ghế. Chiếc ghế êm ái, vững chắc tạo sự yên tâm cho người sử dụng.', CAST(N'2021-11-15T18:56:20.543' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (26, 2, N'GHẾ ĂN ANNE', CAST(973000.000 AS Decimal(19, 3)), N'Lấy cảm hứng từ phong cách thiết kế đương đại của sự tôn vinh đường nét và sự giản đơn, chiếc ghế ăn ANNE tách biệt mình khỏi thiết kế 4 chân truyền thống với 2 khung hợp kim nhôm làm chân tựa.
Chất liệu: Hợp kim nhôm nhẹ nhưng có tính chịu lực cao kết hợp với thân ghế từ nhựa polyester ôm gọn dáng ngồi.
Tính năng: Phù hợp cho sử dụng trong và ngoài trời.', CAST(N'2021-11-15T19:00:56.737' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (27, 2, N'ĐÔN MỀM SARAWAK', CAST(1390000.000 AS Decimal(19, 3)), N'Ghế đôn SARAWAK màu sắc trang nhã với đệm ngồi bọc vải polyester, chân gỗ cao su phủ sơn màu nâu óc chó đẹp mắt. Hãy kết hợp với ghế bành trong cùng bộ sưu tập SARAWAK. Sản phẩm có nhiều màu sắc tươi sáng để bạn chọn lựa.', CAST(N'2021-11-15T19:02:27.303' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (28, 2, N'GHẾ ĂN HATHEN', CAST(1390000.000 AS Decimal(19, 3)), N'Ghế ăn HATHEN sử dụng nguyên liệu gỗ cao su tự nhiên thân thiện với môi trường, thiết kế vừa vặn với mặt ngồi và tựa lưng bọc vải tổng hợp màu xám rất sạch sẽ và dễ phối với các đồ nội thất khác trong phòng ăn.', CAST(N'2021-11-15T19:03:26.457' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (29, 2, N'GHẾ DÀI CÓ HỘC SUECIA', CAST(1990000.000 AS Decimal(19, 3)), N'', CAST(N'2021-11-15T19:04:45.507' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (30, 2, N'ĐÔN MỀM CÓ HỘC BRIGGS', CAST(1390000.000 AS Decimal(19, 3)), N'Đôn mềm có hộc BRIGGS với đệm ngồi bọc vải bố êm ái và khung gỗ vững chắc là một chỗ ngồi phụ lý tưởng, một nơi thư giãn chân khi dùng kèm ghế bành và sofa, hay một chiếc ghế thay giày hữu ích. Sản phẩm có hộc chứa tiện lợi bên dưới, với 2 màu xám & be trang nhã mang lại vẻ đẹp sang trọng cho phòng khách hoặc phòng ngủ của bạn.', CAST(N'2021-11-15T19:05:44.570' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (31, 2, N'GHẾ ĐÔN CONNEMARA', CAST(4990000.000 AS Decimal(19, 3)), N'Ghế đôn CONNEMARA màu xanh dương bọc vải nhung là một trong số thiết kế đặc biệt, bạn có thể kết hợp và bố trí hài hòa với bất kỳ không gian nào.
Thiết kế: Chiều cao vừa phải, mặt ghế rộng rãi kết hợp với 4 chân trụ rộng vững chắc, đảm bảo an toàn tuyệt đối khi sử dụng.
Chất liệu: Khung ghế được làm từ gỗ tự nhiên bền chắc. Phần đệm ngồi làm từ mút bọc vải nhung cao cấp đem lại sự thoải mái, êm ái khi ngồi, đặc biệt là rất ấm áp vào mùa đông.
Độ bền: Phần đệm ngồi được cấu tạo từ mút với độ đàn hồi tốt, không bị sụt lún sau thời gian dài sử dụng như đệm bông ép, đảm bảo độ bền cao.
Tính ứng dụng: Sự độc đáo trong thiết kế giúp sản phẩm có thể dễ dàng phối hợp trong nhiều không gian khác nhau như: phòng khách, phòng vẽ tranh, phòng làm việc...
Những sản phẩm có thể kết hợp: Bạn có thể kết hợp ghế đôn màu xanh dương với sản phẩm ghế sofa CONNEMARA cùng màu để tự tay thiết kế ra không gian sống hoàn hảo nhất.', CAST(N'2021-11-15T19:07:23.120' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (32, 2, N'GHẾ ĐÔN CAO JEFFERSON', CAST(8990000.000 AS Decimal(19, 3)), N'Ghế đôn cao JEFFERSON nổi bật trong số những sản phẩm nội thất được ưa chuộng nhất hiện nay của BAYA mang đến sự mới lạ, độc đáo cho không gian nhà ở.
Thiết kế: Ghế đôn cao JEFFERSON được thiết kế với 4 chân trụ vững chắc, đảm bảo thằng bằng, an toàn tuyệt đối khi sử dụng. Đặc biệt, sản phẩm có thiết kế trụ ngang nối giữa hai phần chân ghế, người dùng rất thuận tiện trong quá trình lên xuống cũng như kê chân thoải mái khi ngồi. Ngoài ra, bề mặt ghế cong tạo cảm giác dễ chịu, thoải mái.
Chất liệu: Sản phẩm được làm từ chất liệu gỗ cao su tự nhiên với thớ gỗ dày, ít co giãn, bề mặt gân gợn sóng với màu sắc tươi sáng.
Độ bền: Chất liệu cao su tự nhiên với đặc tính cứng cáp, dẻo dai và không thấm nước mang đến tuổi thọ sử dụng cao cho sản phẩm.
Tính ứng dụng: Với chất liệu gỗ tự nhiên, phần khung chắc chắn và màu sắc đẹp mắt, sản phẩm rất phù hợp để sử dụng tại quầy bar, bàn bếp... Ngoài ra, sản phẩm cũng có thể được sử dụng cho các bữa tiệc buffet ngoài trời.
Những sản phẩm có thể kết hợp: Sản phẩm có thể kết hợp được với những loại bàn gỗ có chiều cao vượt trội hẳn so với sản phẩm. Ví dụ như những bàn bếp, quầy bar hoặc không gian phòng sách, sân thượng...
Có thể nói, ghế đôn cao JEFFERSON là dòng sản phẩm nội thất đang bán chạy nhất hiện nay. Đặc biệt, đây cũng là một trong những dòng sản phẩm truyền thống góp phần làm nên thương hiệu nội thất BAYA trên thị trường Việt Nam.', CAST(N'2021-11-15T19:08:34.587' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (33, 2, N'GHẾ ĐÔN TOTEM', CAST(349000.000 AS Decimal(19, 3)), N'Hiện nay, ghế đôn TOTEM là dòng sản phẩm được nhiều khách hàng lựa chọn trong bộ sưu tập nội thất của BAYA với kiểu dáng đơn giản nhưng độc đáo, dễ bày trí với nhiều kiểu không gian.
Thiết kế: Ghế đôn TOTEM được thiết kế với 4 chân trụ vững chắc kết hợp với mặt ghế có thiết kế đường viền bo tròn, đảm bảo an toàn tuyệt đối khi sử dụng. Thiết kế mang phong cách Bắc Âu đương đại thanh lịch và tinh tế.
Chất liệu: Sản được làm từ chất liệu gỗ cao su với những đường vân gỗ tự nhiên và màu sắc sáng bóng giúp sản phẩm thu hút sự chú ý của nhiều khách hàng có yêu cầu cao về tính thẩm mỹ.
Độ bền: Ghế làm từ chất liệu gỗ cao su tự nhiên với đặc tính ít co giãn, cứng cáp, dẻo dai với khả năng chống thấm nước tối ưu đem đến sự bền chắc cho sản phẩm.
Tính ứng dụng: Với kích thước nhỏ gọn, nhẹ nhàng, sản phẩm sẽ giúp bạn tiện lợi hơn trong việc sắp xếp, bố trí không gian nội thất mà lại không chiếm quá nhiều diện tích. Sản phẩm dễ dàng phối hợp với nhiều loại không gian khác nhau như phòng ăn, phòng đọc sách hay ban công...
Những sản phẩm có thể kết hợp: Có thể thấy, sự đơn giản trong thiết kế và màu sắc giúp sản phẩm dễ dàng kết hợp với nhiều sản phẩm đi kèm như các kiểu bàn gỗ hình tròn, vuông hay chữ nhật.
Là doanh nghiệp đi đầu trong lĩnh vực bán lẻ nội thất và trang trí, BAYA luôn chú trọng quá trình đổi mới từ khâu thiết kế đến sản xuất để mang đến cho khách hàng những sản phẩm chất lượng cao với giá thành hợp lý.', CAST(N'2021-11-15T19:09:31.077' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (34, 2, N'GHẾ ĐÔN MOZART', CAST(499000.000 AS Decimal(19, 3)), N'Ghế đôn MOZART là một trong những thiết kế đặc biệt trong bộ sản phẩm nội thất của BAYA. Với kiểu dáng gọn nhẹ, ghế đôn MOZART trở thành sự lựa chọn số một của nhiều khách hàng bởi tính thẩm mỹ cao, dễ dàng bày trí ở nhiều không gian nội thất.
Thiết kế: Ghế đôn MOZART được thiết kế với 4 chân trụ vững chắc, kết hợp với đệm ngồi bọc PVC màu đen đem đến sự sang trọng cho không gian sống.
Chất liệu: Phần khung và chân ghế được làm hoàn toàn từ gỗ keo sơn trắng đảm bảo được các tiêu chí về độ bền và tính thẩm mỹ. Phần đệm ngồi của ghế được bọc PVC màu đen sang trọng, hút mắt.
Độ bền: Ghế được làm từ gỗ keo - chất liệu có đặc tính dẻo dai, dễ dàng thích nghi với mọi điều kiện môi trường; khả năng chống chịu trọng lượng lớn hơn so với nhiều loại gỗ khác.
Tính ứng dụng: Ghế đôn MOZART với thiết kế nhỏ gọn, màu trắng đen cơ bản rất dễ để bày trí và kết hợp với bất kì loại không gian nội thất nào hiện nay đem đến sự sang trọng cho tổ ấm của bạn.
Những sản phẩm có thể kết hợp: Màu sắc trắng đen sang trọng của ghế đôn MOZART sẽ phù hợp với những chiếc bàn kính có lót thảm màu trắng hoặc những chiếc bàn gỗ cùng tone màu trắng. Bạn có thể kết hợp ghế sofa da ở phòng khách hoặc bàn trang điểm ở phòng ngủ.', CAST(N'2021-11-15T19:10:35.467' AS DateTime), 0, 1, 1, 2, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (35, 2, N'GHẾ ĂN BIANCA', CAST(699000.000 AS Decimal(19, 3)), N'Kiểu dáng nhỏ gọn, tiện lợi, có thể gấp gọn lại để tiết kiệm không gian giúp ghế ăn Bianca trở thành sản phẩm lý tưởng trong mọi không gian, phù hợp nhất với những khách hàng có diện tích nhà ở khiêm tốn, nhưng vẫn muốn sở hữu những mẫu nội thất tiện dụng.
Thiết kế: Ghế ăn Bianca có thiết kế thấp phù hợp khi kết hợp với bàn ăn BIANCA; có thể gấp, gập; được làm từ gỗ nên khá chắc chắn, vô cùng phù hợp với không gian nhà nhỏ. Với gam màu vàng nâu sáng, chiếc ghế này tô điểm cho các ngôi nhà hiện đại trở nên bừng sáng, tinh tế hơn.
Chất liệu: Với chất liệu 100% gỗ cao su, ghế ăn Bianca vừa nhẹ và tiện di chuyển, vừa có thể gấp gọn lại khi không dùng tới, để tiết kiệm tối đa không gian nhà ở. Gỗ cao su cũng là chất liệu tương đối bền, được BAYA bảo hành lên tới 12 tháng, nên quý khách có thể yên tâm khi chọn trang hoàng ngôi nhà mình bằng mẫu ghế Bianca thời thượng.
Độ bền: So với vải hay ván ép, gỗ cao su là chất liệu dễ sử dụng, dễ dàng cho việc vệ sinh, đồng thời có tuổi đời cao hơn hết thảy. Những chiếc ghế gỗ tuy không êm ái nhưng rất chắc chắn, luôn tạo cảm giác mát mẻ, thông thoáng khi sử dụng.
Tính ứng dụng: Mẫu ghế Bianca bên cạnh việc có thể kết hợp với bàn ăn để cho ra một không gian phòng ăn hiện đại và ấm cúng, còn có thể tận dụng để đọc sách, uống trà, ghế để trẻ em học bài, thậm chí là ghế trang điểm của hội chị em. Thiết kế nhỏ gọn cùng khả năng gấp gập linh động, khách hàng có thể dễ dàng mang ghế Bianca đến bất cứ đâu trong không gian nhà, khiến mẫu ghế này trở nên cực kỳ đa năng.
Sản phẩm có thể kết hợp với: Ghế ăn Bianca kết hợp với bàn ăn Bianca sẽ cho ra một bộ đôi hoàn chỉnh nhất. Tuy nhiên, nếu quý khách không muốn sử dụng bàn ăn gỗ, có thể thay thế bằng những mẫu bàn gỗ phủ MFC hay gỗ ván ép cũng không vấn đề gì. Đây đều là những mẫu bàn có giá thành tiết kiệm, quý khách có thể sắm cho mình cả bộ mà không cần lo sợ nặng nề về vấn đề tài chính.
Sự nhỏ gọn, tiện dụng của ghế ăn Bianca rất đúng với tinh thần của không gian nhà ở thời hiện đại - linh động, tiết kiệm nhưng vẫn đảm bảo tính thẩm mỹ. Với mức giá bán hợp lý, ai cũng có thể dễ dàng sở hữu ngay cho mình mẫu ghế Bianca, thậm chí cả bộ bàn ăn Bianca mà không cần sợ tốn kém quá nhiều.', CAST(N'2021-11-15T19:15:21.513' AS DateTime), 0, 1, 1, 2, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (36, 2, N'GHẾ ĂN AALBORG', CAST(499500.000 AS Decimal(19, 3)), N'Ghế ăn AALBORG góp phần làm hoàn hảo cho không gian phòng ăn đẹp mộc mạc và tinh tế. Sản phẩm được làm từ gỗ cao su và MDF bền chắc. Mặt ngồi bo tròn và phần tựa lưng uốn cong đem lại sự thoải mái, dễ chịu khi ngồi. Màu đỏ hài hòa với màu gỗ tự nhiên giúp tăng thêm nét ấm cúng, kết hợp với bàn ăn AALBORG cho phòng ăn đầy cảm hứng.', CAST(N'2021-11-15T19:16:12.523' AS DateTime), 0, 3, 1, 2, 197)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (37, 2, N'GHẾ ĂN PALL-MALL', CAST(849000.000 AS Decimal(19, 3)), N'Ghế ăn PALL - MALL hướng tới phong cách truyền thống mang hơi hướng hoài cổ đem lại sự ấm áp, gần gũi cho không gian sống. Vì thế đây sẽ là sự lựa chọn hoàn hảo cho những ai yêu thích vẻ đẹp đơn giản, tinh tế.
Thiết kế: Phần khung ghế được làm từ các chi tiết tạo hình vuông cạnh truyền thống, kết hợp với lưng ghế cong mềm tạo cảm giác hài hòa. Các thanh nối phần chân ghế không chỉ tạo điểm nhấn mà còn góp phần tăng thêm độ chắc chắn cho thiết kế của ghế.
Chất liệu: Ghế được làm từ chất liệu gỗ cao su có tính chất dẻo dai, mang đến độ bền bỉ cao.
Độ bền: Gỗ cao su từ lâu luôn được yêu thích vì độ bền chắc, dẻo dai, có thể uốn cong dễ dàng nhờ tính đàn hồi tự nhiên của cây cao su lâu năm. Bởi vậy, BAYA đã chọn loại gỗ này trở thành chất liệu chính trong sản xuất sản phẩm ghế ăn PALL-MALL. Đặc biệt, cao su còn có một đặc tính không thấm, hút nước càng đảm bảo cho độ bền bỉ, chắc chắn theo thời gian.
Tính ứng dụng: Ghế ăn PALL-MALL thích hợp với các không gian sang trọng, cổ điển. Do kích thước nhỏ gọn, sản phẩm có thể dành cho những gia đình 4 - 8 người mà vẫn đảm bảo không gian phòng ăn thoải mái.
Sản phẩm có thể kết hợp: Bạn có thể kết hợp linh hoạt mẫu ghế với nhiều loại bàn khác nhau như bàn vuông, bàn tròn, bàn oval. Đồng thời, bạn cũng có thể kết hợp với lọ hoa, cây cảnh… để tạo điểm sáng cho căn bếp. Đừng quên tham khảo thêm những sản phẩm khác trong cùng bộ sưu tập PALL-MALL để có được sự kết hợp hoàn hảo nhất như bộ bàn ăn 4 ghế PALL - MALL, bàn ăn PALL - MALL...
Nếu bạn và gia đình là những người yêu thích phong cách tối giản mà vẫn muốn tạo điểm nhấn trong căn nhà của mình, hãy lựa chọn ghế ăn PALL - MALL.', CAST(N'2021-11-15T19:17:19.687' AS DateTime), 1, 1, 1, 2, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (38, 2, N'GHẾ ĂN PRINCETON', CAST(1990000.000 AS Decimal(19, 3)), N'Mẫu ghế ăn PRINCETON gây ấn tượng ngay từ lần đầu tiên bởi vẻ đẹp sang trọng, tinh tế, mang đậm hơi thở Á Châu. Dù bạn là người yêu thích phong cách cổ điển hay hiện đại, thì sản phẩm ghế ăn PRINCETON cũng là sự lựa chọn phù hợp nhất.

Thiết kế: Ghế PRINCETON có phần chân làm từ gỗ cao su có đường nét vuông vức, tạo cảm giác vững chãi, chắc chắn. Ngoài ra, sản phẩm có khung ghế thiết kế vuông lớn, có thành ôm sát hai bên vừa thoải mái trong quá trình sử dụng, vừa làm tăng sự sang trọng.
Chất liệu: Chất liệu gỗ cao su với phần chân và khung ghế vô cùng dẻo dai, được mài phẳng mịn và phủ một lớp sơn nâu tự nhiên càng làm tăng độ bóng đẹp. Ngoài ra, ghế ăn PRINCETON có phần lưng tựa cùng đệm ngồi được làm từ vải tổng hợp êm ái, dễ chịu, gợi nét đẹp hiện đại, đơn giản, tinh tế.
Độ bền: Gỗ cao su là loại gỗ bền, dẻo dai và đàn hồi tốt nên rất hạn chế bị nứt, gãy. Bề mặt ghế được mài tỉ mỉ và phủ sơn nâu càng làm tăng độ bóng và bền cho chân ghế, giúp chân ghế hạn chế bị tác động bởi độ ẩm môi trường theo mùa trong quá trình sử dụng. Đệm ngồi và lưng tựa bọc vải tổng hợp hạn chế sự biến đổi, hư hại khi chuyển mùa, nồm ẩm.
Tính ứng dụng: Với thiết kế mang hơi thở Á Châu đương đại, ghế ăn PRINCETON thích hợp với không gian phòng ăn rộng, sang trọng.
Sản phẩm có thể kết hợp: Ghế ăn PRINCETON chủ yếu có thể kết hợp với các mẫu bàn vuông, bàn chữ nhật, để làm tăng thêm nét sang trọng. Tuy nhiên bạn cũng có thể kết hợp mẫu ghế này với các loại bàn tròn, bàn oval cỡ lớn bằng gỗ nếu muốn tăng tính hiện đại.
Có thể nói, ghế ăn PRINCETON với thiết kế sang trọng, quý phái là sự lựa chọn không thể thiếu với gia đình theo phong cách cổ điển/tân cổ điển.', CAST(N'2021-11-15T19:18:15.880' AS DateTime), 0, 2, 1, 2, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (39, 2, N'GHẾ ĐÔN ANN-LOUISE', CAST(999000.000 AS Decimal(19, 3)), N'Được thiết kế bởi BAYA, ghế đôn ANN-LOUISE màu trắng nổi bật, phù hợp với các không gian hiện đại. Bạn hãy thử kết hợp ghế đôn ANN-LOUISE với các sản phẩm khác trong cùng bộ sưu tập ANN-LOUISE đến từ BAYA để góp phần hoàn thiện trang trí cho ngôi nhà của mình.

Thiết kế: Sản phẩm ghế đôn ANN-LOUISE có thiết kế vô cùng độc đáo, sáng tạo với chân ghế tròn thon nhỏ dần. Cùng với đó, tại các góc của chân ghế đều được chạm khắc họa tiết tròn tỉ mỉ, tinh tế, tạo nên điểm nhấn cho thiết kế của sản phẩm. Cùng với đó, mặt ghế tuy vuông mà lại được bo tròn bốn góc mang tới sự mềm mại, sang trọng đến từng chi tiết.
Chất liệu: Ghế đôn có phần khung chân làm từ gỗ keo tự nhiên sơn trắng, mặt ghế làm từ chất liệu MDF cũng được sơn trắng đem lại nét đẹp trang nhã, mới lạ, làm nên nét riêng độc đáo.
Tính ứng dụng: Ghế đôn ANN-LOUISE có kích thước nhỏ, gọn nhẹ, dễ dàng di chuyển khi sử dụng. Với thiết kế tinh tế, sang trọng tới từng chi tiết nhỏ nhất, sản phẩm phù hợp với mọi không gian trong căn nhà của bạn, từ phòng khách, phòng ngủ tới sân vườn. Chắc chắn vẻ đẹp vừa cổ điển, vừa hiện đại này sẽ phù hợp với hầu hết các gia đình.
Sản phẩm có thể kết hợp: Sản phẩm ghế đôn ANN-LOUISE của nhà BAYA có thể kết hợp với nhiều vật dụng khác nhau như để bên giường, bàn trà, sofa hay cạnh lò sưởi, góp phần làm tăng thêm nét sang trọng cho căn nhà của bạn. Bạn cũng có thể đặt thêm lọ hoa trên ghế đôn ANN-LOUISE để tạo điểm nhấn nổi bật, tinh tế, mới lạ. Hãy tham khảo thêm các sản phẩm khác trong bộ sưu tập ANN-LOUISE để có nhiều sự lựa chọn kết hợp hơn.
Ghế đôn ANN-LOUISE là mẫu thiết kế nổi bật của BAYA từ kiểu dáng đến màu sắc, khơi gợi vẻ đẹp đậm chất Châu Âu, vô cùng trang nhã, tinh tế. Chính vì vậy ghế đôn ANN-LOUISE ngoài công dụng của một chiếc ghế, cong là vật trang trí hoàn hảo cho căn nhà của bạn.', CAST(N'2021-11-15T19:19:03.557' AS DateTime), 0, 2, 1, 2, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (40, 2, N'GHẾ ĐÔN NAGASAKI', CAST(599000.000 AS Decimal(19, 3)), N'Ghế đôn NAGASAKI thích hợp với các không gian phòng mang hơi thở hiện đại, sang trọng và đầy trang nhã. Ghế được làm từ gỗ ván ép với lớp đệm ngồi êm ái, vừa đẹp mắt vừa đảm bảo độ bền lâu dài khi sử dụng. Hãy kết hợp cùng các sản phẩm khác trong bộ sưu tập NAGASAKI đến từ BAYA.', CAST(N'2021-11-15T19:19:50.993' AS DateTime), 0, 2, 1, 2, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (41, 3, N'BỘ GIƯỜNG VÀ NỆM SAPA-SET', CAST(3990000.000 AS Decimal(19, 3)), N'', CAST(N'2021-11-15T19:22:09.697' AS DateTime), 0, 2, 1, 2, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (42, 3, N'GIƯỜNG TẦNG GRAFFITI', CAST(5990000.000 AS Decimal(19, 3)), N'Giường tầng GRAFFITI là một trong những giải pháp tốt nhất cho không gian phòng ngủ nhỏ. Sản phẩm được làm từ chất liệu kim loại phủ sơn tĩnh điện trắng sang trọng có thiết kế vững chãi, giúp tiết kiệm diện tích hiệu quả. Thiết kế thông minh giường đi kèm cầu thang tiện dụng để dễ di chuyển.

', CAST(N'2021-11-15T19:23:39.337' AS DateTime), 0, 2, 1, 2, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (43, 3, N'GIƯỜNG CARINE', CAST(10900000.000 AS Decimal(19, 3)), N'Một cái nhìn của BAYA về sự giản đơn được thể hiện rõ nét nơi chiếc giường ngủ CARINE. Làm từ chất liệu MDF phủ veneer sồi cao cấp, chiếc giường CARINE là một phần không thể thiếu cho một giấc ngủ ngon.
Sao lại không mua chung với chiếc bàn góc CARINE chứ? Với tính tương đồng trong thiết kế, hai sản phẩm kệ sẽ là combo lý tưởng cho phòng ngủ nhà bạn!
Sản phẩm là một thiết kế độc quyền của BAYA.', CAST(N'2021-11-15T19:24:59.223' AS DateTime), 0, 2, 1, 2, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (44, 3, N'GIƯỜNG SAPA', CAST(1393000.000 AS Decimal(19, 3)), N'Bạn đang tìm một chiếc giường cho bé yêu? Bạn đang muốn tìm giường đơn phù hợp với không gian nhỏ của mình?
Giường SAPA với mức giá vô cùng hấp dẫn chính là lựa chọn hoàn hảo dành cho bạn. Kích thước vừa vặn, thiết kế mộc mạc đơn giản với gam màu trắng, sản phẩm chính là giải pháp tối ưu cho không gian nhỏ. Màu sơn trắng của giường còn giúp bạn dễ dàng kết hợp với các đồ nội thất khác trong phòng ngủ của mình.', CAST(N'2021-11-15T19:27:34.087' AS DateTime), 0, 2, 1, 2, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (45, 3, N'GIƯỜNG MOZART', CAST(6490000.000 AS Decimal(19, 3)), N'Nằm trong bộ sưu tập cùng tên của BAYA, giường MOZART sở hữu những nét thiết kế đậm chất hiện đại, đề cao sự tối giản mà vẫn thể hiện vẻ đẹp sang trọng.
• Thiết kế: Không quá cầu kỳ và kiểu cách, giường MOZART vẫn gây ấn tượng mạnh bởi sự mộc mạc mà tinh tế, rất phù hợp với khách hàng yêu thích phong cách tối giản. Những đường vân gỗ bắt mắt cùng tone gỗ sáng tự nhiên và màu trắng góp phần làm nổi bật sự sang trọng cho sản phẩm.
• Chất liệu: Phần chân và khung giường làm từ chất liệu gỗ cao su bền chắc, chống mối mọt, chống cong vênh tốt. BAYA luôn nghiên cứu và lựa chọn những chất liệu tốt nhất cho sản phẩm, vì vậy bạn có thể hoàn toàn yên tâm về độ bền của giường MOZART.
• Kích thước 1m2 x 2m: Giường MOZART có chiều dài là 2m, chiều rộng 1m2 vì thế phù hợp cho 1 người ngủ, thích hợp sử dụng cho các bạn thanh thiếu niên hoặc với những người lớn tuổi trong nhà như ông, bà… cần sự yên tĩnh, riêng tư
• Khả năng kết hợp linh hoạt: Bạn có thể dễ dàng kết hợp giường MOZART với các sản phẩm nội thất phòng ngủ khác nhau. Đặc biệt khi kết hợp cùng các sản phẩm trong bộ sưu tập MOZART sẽ tạo nên sự đồng bộ tối đa.
Với thiết kế đơn giản, giường MOZART mang lại cảm giác mộc mạc, ấm cúng và trở thành món đồ nội thất không thể thiếu.', CAST(N'2021-11-15T19:28:27.467' AS DateTime), 0, 1, 1, 2, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (46, 3, N'GIƯỜNG ALBANY', CAST(7990000.000 AS Decimal(19, 3)), N'Là một trong những mẫu giường mới nhất tại BAYA, giường ALBANY hướng tới phong cách Á Châu hiện đại đầy tinh tế. Sản phẩm có kiểu dáng hiện đại kết hợp với màu gỗ đậm truyền thống sẽ là sự lựa chọn hoàn hảo cho nhiều gia đình.
Thiết kế: Giường ALBANY gây ấn tượng bởi thiết kế hiện đại pha lẫn truyền thống. Mọi chi tiết của giường từ phần khung đến phần chân gỗ đều được mài khắc vuông vức, góc cạnh, tạo cảm giác chắc chắn. Phần đầu giường được thiết kế độc đáo bằng những thanh gỗ mài khắc thay vì để nguyên khối như bình thường.
Chất liệu: Giường được làm từ chất liệu gỗ sồi đặc kết hợp với gỗ MDF phủ veneer gỗ sồi bền đẹp. Gỗ sồi đặc là loại gỗ quý, vô cùng chắc chắn, dẻo dai, cũng như chịu được lực tác động mạnh mà không nứt gãy. BAYA liên tục sáng tạo trong việc phối hợp linh hoạt các loại chất liệu với nhau để tận dụng ưu điểm vượt trội riêng, mang đến sản phẩm chất lượng cao mà vẫn có giá thành tốt.
Kích thước 1m2 nhỏ gọn: Giường ALBANY có chiều rộng 1m2 nên chỉ phù hợp cho một người ngủ. Giường sở hữu màu gỗ đậm truyền thống, vì thế đặc biệt phù hợp với những người lớn tuổi trong nhà như ông, bà… cần ngủ riêng để có sự yên tĩnh, riêng tư, tốt nhất cho việc nghỉ ngơi.
Sản phẩm có thể kết hợp với nhiều đồ nội thất khác: Bạn có thể kết hợp sản phẩm giường ALBANY với các mẫu kệ tủ đầu giường, tủ quần áo trong cùng bộ sưu tập ALBANY. Ngoài ra, bạn cũng có thể tham khảo thêm các mẫu đèn ngủ có gam màu ấm cúng, các mẫu nệm foam trong bộ sưu tập AMANDO-COMODO hay nệm lò xo STRATUS để hoàn thiện không gian phòng ngủ.
Với kích thước chỉ 1m2 giường ALBANY là sự lựa chọn hàng đầu của những ai đang tìm kiếm giường đơn, giường cho một người. Đồng thời, giường ALBANY còn có giá cả hợp lý, phải chăng.', CAST(N'2021-11-15T19:29:27.387' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (47, 3, N'GIƯỜNG KITKA', CAST(7990000.000 AS Decimal(19, 3)), N'Nếu bạn đang tìm kiếm một sản phẩm giường đơn, phù hợp với phòng ngủ nhỏ thì đừng bỏ lỡ giường KITKA 1m2 của BAYA. Mẫu giường này sở hữu những nét đẹp cổ điển, ghi đậm dấu ấn những nét thiết kế của người Á Đông.
Thiết kế: Sản phẩm có thiết kế nhỏ gọn, là mẫu giường đơn phù hợp với những căn phòng có diện tích nhỏ hoặc cho một người sử dụng. Phần chân giường có độ cao vừa phải được mài dũa nhỏ dần về phía chân trụ tạo nên sự thanh thoát, vững chãi. Kết hợp cùng gam màu nâu trầm mang lại vẻ đẹp ấm cúng phòng ngủ.
Chất liệu: Giường KITKA có phần khung và chân gỗ được làm từ gỗ cao su bền chắc. BAYA lựa chọn gỗ cao su làm chất liệu chính cho sản phẩm bởi đây là loại gỗ dẻo dai, bền bỉ theo thời gian, không lo bị thấm nước hay mối mọt. Khách hàng hoàn toàn có thể yên tâm về độ bền của giường KITKA, nếu được bảo quản đúng cách thì tuổi thọ sản phẩm có thể lên tới 15 năm.
Kích thước 1m2 vừa đủ: Giường KITKA có chiều dài là 2m, chiều rộng 1m2 vì thế phù hợp cho một người ngủ. Kết hợp với màu gỗ đậm truyền thống, giường KITKA 1m2 đặc biệt phù hợp với những người lớn tuổi trong nhà như ông, bà… cần sự yên tĩnh, riêng tư.
Dễ dàng kết hợp với đồ nội thất khác: Bạn có thể dễ dàng kết hợp giường KITKA với tủ đầu giường và tủ quần áo trong combo phòng ngủ KITKA sẽ tạo nên sự đồng bộ cho không gian. Bên cạnh đó, bạn có thể tham khảo thêm những mẫu nệm khác của BAYA như nệm lò xo PATER-NOSTER, nệm lò xo STRATUS để hoàn thiện không gian nội thất gia đình. 
Với kích thước nhỏ gọn, giường KITKA 1m2 đang được rất nhiều khách hàng săn lùng khi có nhu cầu mua giường đơn.', CAST(N'2021-11-15T19:30:35.853' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (48, 3, N'GIƯỜNG AKIO', CAST(12900000.000 AS Decimal(19, 3)), N'Giường AKIO thuộc bộ sưu tập cùng tên của BAYA lấy cảm hứng từ phong cách nội thất Nhật Bản giản đơn pha trộn với vẻ đẹp Việt Nam tinh tế. Với khung giường rộng rãi làm từ thành phần chất liệu gỗ óc chó cao cấp, sản phẩm sở hữu những đường vân tự nhiên và thiết kế độc đáo mang nét sang trọng và thanh lịch vào ngôi nhà bạn.', CAST(N'2021-11-15T19:31:38.183' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (49, 3, N'GIƯỜNG YOKOHAMA', CAST(3990000.000 AS Decimal(19, 3)), N'Được làm từ chất liệu Polyester mềm mịn, an toàn cho sức khỏe, giường YOKOHAMA đem đến cho bạn cảm giác êm ái, tựa lưng thư giãn sau những giờ mệt mỏi. Sản phẩm có thiết kế đơn giản nhưng toát lên vẻ hiện đại, sang trọng, nhiều kích cỡ, phù hợp với mọi không gian phòng ngủ của gia đình bạn. Với 6 chân gỗ đóng chuẩn vào khung cùng với màu sắc tươi sáng, bắt mắt, sản phẩm tạo sự vững chắc và bền đẹp theo thời gian.', CAST(N'2021-11-15T19:32:19.070' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (50, 3, N'GIƯỜNG SUECIA', CAST(8990000.000 AS Decimal(19, 3)), N'Giường SUECIA được thiết kế tinh tế trên gam màu gỗ tự nhiên & màu trắng trang nhã đem lại vẻ đẹp sang trọng và cảm giác dễ chịu cho không gian thư giãn của bạn. Bắt đầu một buổi tối thảnh thơi trên chiếc giường thoải mái, bạn có thể đọc vài trang sách, hay lắng nghe một bản nhạc dịu nhẹ và chìm vào giấc ngủ say, còn gì tuyệt vời bằng…', CAST(N'2021-11-15T19:47:50.973' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (51, 3, N'GIƯỜNG ALBANY', CAST(9990000.000 AS Decimal(19, 3)), N'Được thiết kế theo phong cách châu Á đương đại, giường ngủ ALBANY góp phần làm hoàn hảo cho không gian phòng ngủ của bạn. Giường được làm từ gỗ sồi cao cấp, phủ lớp veneer màu nâu đậm sang trọng. Phần chân giường chắc chắn với gỗ sồi miếng bản to cứng cáp, đảm bảo độ bền lâu dài cho sản phẩm. Bạn có thể chọn mua giường với kích thước King Size hoặc Queen Size trong bộ sưu tập ALBANY đẹp mắt và tinh tế.', CAST(N'2021-11-15T19:48:45.480' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (52, 3, N'GIƯỜNG RALLY', CAST(6990000.000 AS Decimal(19, 3)), N'Giường ngủ RALLY có kết cấu vững chắc với 4 chân giường từ gỗ cao su và các chân phụ bên dưới khung giường. Thiết kế tinh tế dành cho những ai ưa chuộng phong cách sống tối giản mà vẫn không kém phần sang trọng. Hãy khám phá bộ sưu tập nội thất RALLY từ BAYA để hoàn thiện tổ ấm của mình.', CAST(N'2021-11-15T19:49:41.810' AS DateTime), 2, 1, 1, 2, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (53, 3, N'GIƯỜNG HARRIS', CAST(10900000.000 AS Decimal(19, 3)), N'Là sản phẩm của nội thất BAYA, giường HARRIS mang đến giấc ngủ sâu và ngon hơn cho các thành viên trong gia đình. Giường được làm từ gỗ sồi phủ veneer bền chắc, thiết kế đơn giản nhưng sang trọng và tinh tế. Sản phẩm có chiều cao 109 cm với 3 kích cỡ cho bạn dễ dàng chọn lựa.', CAST(N'2021-11-15T19:50:32.983' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (54, 3, N'GIƯỜNG KEIKO', CAST(10900000.000 AS Decimal(19, 3)), N'Giường KEIKO được thiết kế tinh tế trên gam màu gỗ sáng trang nhã đem lại vẻ đẹp mộc mạc và cảm giác dễ chịu cho không gian thư giãn của bạn. Bắt đầu một buổi tối thảnh thơi trên chiếc giường thoải mái, bạn có thể đọc vài trang sách, hay lắng nghe một bản nhạc dịu nhẹ và chìm vào giấc ngủ say.', CAST(N'2021-11-15T19:51:28.430' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (55, 3, N'GIƯỜNG ALI', CAST(7990000.000 AS Decimal(19, 3)), N'Giường ALI được làm từ chất liệu gỗ thông tự nhiên cho độ bền cao, chắc chắn, gam màu nhẹ nhàng, tươi sáng. Thiết kế tối giản với những thanh dọc mang đến vẻ ngoài ưa nhìn cho sản phẩm. Có 3 kích thước giường cho bạn chọn lựa. Hãy kết hợp với các món nội thất khác trong cùng bộ sưu tập ALI từ BAYA.', CAST(N'2021-11-15T19:52:25.723' AS DateTime), 1, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (56, 3, N'GIƯỜNG KITKA', CAST(9990000.000 AS Decimal(19, 3)), N'Giường ngủ KITKA có thiết kế vững chãi, chất liệu gỗ cao su và màu sắc ấm áp, đem đến vẻ đẹp sang trọng cho căn phòng. Chân giường được trang bị 4 ngăn chứa để bạn đặt sách và các đồ trang trí. Chiều cao của đầu giường khá lý tưởng để đọc sách hay làm việc ngay trên giường. Hãy kết hợp giường với các sản phẩm bàn hay tủ quần áo trong cùng bộ sưu tập để không gian căn hộ thêm sang trọng.', CAST(N'2021-11-15T19:53:06.907' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (57, 3, N'GIƯỜNG MOZART', CAST(7490000.000 AS Decimal(19, 3)), N'Nằm trong bộ sưu tập cùng tên của BAYA, giường MOZART sở hữu những nét thiết kế đậm chất hiện đại, đề cao sự tối giản mà vẫn thể hiện vẻ đẹp sang trọng.
• Thiết kế: Không quá cầu kỳ và kiểu cách, giường MOZART vẫn gây ấn tượng mạnh bởi sự mộc mạc mà tinh tế, rất phù hợp với khách hàng yêu thích phong cách tối giản. Những đường vân gỗ bắt mắt cùng tone gỗ sáng tự nhiên và màu trắng góp phần làm nổi bật sự sang trọng cho sản phẩm.
• Chất liệu: Phần chân và khung giường làm từ chất liệu gỗ cao su bền chắc, chống mối mọt, chống cong vênh tốt. BAYA luôn nghiên cứu và lựa chọn những chất liệu tốt nhất cho sản phẩm, vì vậy bạn có thể hoàn toàn yên tâm về độ bền của giường MOZART.
• Kích thước 1m6 x 2m: Giường MOZART có chiều dài là 2m, chiều rộng 1m6 vì thế phù hợp cho 2 người sử dụng và với những phòng ngủ có diện tích vừa và rộng...
• Khả năng kết hợp linh hoạt: Bạn có thể dễ dàng kết hợp giường MOZART với các sản phẩm nội thất phòng ngủ khác nhau. Đặc biệt khi kết hợp cùng các sản phẩm trong bộ sưu tập MOZART sẽ tạo nên sự đồng bộ tối đa.
Với thiết kế đơn giản, giường MOZART mang lại cảm giác mộc mạc, ấm cúng và trở thành món đồ nội thất không thể thiếu.', CAST(N'2021-11-15T19:54:16.383' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (58, 3, N'GIƯỜNG SUECIA', CAST(6990000.000 AS Decimal(19, 3)), N'Giường SUECIA được thiết kế tinh tế trên gam màu gỗ sậm & màu xám trang nhã đem lại vẻ đẹp mộc mạc và cảm giác dễ chịu cho không gian thư giãn của bạn. Bắt đầu một buổi tối thảnh thơi trên chiếc giường thoải mái, bạn có thể đọc vài trang sách, hay lắng nghe một bản nhạc dịu nhẹ và chìm vào giấc ngủ say, còn gì tuyệt vời bằng…', CAST(N'2021-11-15T19:55:06.717' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (59, 4, N'KỆ SÁCH SUND', CAST(1190000.000 AS Decimal(19, 3)), N'• Kệ sách SUND với 5 ngăn tiện dụng giúp bạn dễ dàng sắp xếp ngăn nắp góc học tập và đồ dùng cần thiết.
• Phù hợp sử dụng trong phòng đọc, phòng khách hoặc phòng ngủ.
• Kết hợp kệ sách cùng những sản phẩm khác trong cùng bộ sưu tập SUND để hoàn thiện không gian sống của bạn.', CAST(N'2021-11-15T19:58:45.637' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (60, 4, N'NGĂN GHÉP KỆ SÁCH SUND', CAST(11900.000 AS Decimal(19, 3)), N'Khi bạn buồn bực vì giá sách hay kệ trang trí đã hết chỗ, hãy sử dụng tấm chia SUND. Chỉ cần chèn vào một hoặc nhiều tấm chia SUND, bạn sẽ tối ưu hóa không gian sử dụng của mình.', CAST(N'2021-11-15T19:59:44.367' AS DateTime), 0, 5, 1, 2, 195)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (61, 4, N'GIÁ/KỆ 3 Ô SUND', CAST(399000.000 AS Decimal(19, 3)), N'• Kệ trang trí SUND được sản xuất từ gỗ MFC phủ melamine cao cấp chống xước, với nhiều màu sắc để bạn lựa chọn.
• Phối hợp các kệ trang trí SUND khác nhau bạn sẽ có ngay nhiều sản phẩm thích hợp với công năng mình mong muốn như kệ trang trí, giá sách, bàn cà phê, kệ tivi, kệ để giày...
• Đừng quên kết hợp với những sản phẩm khác trong cùng bộ sưu tập SUND để hoàn thiện không gian sống của bạn nhé.', CAST(N'2021-11-15T20:00:45.867' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (62, 4, N'GIÁ/KỆ 2 Ô SUND', CAST(299000.000 AS Decimal(19, 3)), N'• Kệ trang trí SUND được sản xuất từ gỗ MFC phủ melamine cao cấp chống xước, với nhiều màu sắc để bạn lựa chọn.
• Phối hợp các kệ trang trí SUND khác nhau bạn sẽ có ngay nhiều sản phẩm thích hợp với công năng mình mong muốn như kệ trang trí, giá sách, bàn cà phê, kệ tivi, kệ để giày...
• Đừng quên kết hợp với những sản phẩm khác trong cùng bộ sưu tập SUND để hoàn thiện không gian sống của bạn nhé.', CAST(N'2021-11-15T20:01:38.893' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (63, 4, N'GIÁ/KỆ 1 Ô SUND', CAST(199000.000 AS Decimal(19, 3)), N'• Kệ trang trí SUND được sản xuất từ gỗ MFC phủ melamine cao cấp chống xước, với nhiều màu sắc để bạn lựa chọn.
• Phối hợp các kệ trang trí SUND khác nhau bạn sẽ có ngay nhiều sản phẩm thích hợp với công năng mình mong muốn như kệ trang trí, giá sách, bàn cà phê, kệ tivi, kệ để giày...
• Đừng quên kết hợp với những sản phẩm khác trong cùng bộ sưu tập SUND để hoàn thiện không gian sống của bạn nhé.', CAST(N'2021-11-15T20:02:50.127' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (64, 4, N'BỘ TỦ QUẦN ÁO 2 CÁNH VÀ TỦ ĐẦU GIƯỜNG SUND', CAST(4990000.000 AS Decimal(19, 3)), N'• Bộ tủ bao gồm một tủ quần áo hai cánh SUND (có kèm tấm chia ngăn tủ) và một tủ đầu giường SUND.
• Khách hàng có thể linh hoạt đặt tủ đầu giường bên trong tủ quần áo hoặc đặt bên cạnh giường tùy theo nhu cầu sử dụng.
• Đừng quên kết hợp với những sản phẩm khác trong cùng bộ sưu tập SUND để hoàn thiện không gian sống của bạn nhé.', CAST(N'2021-11-15T20:03:33.727' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (65, 4, N'KỆ SÁCH SUND', CAST(699000.000 AS Decimal(19, 3)), N'• Kệ sách SUND với 3 ngăn tiện dụng giúp bạn dễ dàng sắp xếp ngăn nắp góc học tập và đồ dùng cần thiết.
• Phù hợp sử dụng trong phòng đọc, phòng khách hoặc phòng ngủ.
• Kết hợp kệ sách cùng những sản phẩm khác trong cùng bộ sưu tập SUND để hoàn thiện không gian sống của bạn.', CAST(N'2021-11-15T20:04:31.723' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (66, 4, N'TỦ QUẦN ÁO SUND', CAST(3990000.000 AS Decimal(19, 3)), N'• Tủ quần áo SUND giúp bạn sắp xếp quần áo của các thành viên gia đình gọn gàng và ngăn nắp hơn. Với tấm đợt chia tủ bán rời bạn có thể tùy chỉnh độ cao từng ngăn tủ theo nhu cầu sử dụng. Bạn cũng có thể ghép nhiều tủ SUND để tạo thành hệ tủ thích hợp với không gian nhà mình.
• Đừng quên kết hợp với những sản phẩm khác trong cùng bộ sưu tập SUND để hoàn thiện không gian sống của bạn nhé.', CAST(N'2021-11-15T20:05:33.633' AS DateTime), 2, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (67, 4, N'KỆ TV ACCORD', CAST(4990000.000 AS Decimal(19, 3)), N'Nếu bạn đang muốn tìm cho mình một chiếc kệ TV vững chắc và đủ chỗ trống để lưu trữ các món đồ cần thiết như dàn PS5 xịn sò của mình thì kệ TV ACCORD chắc hẳn sẽ là lựa chọn lý tưởng!
Với thiết kế mặt kệ dài 1m2, rộng gần nửa mét, chiếc kệ TV phù hợp cho nhiều loại TV với kích cỡ khác nhau. Tích hợp trong sản phẩm là một ngăn chứa rộng rãi, giúp tăng thêm khả năng chứa đồ.', CAST(N'2021-11-15T20:06:57.727' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (68, 4, N'KỆ TV CARINE', CAST(6990000.000 AS Decimal(19, 3)), N'Gọn gàng, đơn giản, và ... bạn có thể biết nói gì hơn nữa đây. Hoàn hảo!
Gồm các hộc với kích cỡ rộng rãi và 3 ngăn tủ kéo, chiếc kệ TV giúp sắp xếp gọn gàng đâu vào đấy từng vật dùng thiết yếu cho bầu không gian thư giãn nhà bạn thêm phần thoải mái.
Sản phẩm là một thiết kế độc quyền của BAYA.', CAST(N'2021-11-15T20:08:14.540' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (69, 4, N'TỦ NGĂN KÉO CARINE', CAST(6990000.000 AS Decimal(19, 3)), N'Nếu bạn cảm thấy một chiếc bàn góc vẫn không thể đủ để cất giữ tất cả đồ dùng thiết yếu của mình thì sao lại không tự thưởng bản thân bằng chiếc tủ có hộc CARINE?
Với 4 ngăn kéo và 1 hộc có cửa lùa rộng rãi, tủ có hộc CARIINE mang đến giải pháp lưu trữ đồ dùng mà bạn vẫn luôn tìm kiếm!
Sao lại không mua cùng với bàn góc CARINE chứ? Với tính tương đồng trong thiết kế, hai sản phẩm kệ sẽ là combo lý tưởng cho phòng ngủ nhà bạn!', CAST(N'2021-11-15T20:09:18.293' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (70, 4, N'KỆ SÁCH RAVENNA', CAST(2990000.000 AS Decimal(19, 3)), N'Tối ưu hóa không gian đọc sách với kệ sách RAVENNA bởi thiết kế thông minh, gọn gàng. Dẫu là kệ sách, kệ RAVENNA có thể sử dụng vào nhiều mục đích khác nhau nhờ vào chất liệu gỗ cao su cao cấp với khung sơn tĩnh điện, đảm bảo chất lượng cao và thời gian sử dụng lâu dài.
Đi kèm với kệ sách RAVENNA là những phụ kiện cùng bộ sưu tập có thể tích hợp trực tiếp lên sản phẩm, cung cấp nhiều tính năng và tiện nghi khác nhau như giá treo mũ, giá treo khăn, gương, kệ trưng bày.', CAST(N'2021-11-15T20:10:17.593' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (71, 4, N'TỦ QUẦN ÁO SUECIA', CAST(6490000.000 AS Decimal(19, 3)), N'Tủ quần áo SUECIA từ BAYA với thiết kế đơn giản và hiện đại, gồm 2 ngăn kéo và không gian treo đồ, cùng chất liệu gỗ mộc mạc sẽ là món đồ hữu dụng và thu hút trong tổ ấm của bạn. Thiết kế của tủ phù hợp với nhiều phong cách nội thất khác nhau, hãy kết hợp cùng các sản phẩm nội thất khác trong cùng bộ sưu tập SUECIA cho ngôi nhà đầy cảm hứng.', CAST(N'2021-11-15T20:11:11.750' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (72, 4, N'TỦ GIÀY BUTLER', CAST(999000.000 AS Decimal(19, 3)), N'Tủ giày BULTER là giải pháp hoàn hảo để sắp xếp gọn gàng những đôi giày của gia đình bạn. Sản phẩm được làm từ ván dăm gam màu tươi sáng với phong cách tối giản và hiện đại. Tủ có 2 hộc kéo vừa vặn, thiết kế thông minh để tiết kiệm không gian tối đa.', CAST(N'2021-11-15T20:11:55.700' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (73, 4, N'GIÁ TREO QUẦN ÁO AKIO', CAST(3990000.000 AS Decimal(19, 3)), N'Giá treo quần áo AKIO thuộc bộ sưu tập cùng tên của BAYA lấy cảm hứng từ phong cách nội thất Nhật Bản giản đơn pha trộn với vẻ đẹp Việt Nam tinh tế. Với thành phần chất liệu gỗ óc chó cao cấp, sản phẩm sở hữu những đường vân tự nhiên và thiết kế độc đáo mang nét sang trọng và thanh lịch vào ngôi nhà bạn. Đây cũng là nơi thay giày lý tưởng cho bạn linh hoạt sử dụng khi cần thiết.', CAST(N'2021-11-15T20:13:14.600' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (74, 4, N'KỆ TV TREVOR', CAST(3990000.000 AS Decimal(19, 3)), N'Kệ TV TREVOR không chỉ hoàn thiện không gian giải trí mà còn giúp bạn lưu trữ nhiều đồ vật hơn với 2 ngăn kéo và 1 ngăn chứa mở. Chân kệ bằng thép để đảm bảo độ vững chắc, mặt sau kệ có các lỗ tròn để bạn luồn dây cáp điện thật gọn gàng. Sản phẩm sẽ hoàn hảo hơn khi kết hợp cùng bàn cà phê TREVOR từ BAYA.', CAST(N'2021-11-15T20:14:04.927' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (75, 4, N'KỆ GIÀY TOBAGO', CAST(799000.000 AS Decimal(19, 3)), N'Với chất liệu gỗ thông, bền đẹp thân thiện với môi trường, giá giày TOBAGO rất thích hợp cho việc cất giữ giầy dép một cách ngăn nắp, sạch sẽ và tô điểm thêm màu sắc cho ngôi nhà của bạn đẹp mắt. Các góc cạnh cạnh được gia công kỹ lưỡng, bề mặt nhẵn bóng tạo tính thẩm mỹ cao, thiết kế chắc chắn, có 6 tầng tiện dụng.', CAST(N'2021-11-15T20:14:38.470' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (76, 4, N'KỆ GIÀY TOBAGO', CAST(499000.000 AS Decimal(19, 3)), N'Với chất liệu gỗ thông, bền đẹp thân thiện với môi trường, giá giày TOBAGO rất thích hợp cho việc cất giữ giầy dép một cách ngăn nắp, sạch sẽ và tô điểm thêm màu sắc cho ngôi nhà của bạn đẹp mắt. Các góc cạnh cạnh được gia công kỹ lưỡng, bề mặt nhẵn bóng tạo tính thẩm mỹ cao, thiết kế chắc chắn, có 3 tầng tiện dụng.', CAST(N'2021-11-15T20:15:29.263' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (77, 4, N'TỦ KÍNH MOZART', CAST(4990000.000 AS Decimal(19, 3)), N'Tủ kính MOZART được thiết kế bởi BAYA sẽ là nơi trưng bày và lưu trữ lý tưởng cho bộ bát đĩa yêu thích hay những vật lưu niệm của bạn. Sản phẩm có khung gỗ chắc chắn, thiết kế có cửa kính gồm nhiều tầng chứa kèm hai ngăn kéo tiện dụng. Mặt trên cùng được giữ lại màu gỗ tự nhiên kết hợp với thân tủ phủ sơn trắng giúp đem lại vẻ đẹp trang nhã, sang trọng cho căn phòng. Hãy bổ sung thêm các món nội thất khác trong bộ sưu tập MOZART từ BAYA cho tổ ấm của mình.', CAST(N'2021-11-15T20:16:19.160' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (78, 4, N'KỆ TV SUECIA', CAST(3990000.000 AS Decimal(19, 3)), N'Kệ TV SUECIA sẽ là điểm nhấn đẹp mắt trong ngôi nhà bạn nhờ phong cách thiết kế Bắc Âu đương đại tối giản, chất liệu cao cấp với màu sắc sang trọng cùng các ngăn lưu trữ tiện dụng. Hãy kết hợp chiếc kệ này với các món nội thất khác trong bộ sưu tập SUECIA từ BAYA để hoàn thiện không gian tiếp đón thật ấm cúng của mình nhé!', CAST(N'2021-11-15T20:17:27.667' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (79, 4, N'KỆ TV DYNAMO', CAST(2495000.000 AS Decimal(19, 3)), N'Là sản phẩm độc quyền của nội thất BAYA, kệ ti vi DYNAMO sẽ là điểm nhấn đẹp mắt của phòng khách. Tủ được làm từ chất liệu gỗ keo bền chắc, gia tăng độ bền cho sản phẩm. Với hai hộc tủ kéo cùng nhiều ngăn nhỏ bên ngoài, bạn có thể thoải mái sắp xếp đồ dùng, tiết kiệm không gian sống. Kết hợp tủ cùng các sản phẩm nội thất khác trong cùng bộ sưu tập DYNAMO để hoàn thiện bày trí.', CAST(N'2021-11-15T20:18:20.510' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (80, 4, N'KỆ TV CORSICA', CAST(5990000.000 AS Decimal(19, 3)), N'Kệ TV CORSICA được làm từ gỗ sồi và MDF phủ veneer sồi cùng gỗ ván ép, cho vẻ đẹp gần gũi và độ bền theo thời gian. Ba ngăn kéo và một kệ mở bên dưới cho bạn thoải mái sắp xếp tạp chí, đầu DVD, ampli… gọn gàng và đẹp mắt. Tận dụng mặt trên của kệ để đặt loa, phụ kiện trang trí, khung ảnh… giúp không gian thư giãn của bạn thêm tiện nghi, dễ chịu.', CAST(N'2021-11-15T20:19:27.750' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (81, 4, N'TỦ BÁT ĐĨA PATERSON', CAST(9990000.000 AS Decimal(19, 3)), N'Tủ bát đĩa PATERSON giúp bạn sắp xếp và bảo quản vật dụng bàn ăn thật tốt và gọn gàng. Sản phẩm làm từ gỗ cao su và MDF bền chắc phủ veneer sang trọng, bắt mắt. Sản phẩm được chia thành nhiều ngăn nhỏ tiện dụng. Hãy khám phá trọn bộ sưu tập PATERSON để hoàn thiện nội thất cho nhà mình.', CAST(N'2021-11-15T20:20:20.260' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (82, 4, N'KỆ TV PATERSON', CAST(7990000.000 AS Decimal(19, 3)), N'Kệ tivi PATERSON đem đến giải pháp trưng bày và lưu trữ hiệu quả cho tổ ấm. Mặt kệ rộng rãi để đặt TV, loa, vật trang trí ... hiệu quả. Mặt sau kệ có 2 lỗ tròn để bạn luồn gọn các dây cáp điện. Sản phẩm được làm từ chất liệu gỗ cao su và MDF phủ veneer sồi đẹp mắt. Hãy khám phá trọn bộ nội thất PATERSON từ BAYA với nhiều sản phẩm chất lượng khác.', CAST(N'2021-11-15T20:21:09.540' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (83, 4, N'TỦ GIÀY GUARDIA', CAST(1790000.000 AS Decimal(19, 3)), N'Tủ giày GUARDIA làm từ gỗ keo bền chắc mang lại vẻ đẹp gần gũi cho ngôi nhà bạn. Thiết kế 3 tầng chứa được từ 6 - 9 đôi giày, với hộc chứa phía trên cho bạn thoải mái sắp xếp những vật dụng nhỏ xinh như chìa khóa, áo mưa, kính râm... Bạn cũng có thể sử dụng mặt trên của tủ cho các món đồ trang trí hoặc để nón bảo hiểm.', CAST(N'2021-11-15T20:22:14.547' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (84, 4, N'TỦ GIÀY GUARDIA', CAST(1790000.000 AS Decimal(19, 3)), N'Tủ giày GUARDIA làm từ gỗ keo bền chắc mang lại vẻ đẹp gần gũi cho ngôi nhà bạn. Thiết kế 3 tầng chứa được từ 6 - 9 đôi giày, với hộc chứa phía trên cho bạn thoải mái sắp xếp những vật dụng nhỏ xinh như chìa khóa, áo mưa, kính râm... Bạn cũng có thể sử dụng mặt trên của tủ cho các món đồ trang trí hoặc để nón bảo hiểm.', CAST(N'2021-11-15T20:22:27.907' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (85, 4, N'CÂY TREO QUẦN ÁO REBEL', CAST(599000.000 AS Decimal(19, 3)), N'Cây treo quần áo REBEL là một thiết kế đặc biệt của BAYA mang lại phong cách đầy cá tính cho không gian sống của bạn. Sản phẩm được làm từ chất liệu thép phủ sơn tĩnh điện bền chắc, vững chãi với màu đen hiện đại, mạnh mẽ. Sở hữu đặc tính nhẹ và dễ di chuyển, đây là vật dụng tiện ích lý tưởng cho bạn thoải mái treo móc quần áo, túi xách, nón...', CAST(N'2021-11-15T20:23:00.983' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (86, 4, N'GIÁ TREO QUẦN ÁO REBEL', CAST(1690000.000 AS Decimal(19, 3)), N'Một sản phẩm thiết kế độc quyền của nội thất BAYA. Giá treo quần áo REBEL có chiều cao 1m48 có thiết kế sang trọng và tiện dụng. Sản phẩm được làm từ chất liệu thép cứng cáp và phủ sơn tĩnh điện màu đen mạnh mẽ. Sản phẩm không chiếm quá nhiều diện tích, gồm 4 bánh xe có thể di chuyển, cho bạn thoải mái treo móc quần áo, tiết kiệm diện tích.', CAST(N'2021-11-15T20:23:52.507' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (87, 4, N'GIÁ TREO QUẦN ÁO VIBORG', CAST(1690000.000 AS Decimal(19, 3)), N'Một thiết kế bởi BAYA. Giá treo quần áo VIBORG phong cách Bắc Âu đương đại giúp bạn giải phóng không gian sống nhờ có thêm các kệ lưu trữ bên dưới. Sản phẩm từ gỗ tự nhiên với đường nét thiết kế đơn giản, gọn nhẹ mà bền bỉ. Hãy khám phá thêm nhiều sản phẩm khác trong bộ sưu tập VIBORG từ BAYA.', CAST(N'2021-11-15T20:25:00.567' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (88, 4, N'TỦ GIÀY KITKA', CAST(2990000.000 AS Decimal(19, 3)), N'Tủ giày KITKA là sản phẩm độc quyền đến từ nội thất BAYA với gam màu gỗ nâu đậm đẹp mắt. Sản phẩm được làm từ gỗ cao su cao cấp, phủ lớp veneer vừa tăng độ bền vừa khiến tủ thêm phần bóng đẹp. Tủ có 2 ngăn cùng 2 hộc kéo tiện dụng. Hãy kết hợp tủ với các sản phẩm giường hay tủ quần áo trong cùng bộ sưu tập để không gian căn hộ thêm sang trọng.', CAST(N'2021-11-15T20:26:26.100' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (89, 4, N'GHẾ THAY GIÀY REBEL', CAST(1390000.000 AS Decimal(19, 3)), N'Một sản phẩm thiết kế độc quyền của nội thất BAYA. Kệ để giày REBEL 3 tầng có thiết kế sang trọng và tiện dụng. Sản phẩm được làm từ chất liệu thép cứng cáp và phủ sơn tĩnh điện màu trắng tinh khôi. Sản phẩm không chiếm quá nhiều diện tích, cho bạn thoải mái sắp xếp giày dép, tiết kiệm diện tích.', CAST(N'2021-11-15T20:27:28.727' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (90, 4, N'TỦ QUẦN ÁO MOZART', CAST(8990000.000 AS Decimal(19, 3)), N'Thiết kế tinh tế với màu trắng trang nhã và nóc tủ màu gỗ cao su tự nhiên, đem lại vẻ đẹp sang trọng cho căn phòng. Sản phẩm đi kèm 1 thanh treo quần áo và 3 giá đỡ. Hãy kết hợp với các món nội thất khác trong bộ sưu tập MOZART từ BAYA.', CAST(N'2021-11-15T20:28:40.643' AS DateTime), 0, 0, 1, 2, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (91, 5, N'GIÁ TREO MŨ RAVENNA', CAST(599000.000 AS Decimal(19, 3)), N'Là giải pháp tiết kiệm không gian hiệu quả nhất, giá để mũ RAVENNA với thiết kế bắt vít gắn tường sẽ giúp mang lại cho sảnh, phòng khách hay bất kì đâu trong tổ ấm mình nơi lưu trữ đồ dùng như nón, mũ bảo hiểm. Hơn thế nữa, với phần gỗ tách rời có thể di chuyển tùy ý, bạn có thể tùy thích điều chỉnh vị trí đặt để mũ hay những món đồ khác.
Giá để mũ RAVENNA có thể kết hợp dễ dàng với các sản khác cùng bộ sưu tập hoặc dùng chung với bộ sưu tập REBEL.', CAST(N'2021-11-15T20:36:34.287' AS DateTime), 0, 0, 1, 3, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (92, 5, N'KỆ GẮN TƯỜNG RAVENNA', CAST(699000.000 AS Decimal(19, 3)), N'Thiết kế thông minh gồm 2 tấm giá đỡ có thể tháo rời, kệ treo tường RAVENNA giúp bạn cá nhân hóa kệ để đồ theo ý riêng của mình bên cạnh tiết kiệm diện tích không gian tổ ấm.
Kết hợp với những sản phẩm cùng bộ sưu tập để mang đến cho sản phẩm những tiện nghi hoàn toàn mới nhưng vẫn giữ đúng tinh thần gọn gàng nguyên bản.', CAST(N'2021-11-15T20:41:32.757' AS DateTime), 0, 0, 1, 3, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (93, 5, N'KHAY TRANG TRÍ RAVENNA', CAST(199000.000 AS Decimal(19, 3)), N'Là sản phẩm phụ kiện đi kèm với các sản phẩm khác trong bộ sưu tập RAVENNA như kệ treo tường kèm gương, kệ sách hay kệ trưng bày, khay đính kèm RAVENNA giúp phát huy tối đa công năng của các sản phẩm khác qua việc cung cấp thêm không gian lưu trữ.', CAST(N'2021-11-15T20:42:24.813' AS DateTime), 0, 0, 1, 3, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (94, 5, N'KỆ TRƯNG BÀY RAVENNA', CAST(99000.000 AS Decimal(19, 3)), N'Là sản phẩm phụ kiện đi kèm với các sản phẩm khác trong bộ sưu tập RAVENNA như kệ treo tường kèm gương, kệ sách hay kệ trưng bày, khay đính kèm RAVENNA giúp phát huy tối đa công năng của các sản phẩm khác qua việc cung cấp thêm không gian lưu trữ.', CAST(N'2021-11-15T20:43:26.020' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (95, 5, N'KỆ TREO TƯỜNG KÈM GƯƠNG RAVENNA', CAST(1290000.000 AS Decimal(19, 3)), N'Bạn luôn có suy nghĩ rằng mình chỉ có thể soi gương trong nhà tắm, qua kính tủ quần áo, hay bàn trang điểm?
Hãy để BAYA phá tan suy nghĩ theo lối mòn ấy với kệ treo tường kèm gương RAVENNA. Nhờ vào thiết kế gọn gàng gắn tường bên cạnh những phụ kiện mang đến nhiều tiện ích khác nhau, kệ treo tường kèm gương RAVENNA biến bất kì nơi đâu trong tổ ấm trở thành một nơi ngắm nhìn.
Phát huy trọn vẹn tính năng hơn với 2 sản phẩm phụ kiện là khay gỗ đi kèm với thiết kế khác nhau của bộ sưu tập RAVENNA.', CAST(N'2021-11-15T20:44:28.063' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (96, 5, N'GIÁ TREO MŨ ROBERT', CAST(299000.000 AS Decimal(19, 3)), N'Giá Để Mũ ROBERT góp phần tạo nên sự ngăn nắp và vẻ đẹp hiện đại cho sảnh & lối vào nhà.
Thiết kế gắn tường từ gỗ keo phủ sơn đen, cho độ bền cao và khả năng chịu lực tốt.
Phần đặt mũ được làm từ các thanh kim loại tròn chắc chắn với vẻ ngoài sáng bóng đẹp mắt.
Ngoài việc đặt tại sảnh và lối vào, bạn cũng có thể sử dụng chiếc Giá treo mũ này tại bất kỳ khu vực nào trong nhà để trưng bày và sắp xếp các đồ vật như khăn tắm, chậu cây cảnh, khung hình, sách, quần áo,...', CAST(N'2021-11-15T20:45:12.163' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (97, 5, N'MÓC TREO ĐỒ GUARDIA', CAST(89000.000 AS Decimal(19, 3)), N'Móc treo đồ tiện ích GUARDIA là một thiết kế đặc biệt của BAYA giúp hoàn thiện phong cách cho ngôi nhà bạn ngay từ sảnh và lối vào. Sản phẩm được làm từ gỗ keo phủ màu sơn trắng trang nhã với 3 đầu móc lớn, dễ dàng sử dụng, độ bền cao và vẻ ngoài đẹp mắt.', CAST(N'2021-11-15T20:45:45.467' AS DateTime), 0, 6, 1, 3, 194)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (98, 5, N'KỆ TRƯNG BÀY NIKKI', CAST(899000.000 AS Decimal(19, 3)), N'Thoải mái sắp xếp các vật dụng cần thiết với giá để đồ NIKKI từ nội thất BAYA. Giá được làm từ chất liệu gỗ keo chắc chắn, phủ sơn đen sang trọng, chia thành 2 tầng để dễ dàng sử dụng. Kết hợp giá cùng các sản phẩm khác trong cùng bộ sưu tập NIKKI để hoàn thiện nội thất.', CAST(N'2021-11-15T20:46:21.303' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (99, 5, N'KỆ GẮN TƯỜNG CATCH', CAST(699000.000 AS Decimal(19, 3)), N'Kệ gắn tường 3 tầng với thiết kế cơ bản, thuần chức năng nhưng không kém phần đẹp mắt và hiện đại nhờ gỗ keo kết hợp các chi tiết kim loại. Sản phẩm có độ bền cao và dễ lắp đặt. Hãy bổ sung trọn bộ sưu tập nội thất bằng gỗ keo CATCH từ BAYA dành cho sảnh và lối vào.', CAST(N'2021-11-15T20:47:01.693' AS DateTime), 0, 1, 1, 3, 199)
GO
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (100, 5, N'KỆ TRƯNG BÀY LIPIZZAN', CAST(999000.000 AS Decimal(19, 3)), N'Được làm từ chất liệu MDF phủ veneer sồi bền chắc, giá để đồ LIPIZZAN nổi bật với thiết kế đơn giản nhưng sang trọng và cực kỳ tiện dụng. Sản phẩm giúp bạn sắp xếp và bày trí các vật dụng vừa ngăn nắp vừa nghệ thuật, đẹp mắt. Giá để đồ có nhiều màu sắc và kích thước khác nhau cho bạn thoải mái chọn lựa. Đây là dòng sản phẩm cực kỳ độc đáo đến từ nội thất BAYA.', CAST(N'2021-11-15T20:47:56.253' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (101, 5, N'KỆ TRƯNG BÀY LIPIZZAN', CAST(899000.000 AS Decimal(19, 3)), N'Kệ trưng bày LIPIZZAN có thiết kế trang nhã, sang trọng, làm từ gỗ MFC và veneer gỗ sồi chắc chắn. Sản phẩm chống thấm nước và có thể dễ dàng làm sạch, với bề mặt nhẵn đẹp là nơi tuyệt vời cho bạn sắp xếp sách vở, đồ chơi, chậu cây, bình hoa… và các món đồ trang trí nhỏ xinh, cùng các vật dụng cần thiết khác.', CAST(N'2021-11-15T20:48:34.770' AS DateTime), 2, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (102, 5, N'KỆ GẮN TƯỜNG REBEL', CAST(699000.000 AS Decimal(19, 3)), N'Giá treo tường REBEL đơn giản mang đến phong cách hiện đại cho bất kỳ không gian nào của gia đình bạn. Sản phẩm có khung làm từ thép phủ sơn tĩnh điện chắc chắn, giữ cho giá luôn được cố định vị trí. Đặt giá vào vị trí phù hợp, bạn có thể thoải mái bổ sung các vật dụng khác để hoàn thiện căn phòng.', CAST(N'2021-11-15T20:49:51.457' AS DateTime), 0, 0, 1, 3, 200)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (103, 5, N'KỆ PHÒNG TẮM CIROCCO', CAST(149000.000 AS Decimal(19, 3)), N'Giá treo đồ CIRICCO sử dụng gỗ cao su chất lượng cao, mang đến sự bền chắc và an toàn cho người dùng. Sản phẩm sở hữu thiết kế đơn giản, với 1 thanh ngang thoải mái treo khăn, móc đồ và giữ cho nhà tắm thật gọn gàng, ngăn nắp. Giá treo đồ dễ dàng lắp đặt, tiết kiệm diện tích giúp cho phòng tắm trở nên hiện đại, sang trọng, tiện nghi hơn.', CAST(N'2021-11-15T20:50:38.860' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (104, 5, N'TỦ GẮN TƯỜNG PHÒNG TẮM DELPHI', CAST(1790000.000 AS Decimal(19, 3)), N'Tủ gắn tường phòng tắm DELPHI với chất liệu gỗ sồi bền chắc, thiết kế đơn giản và màu sắc tươi sáng mang lại vẻ đẹp mộc mạc, hiện đại cho không gian thư giãn của bạn. 3 ngăn kệ mở ở hai bên, cùng tủ chứa 3 ngăn rộng rãi cho bạn thoải mái sắp xếp các vật dụng phòng tắm. Tủ được lắp gương tiện dụng và đẹp mắt.', CAST(N'2021-11-15T20:51:27.707' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (105, 5, N'GIÁ TREO MŨ MITFORD', CAST(499000.000 AS Decimal(19, 3)), N'Giá để mũ MITFORD được làm từ gỗ keo và 5 đầu móc giúp bạn sắp xếp và lưu trữ hiệu quả mà không chiếm nhiều diện tích trong nhà. Giá được phủ lớp sơn trắng vừa tăng độ bền vừa thể hiện tính thẩm mỹ cao. Kết hợp giá với các sản phẩm khác trong cùng bộ sưu tập đến từ nội thất BAYA.', CAST(N'2021-11-15T20:52:08.393' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (106, 5, N'KỆ GẮN TƯỜNG CÓ NGĂN KÉO EDEN', CAST(1190000.000 AS Decimal(19, 3)), N'Kệ gắn tường có hộc EDEN do BAYA thiết kế giúp bạn thoải mái sắp xếp các vật dụng cần thiết một cách gọn gàng nhất. Đây cũng là nơi trưng bày những món đồ trang trí nhỏ xinh, phù hợp cho phòng khách, phòng ngủ hay lối vào. Sản phẩm làm từ gỗ thông và gỗ cao su thiên nhiên phối màu sơn trắng trang nhã cho độ bền cao và vẻ đẹp hiện đại.', CAST(N'2021-11-15T20:53:07.910' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (107, 5, N'TỦ GẮN TƯỜNG PHÒNG TẮM EDEN', CAST(999000.000 AS Decimal(19, 3)), N'Tủ gương EDEN là giải pháp tiết kiệm không gian tối ưu cho gia đình bạn. Tủ được làm từ gỗ thông chắc chắn, mặt kính bên ngoài cùng nhiều ngăn nhỏ bên trong, để bạn dễ dàng sắp xếp các vật dụng cần thiết mà vẫn giữ được thẩm mỹ cho không gian. Kết hợp tủ với các sản phẩm khác trong cùng bộ sưu tập EDEN để hoàn thiện nội thất.', CAST(N'2021-11-15T20:53:51.620' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (108, 5, N'KỆ GẮN TƯỜNG CÓ MÓC TREO MARTIN', CAST(999000.000 AS Decimal(19, 3)), N'', CAST(N'2021-11-15T20:54:48.350' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (109, 5, N'MÓC TREO ĐỒ REBEL', CAST(129000.000 AS Decimal(19, 3)), N'Móc REBEL có thiết kế đẹp đơn giản và chất liệu thép sơn tĩnh điện chắc chắn. Sản phẩm hỗ trợ bạn treo móc quần áo, túi xách, nón mũ... tiện lợi. Một bộ sản phẩm gồm 5 móc màu trắng, đính liền trên thanh ngang. Móc REBEL thích hợp với nhiều không gian nội thất khác nhau, từ cổ điển đến hiện đại.', CAST(N'2021-11-15T20:55:26.153' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (110, 6, N'GƯƠNG ĐỨNG MIRAMAR', CAST(2490000.000 AS Decimal(19, 3)), N'', CAST(N'2021-11-15T20:56:54.203' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (111, 6, N'GƯƠNG TREO TƯỜNG MIRAMAR', CAST(1490000.000 AS Decimal(19, 3)), N'', CAST(N'2021-11-15T20:57:32.920' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (112, 6, N'GƯƠNG TREO TƯỜNG MIRAMAR', CAST(1690000.000 AS Decimal(19, 3)), N'', CAST(N'2021-11-15T20:58:07.803' AS DateTime), 0, 2, 1, 3, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (113, 6, N'GƯƠNG TREO TƯỜNG MIRAMAR', CAST(1290000.000 AS Decimal(19, 3)), N'', CAST(N'2021-11-15T20:59:55.133' AS DateTime), 0, 2, 1, 3, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (114, 6, N'GƯƠNG TREO TƯỜNG MIRA', CAST(600000.000 AS Decimal(19, 3)), N'', CAST(N'2021-11-15T21:01:19.677' AS DateTime), 0, 3, 1, 3, 197)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (115, 6, N'GƯƠNG TREO TƯỜNG MIRA', CAST(700000.000 AS Decimal(19, 3)), N'', CAST(N'2021-11-15T21:01:43.743' AS DateTime), 0, 3, 1, 3, 197)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (116, 6, N'GƯƠNG ĐỨNG GUARDIA', CAST(1590000.000 AS Decimal(19, 3)), N'', CAST(N'2021-11-15T21:02:57.630' AS DateTime), 0, 2, 1, 3, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (117, 6, N'GƯƠNG TREO TƯỜNG GUARDIA', CAST(449000.000 AS Decimal(19, 3)), N'Là một thiết kế của nội thất BAYA, gương treo tường GUARDIA ghi điểm với thiết kế đơn giản đầy tinh tế. Phần khung được làm từ gỗ keo chắc chắn, gương dày dặn, cho độ bền cao. Sản phẩm thích hợp với nhiều không gian nội thất khác nhau, từ hiện đại cho đến cổ điển.', CAST(N'2021-11-15T21:03:37.817' AS DateTime), 0, 4, 1, 3, 196)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (118, 6, N'GƯƠNG TREO TƯỜNG GUARDIA', CAST(1190000.000 AS Decimal(19, 3)), N'Gương treo tường GUARDIA với khung làm từ gỗ keo tự nhiên bền chắc mang lại nét đẹp gần gũi, hiện đại cho ngôi nhà bạn. Sản phẩm là một thiết kế đặc biệt của BAYA, thích hợp đặt tại sảnh và lối vào cũng như trong phòng ngủ. Đơn giản và gọn nhẹ, chiếc gương này không chỉ tiện lợi mà còn là điểm nhấn thu hút cho căn phòng.', CAST(N'2021-11-15T21:04:14.523' AS DateTime), 0, 2, 1, 3, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (119, 6, N'GƯƠNG ĐỨNG KITKA', CAST(2490000.000 AS Decimal(19, 3)), N'Gương đứng KITKA mang lại nét đẹp cổ điển cho không gian với tông màu nâu trầm và thiết kế theo phong cách retro. Gương cao 165cm, có thể thoải mái điều chỉnh độ nghiêng. Kết hợp cùng các sản phẩm khác trong bộ sưu tập KITKA đến từ BAYA để hoàn thiện việc bày trí nội thất cho ngôi nhà bạn.', CAST(N'2021-11-15T21:05:07.157' AS DateTime), 0, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (120, 6, N'GƯƠNG TREO TƯỜNG KITKA', CAST(999000.000 AS Decimal(19, 3)), N'Gương treo tường KITKA đơn giản mang đến phong cách hiện đại cho bất kỳ không gian nào của gia đình bạn. Sản phẩm có khung làm từ gỗ cao su chắc chắn, giữ cho gương luôn được cố định vị trí. Đặt gương vào vị trí phù hợp, bạn có thể thoải mái bổ sung các vật dụng khác để hoàn thiện căn phòng.', CAST(N'2021-11-15T21:05:50.820' AS DateTime), 0, 2, 1, 3, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (121, 6, N'GƯƠNG ĐỨNG MOZART', CAST(1590000.000 AS Decimal(19, 3)), N'Gương đứng MOZART do BAYA thiết kế sẽ đem đến vẻ đẹp trang nhã, sang trọng cho không gian nội thất. Sản phẩm có thể gấp gọn và dễ di chuyển, giúp bạn tiết kiệm diện tích phòng thật hiệu quả. Hãy khám phá thêm các món nội thất còn lại trong bộ sưu tập MOZART bằng gỗ cao su từ BAYA.', CAST(N'2021-11-15T21:06:45.373' AS DateTime), 0, 2, 1, 3, 198)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (122, 6, N'GƯƠNG ĐỂ BÀN TRANG ĐIỂM ANN-LOUISE', CAST(999000.000 AS Decimal(19, 3)), N'Nội thất BAYA mang đến gương trang điểm ANN LOUISE khung gỗ sơn trắng, kiểu dáng tinh tế trang nhã, mặt gương cho hình ảnh phản chiếu sắc nét trung thực. Gương được làm từ chất liệu gỗ keo/MDF bền chắc. Gương trang điểm ANN LOUISE là món phụ kiện không thể thiếu của phái đẹp được thiết kế bởi BAYA.', CAST(N'2021-11-15T21:07:27.740' AS DateTime), 0, 3, 1, 3, 197)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (123, 6, N'GƯƠNG TREO TƯỜNG MITFORD', CAST(749000.000 AS Decimal(19, 3)), N'Chiếc gương treo tường MITFORD được làm từ chất liệu gỗ keo cao cấp, tạo độ bền cho sản phẩm. Thiết kế gương hình chữ nhật đơn giản, sang trọng và tinh tế. Bạn có thể treo gương lên tường tạo điểm nhấn hoặc kết hợp cùng tủ trong bộ sưu tập MITFORD để tăng thêm tính thẩm mỹ cho không gian sống.', CAST(N'2021-11-15T21:08:02.527' AS DateTime), 69, 6, 1, 3, 194)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (124, 6, N'GƯƠNG ĐỂ BÀN TRANG ĐIỂM ALI', CAST(599000.000 AS Decimal(19, 3)), N'Gương ALI với khung gỗ thông đẹp mắt, chắc chắn, khi kết hợp với bàn trang điểm ALI sẽ là một cặp sản phẩm hoàn hảo. Hãy bổ sung thêm các món nội thất khác bằng gỗ thông trong bộ sưu tập ALI từ BAYA để hoàn thiện tổ ấm của mình.', CAST(N'2021-11-15T21:08:53.497' AS DateTime), 5, 8, 1, 3, 192)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (125, 6, N'GƯƠNG TREO TƯỜNG REBEL', CAST(1190000.000 AS Decimal(19, 3)), N'Gương treo tường REBEL đơn giản mang đến phong cách hiện đại cho bất kỳ không gian nào của gia đình bạn. Sản phẩm có khung làm từ thép phủ sơn tĩnh điện chắc chắn, giữ cho gương luôn được cố định vị trí. Đặt gương vào vị trí phù hợp, bạn có thể thoải mái bổ sung các vật dụng khác để hoàn thiện căn phòng.', CAST(N'2021-11-15T21:09:17.747' AS DateTime), 1, 1, 1, 3, 199)
INSERT [dbo].[Products] ([id], [idCategory], [name], [price], [description], [createTime], [nvisit], [nsold], [active], [idUser], [availableQuantity]) VALUES (126, 6, N'GƯƠNG TREO TƯỜNG ATTILA', CAST(1095000.000 AS Decimal(19, 3)), N'Được thiết kế đơn giản và tự nhiên với chất liệu gỗ sồi cao cấp, gương treo tường ATTILA mang lại nét trang nhã và sang trọng cho không gian sống của bạn. Sản phẩm có thể đặt tại nhiều khu vực như sảnh và lối vào, phòng ngủ, phòng tắm… thuận tiện cho việc nhìn ngắm mình trong gương của chủ nhân và trang trí cho ngôi nhà thêm cảm hứng.', CAST(N'2021-11-15T21:09:51.433' AS DateTime), 3, 3, 1, 3, 197)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ShipInfos] ON 

INSERT [dbo].[ShipInfos] ([id], [idUser], [address]) VALUES (1, 4, N'474 Phố Bàng Tụ Hiển, Ấp Viên Oanh, Quận Ma Hoàng, Hải Phòng')
INSERT [dbo].[ShipInfos] ([id], [idUser], [address]) VALUES (2, 4, N'484 Lê Văn Việt, Tăng Nhơn Phú A, Thủ Đức ')
INSERT [dbo].[ShipInfos] ([id], [idUser], [address]) VALUES (3, 5, N'Chợ Long Biên')
INSERT [dbo].[ShipInfos] ([id], [idUser], [address]) VALUES (4, 5, N'Bệnh viện Quận 9')
INSERT [dbo].[ShipInfos] ([id], [idUser], [address]) VALUES (5, 6, N'Chùa Một Cột')
INSERT [dbo].[ShipInfos] ([id], [idUser], [address]) VALUES (6, 6, N'Phước Hảo, Châu Thành, Trà Vinh
')
SET IDENTITY_INSERT [dbo].[ShipInfos] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoles] ON 

INSERT [dbo].[UserRoles] ([id], [name]) VALUES (1, N'Admin')
INSERT [dbo].[UserRoles] ([id], [name]) VALUES (2, N'Người mua')
INSERT [dbo].[UserRoles] ([id], [name]) VALUES (3, N'Người bán')
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [idRole], [username], [password], [phone], [email], [avatar], [registerTime], [active]) VALUES (1, 1, N'Trần Văn Tuấn', N'6c6373cabc039fbfe3ce4ca05115258977c05b77b2910f9b27c51a922931ff4f', N'0985321642', N'admin01@gmail.com', N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1639449317/ca1rh1gp1uxnesbzd7zr.png', CAST(N'2021-11-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Users] ([id], [idRole], [username], [password], [phone], [email], [avatar], [registerTime], [active]) VALUES (2, 3, N'Nguyễn Minh Ðạt', N'c00dacf13511f7115cd539a40cc0d672fd4e619a7cd5cb3e300ae99ee9fff03c', N'0290058377', N'datnm@gmail.com', N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1639633848/ddhlv8pl8kvchmcs59uv.jpg', CAST(N'2021-11-15T18:11:36.577' AS DateTime), 1)
INSERT [dbo].[Users] ([id], [idRole], [username], [password], [phone], [email], [avatar], [registerTime], [active]) VALUES (3, 3, N'Nguyễn Mỹ Anh', N'2547a4403ce8ac3b80f751fb98a2c658e5d3f6bebff74061652fd615389f4486', N'0595261251', N'anhnm@gmail.com', NULL, CAST(N'2021-11-15T20:33:02.090' AS DateTime), 1)
INSERT [dbo].[Users] ([id], [idRole], [username], [password], [phone], [email], [avatar], [registerTime], [active]) VALUES (4, 2, N'Lê Hân', N'f37ae071093a93d18ffda7e8e3fce51c528a5c9dbe3e236acaa7efb7c0ab8913', N'0123456789', N'19110360@student.hcmute.edu.vn', N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1636991573/h7kdsggaa6jz4ta7gk9u.jpg', CAST(N'2021-11-15T22:52:14.960' AS DateTime), 1)
INSERT [dbo].[Users] ([id], [idRole], [username], [password], [phone], [email], [avatar], [registerTime], [active]) VALUES (5, 2, N'Pham Duy', N'5ed9a61940fc8017d8b071bd5cb8dc40cf936bf957620bd7facbd38e6373bfae', N'0832780143', N'19110338@student.hcmute.edu.vn', N'https://res.cloudinary.com/dviyn9zyq/image/upload/v1638865900/wx1efmjhaymy8an0p8hn.jpg', CAST(N'2021-12-07T15:31:42.073' AS DateTime), 1)
INSERT [dbo].[Users] ([id], [idRole], [username], [password], [phone], [email], [avatar], [registerTime], [active]) VALUES (6, 2, N'My Huyen', N'c6ce2803914c9808e71b838e2279df0b9fa24a19618d48c196e64b06bf6cfbf2', N'0954326219', N'19110371@student.hcmute.edu.vn', NULL, CAST(N'2021-12-07T15:33:35.533' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Products] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_Carts_Products]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_Carts_Users]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Products] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Products]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Users]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([idOrder])
REFERENCES [dbo].[Orders] ([id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_PaymentMethods] FOREIGN KEY([idPaymentMethod])
REFERENCES [dbo].[PaymentMethods] ([id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_PaymentMethods]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_ShipInfos] FOREIGN KEY([idShip])
REFERENCES [dbo].[ShipInfos] ([id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_ShipInfos]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users1] FOREIGN KEY([idSeller])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users1]
GO
ALTER TABLE [dbo].[ProductImages]  WITH CHECK ADD  CONSTRAINT [FK_ProductImages_Products] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[ProductImages] CHECK CONSTRAINT [FK_ProductImages_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([idCategory])
REFERENCES [dbo].[Categories] ([id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Users]
GO
ALTER TABLE [dbo].[ShipInfos]  WITH CHECK ADD  CONSTRAINT [FK_ShipInfos_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[ShipInfos] CHECK CONSTRAINT [FK_ShipInfos_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserRoles] FOREIGN KEY([idRole])
REFERENCES [dbo].[UserRoles] ([id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserRoles]
GO
USE [master]
GO
ALTER DATABASE [LTWEB_TMDT_NOITHAT] SET  READ_WRITE 
GO
