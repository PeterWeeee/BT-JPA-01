-- =======================================================
-- SCRIPT TẠO CSDL VÀ DỮ LIỆU MẪU CHO PROJECT BT-JPA-01
-- Database: webst4
-- Công nghệ: Jakarta EE 10, JPA / Hibernate 7.x, MS SQL Server
-- =======================================================

USE master;
GO

-- 1. Tạo Database webst4 nếu chưa tồn tại
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'webst4')
BEGIN
    CREATE DATABASE webst4;
    PRINT N'Đã tạo Database webst4 thành công.';
END
ELSE
BEGIN
    PRINT N'Database webst4 đã tồn tại.';
END
GO

USE webst4;
GO

-- =======================================================
-- 2. TẠO CÁC BẢNG DỮ LIỆU (THEO CẤU TRÚC ENTITY JPA)
-- =======================================================

-- 2.1. Bảng categories (Danh mục)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'categories')
BEGIN
    CREATE TABLE [dbo].[categories] (
        [CategoryId] INT IDENTITY(1,1) NOT NULL,
        [CategoryName] NVARCHAR(50) NULL,
        [Images] NVARCHAR(500) NULL,
        [Status] INT NULL DEFAULT 1,
        CONSTRAINT [PK_categories] PRIMARY KEY CLUSTERED ([CategoryId] ASC)
    );
    PRINT N'Đã tạo bảng categories thành công.';
END
GO

-- 2.2. Bảng users (Người dùng, hỗ trợ xác thực và OTP)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'users')
BEGIN
    CREATE TABLE [dbo].[users] (
        [id] INT IDENTITY(1,1) NOT NULL,
        [email] NVARCHAR(255) NULL,
        [username] NVARCHAR(50) NOT NULL,
        [fullname] NVARCHAR(100) NULL,
        [password] NVARCHAR(255) NOT NULL,
        [avatar] NVARCHAR(500) NULL,
        [roleid] INT NULL DEFAULT 3, -- 1: Admin, 2: Manager, 3: User
        [phone] NVARCHAR(20) NULL,
        [createddate] DATE NULL DEFAULT GETDATE(),
        [status] INT NULL DEFAULT 0, -- 0: Chưa kích hoạt, 1: Đã kích hoạt
        [otp_code] NVARCHAR(10) NULL,
        [otp_expiry] DATETIME2(7) NULL,
        CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED ([id] ASC),
        CONSTRAINT [UK_users_username] UNIQUE ([username])
    );
    PRINT N'Đã tạo bảng users thành công.';
END
GO

-- 2.3. Bảng Videos (Video liên kết Danh mục)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Videos')
BEGIN
    CREATE TABLE [dbo].[Videos] (
        [VideoId] VARCHAR(255) NOT NULL,
        [Active] INT NULL DEFAULT 1,
        [Description] NVARCHAR(500) NULL,
        [Poster] NVARCHAR(500) NULL,
        [Title] NVARCHAR(500) NULL,
        [Views] INT NULL DEFAULT 0,
        [CategoryId] INT NULL,
        CONSTRAINT [PK_Videos] PRIMARY KEY CLUSTERED ([VideoId] ASC),
        CONSTRAINT [FK_Videos_categories] FOREIGN KEY ([CategoryId]) 
            REFERENCES [dbo].[categories] ([CategoryId]) ON DELETE CASCADE
    );
    PRINT N'Đã tạo bảng Videos thành công.';
END
GO

-- 2.4. Bảng products (Sản phẩm liên kết Danh mục)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'products')
BEGIN
    CREATE TABLE [dbo].[products] (
        [ProductId] INT IDENTITY(1,1) NOT NULL,
        [ProductName] NVARCHAR(255) NOT NULL,
        [Description] NVARCHAR(MAX) NULL,
        [Price] FLOAT NULL DEFAULT 0.0,
        [Images] NVARCHAR(500) NULL,
        [Quantity] INT NULL DEFAULT 0,
        [Status] INT NULL DEFAULT 1,
        [CreatedDate] DATETIME2(7) NULL DEFAULT GETDATE(),
        [CategoryId] INT NOT NULL,
        CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED ([ProductId] ASC),
        CONSTRAINT [FK_products_categories] FOREIGN KEY ([CategoryId]) 
            REFERENCES [dbo].[categories] ([CategoryId]) ON DELETE CASCADE
    );
    PRINT N'Đã tạo bảng products thành công.';
END
GO

-- =======================================================
-- 3. NẠP DỮ LIỆU MẪU (SAMPLE DATA)
-- =======================================================

-- 3.1. Dữ liệu bảng categories
IF NOT EXISTS (SELECT 1 FROM [dbo].[categories])
BEGIN
    SET IDENTITY_INSERT [dbo].[categories] ON;
    INSERT INTO [dbo].[categories] ([CategoryId], [CategoryName], [Images], [Status]) VALUES
    (1, N'Điện thoại & Phụ kiện', 'abc.jpg', 1),
    (2, N'Máy tính & Laptop', 'avatar.png', 1),
    (3, N'Thiết bị điện tử', 'electronic.jpg', 1),
    (4, N'Thời trang & Phụ kiện', 'fashion.jpg', 1);
    SET IDENTITY_INSERT [dbo].[categories] OFF;
    PRINT N'Đã nạp dữ liệu mẫu cho bảng categories.';
