

-- =============================================
-- BƯỚC 1: Bổ sung cột HinhAnh (Nếu chưa có)
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[SanPham]') AND name = 'HinhAnh')
BEGIN
    ALTER TABLE [dbo].[SanPham] ADD [HinhAnh] NVARCHAR(MAX) NULL;
END
GO

-- =============================================
-- BƯỚC 2: Xóa dữ liệu cũ (để tránh trùng lặp khi chạy lại)
-- =============================================
-- Lưu ý: Phải xóa bảng con (SanPham) trước bảng cha (DanhMucSp)
DELETE FROM [dbo].[SanPham];
DELETE FROM [dbo].[DanhMucSp];

-- Reset lại ID tự tăng về 0 (để bắt đầu từ 1)
DBCC CHECKIDENT ('[dbo].[DanhMucSp]', RESEED, 0);
DBCC CHECKIDENT ('[dbo].[SanPham]', RESEED, 0);
GO

-- =============================================
-- BƯỚC 3: Thêm dữ liệu vào bảng [DanhMucSp]
-- =============================================
INSERT INTO [dbo].[DanhMucSp] ([TieuDe], [MoTa], [SoLuong], [parent_id]) VALUES 
(N'Rau củ hữu cơ', N'Các loại rau xanh, củ quả trồng theo tiêu chuẩn organic', 100, NULL), -- dm_id sẽ là 1
(N'Trái cây tươi', N'Trái cây tươi ngon trong ngày từ các nông trại', 50, NULL),          -- dm_id sẽ là 2
(N'Các loại hạt', N'Hạt dinh dưỡng, ngũ cốc', 30, NULL),                                    -- dm_id sẽ là 3
(N'Thịt & Trứng', N'Thịt tươi và trứng gà ta thả vườn', 40, NULL);                          -- dm_id sẽ là 4
GO

-- =============================================
-- BƯỚC 4: Thêm dữ liệu vào bảng [SanPham]
-- Lưu ý: Cột [Giá] có dấu như bạn định nghĩa
-- =============================================

-- 1. Sản phẩm thuộc danh mục 'Rau củ hữu cơ' (dm_id = 1)
INSERT INTO [dbo].[SanPham] ([TieuDe], [MoTa], [Giá], [SoLuong], [dm_id], [HinhAnh]) VALUES 
(N'Cà chua Roma Hữu cơ', N'Cà chua chín mọng, thích hợp làm salad hoặc nấu súp. Nguồn gốc Đà Lạt.', 45000, 100, 1, N'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?auto=format&fit=crop&w=600'),
(N'Cải xoăn Kale', N'Cải xoăn giàu vitamin, trồng thủy canh không thuốc trừ sâu.', 35000, 50, 1, N'https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?auto=format&fit=crop&w=600'),
(N'Cà rốt Baby', N'Cà rốt loại nhỏ, ngọt và giòn, thích hợp cho bé ăn dặm.', 25000, 80, 1, N'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?auto=format&fit=crop&w=600'),
(N'Súp lơ xanh', N'Súp lơ xanh tươi ngon, bông to chắc.', 30000, 40, 1, N'https://images.unsplash.com/photo-1583663848850-46af132dc08e?auto=format&fit=crop&w=600');

-- 2. Sản phẩm thuộc danh mục 'Trái cây tươi' (dm_id = 2)
INSERT INTO [dbo].[SanPham] ([TieuDe], [MoTa], [Giá], [SoLuong], [dm_id], [HinhAnh]) VALUES 
(N'Dâu tây Mộc Châu', N'Dâu tây giống Nhật, vị ngọt đậm đà, thu hoạch sáng sớm.', 120000, 20, 2, N'https://images.unsplash.com/photo-1543528176-61b23949492e?auto=format&fit=crop&w=600'),
(N'Cam vàng Navel', N'Cam vàng không hạt, mọng nước, nhiều Vitamin C.', 60000, 100, 2, N'https://images.unsplash.com/photo-1611080626919-7cf5a9dbab5b?auto=format&fit=crop&w=600'),
(N'Bơ sáp 034', N'Bơ sáp dẻo, béo ngậy, hạt nhỏ.', 75000, 30, 2, N'https://images.unsplash.com/photo-1523049673856-42848c51a147?auto=format&fit=crop&w=600'),
(N'Táo Envy Mỹ', N'Táo nhập khẩu, giòn ngọt, size lớn.', 150000, 50, 2, N'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&w=600');

-- 3. Sản phẩm thuộc danh mục 'Các loại hạt' (dm_id = 3)
INSERT INTO [dbo].[SanPham] ([TieuDe], [MoTa], [Giá], [SoLuong], [dm_id], [HinhAnh]) VALUES 
(N'Hạt Óc chó nếp', N'Hạt óc chó rừng Tây Bắc, béo bùi tốt cho trí não.', 200000, 15, 3, N'https://images.unsplash.com/photo-1599709736869-756195decc2c?auto=format&fit=crop&w=600');

GO

-- Kiểm tra kết quả
SELECT * FROM DanhMucSp;
SELECT * FROM SanPham;