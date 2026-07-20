-- =========================================================================
-- TẠO STORED PROCEDURES (Thủ tục lưu trữ)
-- =========================================================================
GO
-- Tạo Stored Procedure: Tìm kiếm thông tin khách hàng dựa trên từ khóa (khớp với họ tên hoặc số điện thoại).
CREATE PROCEDURE sp_TimKhachHang @TuKhoa NVARCHAR(100)
AS
BEGIN
    SELECT * FROM KHACH_HANG
    WHERE HOTEN LIKE '%' + @TuKhoa + '%'
    OR SDT LIKE '%' + @TuKhoa + '%'
END;
GO

-- Tạo Stored Procedure: Thống kê tổng số lượng vé đã bán ra cho từng bộ phim.
CREATE PROCEDURE sp_ThongKeVeTheoPhim
AS
BEGIN
    SELECT P.TENPHIM, COUNT(V.MAVE) AS SOVE
    FROM PHIM P
    JOIN SUAT_CHIEU SC ON P.MAPHIM = SC.MAPHIM
    JOIN VE V ON SC.MASUATCHIEU = V.MASUATCHIEU
    GROUP BY P.TENPHIM
END;
GO

-- Tạo Stored Procedure: Thống kê tổng số lượng vé đã bán ra chia theo từng suất chiếu cụ thể.
CREATE PROCEDURE sp_ThongKeVeTheoSuatChieu
AS
BEGIN
    SELECT SC.MASUATCHIEU, P.TENPHIM, SC.NGAYGIOCHIEU, COUNT(V.MAVE) AS SOVE
    FROM SUAT_CHIEU SC
    JOIN PHIM P ON SC.MAPHIM = P.MAPHIM
    JOIN VE V ON SC.MASUATCHIEU = V.MASUATCHIEU
    GROUP BY SC.MASUATCHIEU, P.TENPHIM, SC.NGAYGIOCHIEU
END;
GO

-- Tạo Stored Procedure: Thống kê tổng số lượng vé đã bán ra tại từng phòng chiếu.
CREATE PROCEDURE sp_ThongKeVeTheoPhong
AS
BEGIN
    SELECT PC.TENPHONG, COUNT(V.MAVE) AS SOVE
    FROM PHONG_CHIEU PC
    JOIN SUAT_CHIEU SC ON PC.MAPHONG = SC.MAPHONG
    JOIN VE V ON SC.MASUATCHIEU = V.MASUATCHIEU
    GROUP BY PC.TENPHONG
END;
GO

-- Tạo Stored Procedure: Thêm mới hóa đơn và vé đồng thời, sử dụng TRANSACTION để đảm bảo toàn vẹn dữ liệu (nếu lỗi sẽ hoàn tác toàn bộ).
CREATE PROCEDURE sp_ThemHoaDonVe
    @MaHoaDon VARCHAR(20),
    @MaKH VARCHAR(15),
    @NgayMua DATETIME,
    @MaVe VARCHAR(20),
    @MaSuatChieu VARCHAR(15),
    @MaGhe VARCHAR(10),
    @GiaVe DECIMAL(15,2)
AS
BEGIN
    BEGIN TRANSACTION

    INSERT INTO HOA_DON VALUES (@MaHoaDon, @MaKH, @NgayMua, @GiaVe)
    INSERT INTO VE (MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA)
    VALUES (@MaVe, @MaHoaDon, @MaSuatChieu, @MaGhe, @GiaVe)

    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION
        PRINT N'Thêm thất bại, đã hủy giao dịch'
    END
    ELSE
    BEGIN
        COMMIT TRANSACTION
        PRINT N'Thêm thành công'
    END
END;
GO
-- ---------------------------------------------------------
-- TEST STORED PROCEDURES
-- ---------------------------------------------------------

-- Lệnh chạy test cho: CREATE PROCEDURE sp_TimKhachHang
-- Tác dụng: Tìm khách hàng có tên chứa từ khóa 'Văn A'
EXEC sp_TimKhachHang N'Văn A';

-- Lệnh chạy test cho: CREATE PROCEDURE sp_TimKhachHang
-- Tác dụng: Tìm khách hàng có số điện thoại chứa '0901111115'
EXEC sp_TimKhachHang '0901111115';

-- Lệnh chạy test cho: CREATE PROCEDURE sp_ThongKeVeTheoPhim
-- Tác dụng: Thống kê số lượng vé đã bán ra của từng bộ phim
EXEC sp_ThongKeVeTheoPhim;

-- Lệnh chạy test cho: CREATE PROCEDURE sp_ThongKeVeTheoSuatChieu
-- Tác dụng: Thống kê số lượng vé đã bán ra của từng suất chiếu
EXEC sp_ThongKeVeTheoSuatChieu;

-- Lệnh chạy test cho: CREATE PROCEDURE sp_ThongKeVeTheoPhong
-- Tác dụng: Thống kê số lượng vé đã bán ra tại từng phòng chiếu
EXEC sp_ThongKeVeTheoPhong;
