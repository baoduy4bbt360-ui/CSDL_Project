-- =========================================================================
-- TẠO FUNCTIONS (Hàm)
-- =========================================================================
GO
-- Tạo Function: Tính toán và trả về số lượng ghế trống còn lại của một suất chiếu cụ thể.
CREATE FUNCTION fn_SoGheTrong (@MaSuatChieu VARCHAR(15))
RETURNS INT
AS
BEGIN
    DECLARE @SoGheToiDa INT;
    DECLARE @SoGheDaBan INT;
    
    SELECT @SoGheToiDa = SOGHETOIDA 
    FROM SUAT_CHIEU 
    WHERE MASUATCHIEU = @MaSuatChieu;
    
    SELECT @SoGheDaBan = COUNT(*) 
    FROM VE 
    WHERE MASUATCHIEU = @MaSuatChieu;
    
    RETURN ISNULL(@SoGheToiDa, 0) - ISNULL(@SoGheDaBan, 0);
END;
GO

-- Tạo Function: Tính tổng doanh thu từ hóa đơn theo một ngày cụ thể hoặc theo tháng/năm được truyền vào.
CREATE FUNCTION fn_TongDoanhThuTheoNgayThang (
    @Ngay DATE = NULL,
    @Thang INT = NULL,
    @Nam INT = NULL
)
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TongDoanhThu DECIMAL(15,2) = 0;
    
    IF @Ngay IS NOT NULL
    BEGIN
        SELECT @TongDoanhThu = SUM(TONGTIEN)
        FROM HOA_DON
        WHERE CAST(NGAYMUA AS DATE) = @Ngay;
    END
    ELSE IF @Thang IS NOT NULL AND @Nam IS NOT NULL
    BEGIN
        SELECT @TongDoanhThu = SUM(TONGTIEN)
        FROM HOA_DON
        WHERE MONTH(NGAYMUA) = @Thang AND YEAR(NGAYMUA) = @Nam;
    END
    
    RETURN ISNULL(@TongDoanhThu, 0);
END;
GO

-- Tạo Function: Tìm và trả về danh sách bộ phim đạt tổng doanh thu bán vé cao nhất (xếp hạng 1).
CREATE FUNCTION fn_PhimDoanhThuCaoNhat()
RETURNS TABLE
AS
RETURN (
    WITH DoanhThuPhim AS (
        SELECT P.MAPHIM, P.TENPHIM, P.THELOAI, P.THOILUONG,
               SUM(V.GIAVEMUA) AS TONG_DOANHTHU,
               DENSE_RANK() OVER (ORDER BY SUM(V.GIAVEMUA) DESC) AS HangDoanhThu
        FROM PHIM P
        JOIN SUAT_CHIEU SC ON P.MAPHIM = SC.MAPHIM
        JOIN VE V ON SC.MASUATCHIEU = V.MASUATCHIEU
        GROUP BY P.MAPHIM, P.TENPHIM, P.THELOAI, P.THOILUONG
    )
    SELECT MAPHIM, TENPHIM, THELOAI, THOILUONG, TONG_DOANHTHU
    FROM DoanhThuPhim
    WHERE HangDoanhThu = 1
);
GO
-- ---------------------------------------------------------
-- TEST FUNCTIONS
-- ---------------------------------------------------------

-- Lệnh chạy test cho: CREATE FUNCTION fn_SoGheTrong
-- Tác dụng: Lấy ra số lượng ghế còn trống của suất chiếu có mã 'SC001'
SELECT dbo.fn_SoGheTrong('SC001') AS [Số Ghế Trống SC001];

-- Lệnh chạy test cho: CREATE FUNCTION fn_TongDoanhThuTheoNgayThang
-- Tác dụng: Tính tổng doanh thu hóa đơn bán vé thu được trong ngày 19/07/2026
SELECT dbo.fn_TongDoanhThuTheoNgayThang('2026-07-19', NULL, NULL) AS [Doanh Thu Ngày 19/07/2026];

-- Lệnh chạy test cho: CREATE FUNCTION fn_TongDoanhThuTheoNgayThang
-- Tác dụng: Tính tổng doanh thu hóa đơn bán vé thu được trong cả Tháng 7 năm 2026
SELECT dbo.fn_TongDoanhThuTheoNgayThang(NULL, 7, 2026) AS [Doanh Thu Tháng 07/2026];

-- Lệnh chạy test cho: CREATE FUNCTION fn_PhimDoanhThuCaoNhat
-- Tác dụng: Lấy thông tin của (các) bộ phim có tổng doanh thu từ việc bán vé cao nhất
SELECT * FROM dbo.fn_PhimDoanhThuCaoNhat();