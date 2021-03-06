USE [master]
GO
/****** Object:  Database [WebSony]    Script Date: 15/08/2020 6:30:18 CH ******/
CREATE DATABASE [WebSony]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SONY', FILENAME = N'F:\DOANWEB\WebDoAn\CSDL\SONY.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SONY_log', FILENAME = N'F:\DOANWEB\WebDoAn\CSDL\SONY_log.ldf' , SIZE = 3456KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [WebSony] SET COMPATIBILITY_LEVEL = 90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebSony].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [WebSony] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebSony] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebSony] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebSony] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebSony] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebSony] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [WebSony] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [WebSony] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebSony] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebSony] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebSony] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebSony] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebSony] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebSony] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebSony] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebSony] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WebSony] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebSony] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebSony] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebSony] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebSony] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebSony] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebSony] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebSony] SET RECOVERY FULL 
GO
ALTER DATABASE [WebSony] SET  MULTI_USER 
GO
ALTER DATABASE [WebSony] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebSony] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebSony] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebSony] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [WebSony]
GO
/****** Object:  StoredProcedure [dbo].[ChiTietDonHang_Insert]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[ChiTietDonHang_Insert]
@IDDonHang int,
@IDSanPham int,
@SoLuongSanPham int
AS
INSERT INTO ChiTietDonHang (
IDDonHang,
IDSanPham,
SoLuongSanPham)
VALUES (
@IDDonHang,
@IDSanPham,
@SoLuongSanPham)
GO
/****** Object:  StoredProcedure [dbo].[ChiTietDonHang_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[ChiTietDonHang_Select]
@IDDonHang int
AS
SELECT
SoLuongSanPham,
TenSanPham,
GiaSanPham
FROM
ChiTietDonHang INNER JOIN
SanPham
ON
SanPham.IDSanPham = ChiTietDonHang.IDSanPham
WHERE
IDDonHang = @IDDonHang
GO
/****** Object:  StoredProcedure [dbo].[DangNhapAdmin_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[DangNhapAdmin_Select]
@TenDangNhap nvarchar(50),
@MatKhau nvarchar(50)
AS
SELECT
IDNguoiDung,
IDKieuNguoiDung,
HoTen,
TenDangNhap,
DiaChi,
MatKhau,
SoDienThoai,
SoFax,
Email,
MaDienThoai
FROM
NguoiDung
WHERE
TenDangNhap = @TenDangNhap AND
MatKhau = @MatKhau AND
IDKieuNguoiDung = 2
GO
/****** Object:  StoredProcedure [dbo].[DangNhapNguoiDung_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DangNhapNguoiDung_Select]
@TenDangNhap nvarchar(50),
@MatKhau nvarchar(50)
AS
SELECT HoTen,Idnguoidung
FROM NguoiDung
WHERE
TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau AND IDKieuNguoiDung = 1
GO
/****** Object:  StoredProcedure [dbo].[DanhMucSanPham_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DanhMucSanPham_Select]
AS
SELECT IDDanhMucSanPham, TenDanhMucSanPham
FROM DanhMucSanPham
GO
/****** Object:  StoredProcedure [dbo].[DanhMucSanPhamMaster_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[DanhMucSanPhamMaster_Select] 
	
AS
	select DanhMucSanPham.IdDanhMucSanPham,count(SanPham.IdDanhMucSanPham)  as SoSanPham,TenDanhMucSanPham 
	from SanPham join DanhMucSanPham on SanPham.IdDanhMucSanPham=DanhMucSanPham.IdDanhMucSanPham
	where SanPham.IdDanhMucSanPham=DanhMucSanPham.IdDanhMucSanPham
	group by DanhMucSanPham.IdDanhMucSanPham,TenDanhMucSanPham

GO
/****** Object:  StoredProcedure [dbo].[DonHang_Insert]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[DonHang_Insert]
@IDNguoiDung int,
@IDGiaoDich nvarchar(50)
AS
INSERT INTO DonHang (
IDNguoiDung,
IDGiaoDich)
VALUES (
@IDNguoiDung,
@IDGiaoDich)
GO
/****** Object:  StoredProcedure [dbo].[DonHang_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[DonHang_Select]
@IDNguoiDung int
AS
SELECT
IDDonHang,
IDGiaoDich,
NgayTaoDonHang,
TenTinhTrangDonHang,
NgayXuLyDonHang,
TrackingNumber
FROM
DonHang INNER JOIN
TinhTrangDonHang
ON
TinhTrangDonHang.IDTinhTrangDonHang = DonHang.IDTinhTrangDonHang
WHERE
IDNguoiDung = @IDNguoiDung
ORDER BY
NgayTaoDonHang DESC
GO
/****** Object:  StoredProcedure [dbo].[DonHang_Top1_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[DonHang_Top1_Select]
AS
SELECT Top(1) IDDonHang from DonHang ORDER BY IDDonHang DESC
GO
/****** Object:  StoredProcedure [dbo].[DonHang_Update]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[DonHang_Update]
@IDDonHang int,
@IDTinhTrangDonHang int,
@NgayXuLyDonHang datetime,
@TrackingNumber nvarchar(50)
AS
UPDATE
DonHang
SET
IDTinhTrangDonHang = @IDTinhTrangDonHang,
NgayXuLyDonHang = @NgayXuLyDonHang,
TrackingNumber = @TrackingNumber
WHERE
IDDonHang = @IDDonHang




GO
/****** Object:  StoredProcedure [dbo].[DonHangAll_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[DonHangAll_Select]
AS
SELECT
IDDonHang,
IDGiaoDich,
NgayTaoDonHang,
TenTinhTrangDonHang,
HoTen,
TenDangNhap,
Diachi,
MaDienThoai,
SoDienThoai,
Email
FROM
DonHang INNER JOIN
TinhTrangDonHang
ON
TinhTrangDonHang.IDTinhTrangDonHang = DonHang.IDTinhTrangDonHang
INNER JOIN
NguoiDung
ON
NguoiDung.IDNguoiDung = DonHang.IDNguoiDung
ORDER BY
NgayTaoDonHang DESC
GO
/****** Object:  StoredProcedure [dbo].[DonHangByID_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[DonHangByID_Select]
@IDDonHang int
AS
SELECT
NgayTaoDonHang,
NgayXuLyDonHang,
IDTinhTrangDonHang,
TrackingNumber
FROM
DonHang
WHERE
IDDonHang = @IDDonHang

GO
/****** Object:  StoredProcedure [dbo].[GioHang_Delete]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GioHang_Delete]
@IDGioHang int
AS
DELETE FROM
GioHang
WHERE
IDGioHang = @IDGioHang
GO
/****** Object:  StoredProcedure [dbo].[GioHang_Insert]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GioHang_Insert]
@CartGUID nvarchar(50),
@IDSanPham int,
@SoLuong int
AS
DECLARE @ItemCount int
SELECT @ItemCount = Count(IDSanPham) FROM GioHang
WHERE IDSanPham = @IDSanPham AND CartGUID = @CartGUID
IF @ItemCount > 0 /*cap nhat so luong*/
UPDATE GioHang SET SoLuong = (@SoLuong + GioHang.SoLuong)
WHERE IDSanPham = @IDSanPham AND CartGUID = @CartGUID
ELSE /*chen khi chua co san pham */
INSERT INTO GioHang ( CartGUID,IDSanPham,SoLuong)
VALUES (@CartGUID,@IDSanPham,@SoLuong)
GO
/****** Object:  StoredProcedure [dbo].[GioHang_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GioHang_Select]
@CartGUID nvarchar(50)
AS
SELECT
IDGioHang,
SanPham.IDSanPham,
SanPham.TenSanPham,
SoLuong,
SanPham.GiaSanPham as GiaSanPham,
(SanPham.GiaSanPham * SoLuong) AS ThanhTien
FROM
GioHang INNER JOIN
SanPham
ON
SanPham.IDSanPham = GioHang.IDSanPham
WHERE
CartGUID = @CartGUID
GO
/****** Object:  StoredProcedure [dbo].[GioHang_Update]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GioHang_Update]
@SoLuong int,
@IDGioHang int
AS
UPDATE
GioHang
SET
SoLuong = @SoLuong
WHERE
IDGioHang = @IDGioHang
GO
/****** Object:  StoredProcedure [dbo].[HinhSanPham_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[HinhSanPham_Select]
@IDHinhSanPham int
AS
SELECT DuLieuHinhSanPham
FROM HinhSanPham
WHERE IDHinhSanPham = @IDHinhSanPham

GO
/****** Object:  StoredProcedure [dbo].[NguoiDung_Insert]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NguoiDung_Insert]
@HoTen nvarchar(50),
@TenDangNhap nvarchar(50),
@DiaChi nvarchar(50),
@MaDienThoai nvarchar(50),
@SoDienThoai nvarchar(50),
@SoFax nvarchar(50),
@Email nvarchar(50),
@IDKieuNguoiDung int,
@MatKhau nvarchar(50)
AS
INSERT INTO NguoiDung (
HoTen,TenDangNhap,DiaChi,MaDienThoai,SoDienThoai,SoFax,Email,IDKieuNguoiDung,MatKhau)
VALUES (@HoTen,@TenDangNhap,@DiaChi,@MaDienThoai,@SoDienThoai,@SoFax,@Email,@IDKieuNguoiDung,@MatKhau)

GO
/****** Object:  StoredProcedure [dbo].[NguoiTruyCap_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NguoiTruyCap_Select]
AS
SELECT * FROM ThongKeTruyCap
GO
/****** Object:  StoredProcedure [dbo].[NguoiTruyCap_Update]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NguoiTruyCap_Update]
AS
UPDATE ThongKeTruyCap SET TongSoTruyCap=TongSoTruyCap+1
GO
/****** Object:  StoredProcedure [dbo].[SanPham_Insert]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SanPham_Insert]
@IDDanhMucSanPham int,
@TenSanPham nvarchar(50),
@DuLieuHinhSanPham image,
@MoTaSanPham nvarchar(max),
@GiaSanPham int
AS
DECLARE @IDHinhSanPham int
INSERT INTO HinhSanPham (DuLieuHinhSanPham) VALUES (@DuLieuHinhSanPham)
SET @IDHinhSanPham = @@IDENTITY
INSERT INTO SanPham (IDDanhMucSanPham,TenSanPham,IDHinhSanPham,MoTaSanPham,GiaSanPham)
VALUES (@IDDanhMucSanPham,@TenSanPham,@IDHinhSanPham,@MoTaSanPham,@GiaSanPham)


GO
/****** Object:  StoredProcedure [dbo].[SanPham_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SanPham_Select]
AS
SELECT
IDSanPham,TenSanPham,TenDanhMucSanPham,IDHinhSanPham,
SUBSTRING(MoTaSanPham, 1, 150) + '...' AS MoTaSanPham,GiaSanPham
FROM
SanPham INNER JOIN DanhMucSanPham
ON
DanhMucSanPham.IDDanhMucSanPham = SanPham.IDDanhMucSanPham
GO
/****** Object:  StoredProcedure [dbo].[SanPham_SelectSearch]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SanPham_SelectSearch]
@tieuchuantim nvarchar(255)
AS
SELECT
IDSanPham,
TenSanPham,
TenDanhMucSanPham,
IDHinhSanPham,
SUBSTRING(MoTaSanPham, 1, 150) + '...' AS MoTaSanPham,
GiaSanPham
FROM
SanPham INNER JOIN
DanhMucSanPham
ON
DanhMucSanPham.IDDanhMucSanPham = SanPham.IDDanhMucSanPham
WHERE
TenDanhMucSanPham LIKE '%' + @tieuchuantim + '%' OR
TenSanPham LIKE '%' + @tieuchuantim + '%' OR
MoTaSanPham LIKE '%' + @tieuchuantim + '%'

GO
/****** Object:  StoredProcedure [dbo].[SanPham_Update]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SanPham_Update]
@IDDanhMucSanPham int,
@TenSanPham nvarchar(50),
@IDHinhSanPham int,
@DuLieuHinhSanPham image,
@MoTaSanPham ntext,
@GiaSanPham int,
@IDSanPham int
AS
UPDATE
HinhSanPham
SET
DuLieuHinhSanPham = @DuLieuHinhSanPham
WHERE
IDHinhSanPham = @IDHinhSanPham
UPDATE
SanPham
SET
IDDanhMucSanPham = @IDDanhMucSanPham,
TenSanPham = @TenSanPham,
IDHinhSanPham = @IDHinhSanPham,
MoTaSanPham = @MoTaSanPham,
GiaSanPham = @GiaSanPham
WHERE
IDSanPham = @IDSanPham
GO
/****** Object:  StoredProcedure [dbo].[SanPham10_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SanPham10_Select]
AS
SELECT Top(10)
IDSanPham,
TenSanPham,
TenDanhMucSanPham,
IDHinhSanPham,
SUBSTRING(MoTaSanPham, 1, 150) + '...' AS MoTaSanPham,
GiaSanPham
FROM
SanPham INNER JOIN
DanhMucSanPham
ON
DanhMucSanPham.IDDanhMucSanPham = SanPham.IDDanhMucSanPham
ORDER BY IDSanPham DESC

GO
/****** Object:  StoredProcedure [dbo].[SanPhamByID_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SanPhamByID_Select]
@IDSanPham int
AS
SELECT
IDSanPham,TenSanPham,TenDanhMucSanPham,IDHinhSanPham,MoTaSanPham,GiaSanPham
FROM
SanPham INNER JOIN
DanhMucSanPham
ON
DanhMucSanPham.IDDanhMucSanPham = SanPham.IDDanhMucSanPham
WHERE
IDSanPham = @IDSanPham
GO
/****** Object:  StoredProcedure [dbo].[SanPhamByIDDanhMucSanPham]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SanPhamByIDDanhMucSanPham]
@IDDanhMucSanPham int
AS
SELECT 
	IDSanPham,
	SanPham.IDDanhMucSanPham,
	TenSanPham,
	TenDanhMucSanPham,
	IDHinhSanPham,
	MoTaSanPham,
	GiaSanPham
FROM 
	DanhMucSanPham INNER JOIN 
	SanPham 
ON 
	DanhMucSanPham.IDDanhMucSanPham = SanPham.IDDanhMucSanPham
WHERE 
	SanPham.IDDanhMucSanPham = @IDDanhMucSanPham

GO
/****** Object:  StoredProcedure [dbo].[SanPhamTheoDanhMuc_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SanPhamTheoDanhMuc_Select] 
	@IdDanhMucSanPham int
AS
	select IDSanPham,
			IdHinhSanPham,
			substring(MoTaSanPham,1,15)+'...' as MoTaSanPham,
			GiaSanPham,
			TenSanPham	
		from SanPham
		where IdDanhMucSanPham = @IdDanhMucSanPham

GO
/****** Object:  StoredProcedure [dbo].[TinhTrangDonHang_Select]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[TinhTrangDonHang_Select] 
	
AS
	select *
	from TinhTrangDonHang

GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 15/08/2020 6:30:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonHang](
	[IdSanPham] [int] NOT NULL,
	[IdChiTietDonHang] [int] IDENTITY(1,1) NOT NULL,
	[IdDonHang] [int] NOT NULL,
	[SoLuongSanPham] [int] NOT NULL,
 CONSTRAINT [PK_ChiTietDonHang] PRIMARY KEY CLUSTERED 
(
	[IdChiTietDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DanhMucSanPham]    Script Date: 15/08/2020 6:30:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhMucSanPham](
	[IdDanhMucSanPham] [int] IDENTITY(1,1) NOT NULL,
	[TenDanhMucSanPham] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DanhMucSanPham] PRIMARY KEY CLUSTERED 
(
	[IdDanhMucSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 15/08/2020 6:30:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[IdDonHang] [int] IDENTITY(1,1) NOT NULL,
	[IdNguoiDung] [int] NOT NULL,
	[IdTinhTrangDonHang] [int] NOT NULL CONSTRAINT [DF_DonHang_IdTinhTrangDonHang]  DEFAULT ((1)),
	[IdGiaoDich] [nvarchar](50) NOT NULL,
	[NgayTaoDonHang] [smalldatetime] NOT NULL CONSTRAINT [DF_DonHang_NgayTaoDonHang]  DEFAULT (getdate()),
	[NgayXuLyDonHang] [smalldatetime] NULL,
	[TrackingNumber] [nvarchar](50) NULL,
 CONSTRAINT [PK_DonHang] PRIMARY KEY CLUSTERED 
(
	[IdDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GioHang]    Script Date: 15/08/2020 6:30:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GioHang](
	[IdGioHang] [int] IDENTITY(1,1) NOT NULL,
	[CartGuid] [nvarchar](50) NOT NULL,
	[IdSanPham] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[NgayTaoGioHang] [smalldatetime] NOT NULL CONSTRAINT [DF_GioHang_NgayTaoGioHang]  DEFAULT (getdate()),
 CONSTRAINT [PK_GioHang] PRIMARY KEY CLUSTERED 
(
	[IdGioHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HinhSanPham]    Script Date: 15/08/2020 6:30:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HinhSanPham](
	[IdHinhSanPham] [int] IDENTITY(1,1) NOT NULL,
	[DuLieuHinhSanPham] [image] NULL,
 CONSTRAINT [PK_HinhSanPham] PRIMARY KEY CLUSTERED 
(
	[IdHinhSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KieuNguoiDung]    Script Date: 15/08/2020 6:30:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KieuNguoiDung](
	[IdKieuNguoiDung] [int] IDENTITY(1,1) NOT NULL,
	[TenKieuNguoiDung] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_KieuNguoiDung] PRIMARY KEY CLUSTERED 
(
	[IdKieuNguoiDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 15/08/2020 6:30:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[IdNguoiDung] [int] IDENTITY(1,1) NOT NULL,
	[IdKieuNguoiDung] [int] NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[TenDangNhap] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SoDienThoai] [nvarchar](50) NULL,
	[SoFax] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[MaDienThoai] [nvarchar](50) NULL,
 CONSTRAINT [PK_NguoiDung] PRIMARY KEY CLUSTERED 
(
	[IdNguoiDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 15/08/2020 6:30:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[IdSanPham] [int] IDENTITY(1,1) NOT NULL,
	[IdDanhMucSanPham] [int] NOT NULL,
	[IdHinhSanPham] [int] NOT NULL,
	[TenSanPham] [nvarchar](50) NOT NULL,
	[MoTaSanPham] [nvarchar](max) NOT NULL,
	[GiaSanPham] [int] NOT NULL,
 CONSTRAINT [PK_SanPham] PRIMARY KEY CLUSTERED 
(
	[IdSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThongKeTruyCap]    Script Date: 15/08/2020 6:30:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongKeTruyCap](
	[TongSoTruyCap] [int] NULL CONSTRAINT [DF_ThongKeTruyCap_TongSoTruyCap]  DEFAULT ((0))
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TinhTrangDonHang]    Script Date: 15/08/2020 6:30:19 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhTrangDonHang](
	[IdTinhTrangDonHang] [int] IDENTITY(1,1) NOT NULL,
	[TenTinhTrangDonHang] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TinhTrangDonHang] PRIMARY KEY CLUSTERED 
(
	[IdTinhTrangDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDonHang_DonHang] FOREIGN KEY([IdDonHang])
REFERENCES [dbo].[DonHang] ([IdDonHang])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_ChiTietDonHang_DonHang]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDonHang_SanPham] FOREIGN KEY([IdSanPham])
REFERENCES [dbo].[SanPham] ([IdSanPham])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_ChiTietDonHang_SanPham]
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD  CONSTRAINT [FK_GioHang_SanPham] FOREIGN KEY([IdSanPham])
REFERENCES [dbo].[SanPham] ([IdSanPham])
GO
ALTER TABLE [dbo].[GioHang] CHECK CONSTRAINT [FK_GioHang_SanPham]
GO
ALTER TABLE [dbo].[NguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_NguoiDung_KieuNguoiDung] FOREIGN KEY([IdKieuNguoiDung])
REFERENCES [dbo].[KieuNguoiDung] ([IdKieuNguoiDung])
GO
ALTER TABLE [dbo].[NguoiDung] CHECK CONSTRAINT [FK_NguoiDung_KieuNguoiDung]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_DanhMucSanPham] FOREIGN KEY([IdDanhMucSanPham])
REFERENCES [dbo].[DanhMucSanPham] ([IdDanhMucSanPham])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_DanhMucSanPham]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_HinhSanPham] FOREIGN KEY([IdHinhSanPham])
REFERENCES [dbo].[HinhSanPham] ([IdHinhSanPham])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_HinhSanPham]
GO
USE [master]
GO
ALTER DATABASE [WebSony] SET  READ_WRITE 
GO