END
GO

-- 3.2. Dữ liệu bảng users (Tài khoản mặc định: mật khẩu là "123")
IF NOT EXISTS (SELECT 1 FROM [dbo].[users])
BEGIN
    SET IDENTITY_INSERT [dbo].[users] ON;
    INSERT INTO [dbo].[users] ([id], [username], [password], [fullname], [email], [phone], [roleid], [status], [avatar], [createddate]) VALUES
    (1, N'admin', N'123', N'Quản Trị Viên', N'admin@iotstar.vn', N'0901234566', 1, 1, N'1_5b2dbc81-75c9-4078-9ea8-e3d8ec21e0c5.png', '2026-09-06'),
    (2, N'user', N'123', N'Nguyễn Văn A', N'user@iotstar.vn', N'0987654321', 3, 1, N'2_f7612ed1-27ca-46c9-a7ee-095b60900922.png', '2026-09-05'),
    (3, N'manager', N'123', N'Quản Lý Cửa Hàng', N'manager@iotstar.vn', N'0902345678', 2, 1, NULL, GETDATE());
    SET IDENTITY_INSERT [dbo].[users] OFF;
    PRINT N'Đã nạp dữ liệu mẫu cho bảng users (admin, manager, user).';
END
GO

-- 3.3. Dữ liệu bảng Videos
IF NOT EXISTS (SELECT 1 FROM [dbo].[Videos])
BEGIN
    INSERT INTO [dbo].[Videos] ([VideoId], [Active], [Description], [Poster], [Title], [Views], [CategoryId]) VALUES
    ('v01', 1, N'Video giới thiệu và kiểm thử JPA Hibernate', 'poster.jpg', N'Video demo JPA', 100, 1);
    PRINT N'Đã nạp dữ liệu mẫu cho bảng Videos.';
END
GO

-- 3.4. Dữ liệu bảng products
IF NOT EXISTS (SELECT 1 FROM [dbo].[products])
BEGIN
    SET IDENTITY_INSERT [dbo].[products] ON;
    INSERT INTO [dbo].[products] ([ProductId], [ProductName], [Description], [Price], [Images], [Quantity], [Status], [CreatedDate], [CategoryId]) VALUES
    (1, N'iPhone 15 Pro Max 256GB', N'Titan tự nhiên, chip Apple A17 Pro mạnh mẽ vượt trội', 29990000, '1788611737209.jpg', 15, 1, '2026-09-05 19:35:37', 1),
    (2, N'Samsung Galaxy S24 Ultra', N'Khung titan, camera 200MP kèm bút S-Pen thông minh', 27490000, '1788612696517.jpg', 20, 1, '2026-09-05 19:51:20', 1),
    (3, N'MacBook Pro 14 inch M3 Pro', N'RAM 18GB, SSD 512GB màn hình Liquid Retina XDR', 49990000, '1788617019686.jpg', 8, 1, '2026-09-05 21:03:39', 2),
    (4, N'Dell XPS 13 Plus 9320', N'Thiết kế tương lai, chip Intel Core i7 thế hệ mới', 38500000, '1788617034063.jpg', 12, 1, '2026-09-05 21:03:54', 2),
    (5, N'Tai nghe AirPods Pro 2 USB-C', N'Chống ồn chủ động đỉnh cao, âm thanh vòm sống động', 5690000, '1788617048624.jpg', 30, 1, '2026-09-05 21:04:08', 1),
    (6, N'Apple Watch Ultra 2 GPS + Cellular', N'Vỏ titan 49mm, thời lượng pin ấn tượng cho thể thao', 19990000, '1788617059062.jpg', 10, 1, '2026-09-05 21:04:19', 1),
    (7, N'Bàn phím cơ không dây Logitech MX Mechanical', N'Tactile Quiet switches, kết nối đa thiết bị', 3290000, '1788617070855.jpg', 25, 1, '2026-09-05 21:04:30', 2),
    (8, N'Chuột công thái học Logitech MX Master 3S', N'Cuộn siêu tốc MagSpeed, cảm biến 8000 DPI êm ái', 2190000, '1788617090252.jpg', 40, 1, '2026-09-05 21:04:50', 2),
    (9, N'Màn hình Dell UltraSharp 27 inch 4K (U2723QE)', N'Tấm nền IPS Black, độ tương phản 2000:1 chuẩn màu đồ họa', 12800000, '1788696390893.png', 14, 1, '2026-09-06 19:06:30', 2);
    SET IDENTITY_INSERT [dbo].[products] OFF;
    PRINT N'Đã nạp 9 sản phẩm mẫu vào bảng products.';
END
GO

-- =======================================================
-- 4. KIỂM TRA DỮ LIỆU ĐÃ TẠO
-- =======================================================
SELECT N'categories' AS [Table], COUNT(*) AS [TotalRows] FROM [dbo].[categories]
UNION ALL
SELECT N'users' AS [Table], COUNT(*) AS [TotalRows] FROM [dbo].[users]
UNION ALL
SELECT N'Videos' AS [Table], COUNT(*) AS [TotalRows] FROM [dbo].[Videos]
UNION ALL
SELECT N'products' AS [Table], COUNT(*) AS [TotalRows] FROM [dbo].[products];
GO
