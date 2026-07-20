-- =========================================================================
--  TẠO VIEWS (Khung nhìn)
-- =========================================================================
GO
-- Tạo View: Thống kê tổng doanh thu bán vé theo từng bộ phim và thể loại phim.
CREATE VIEW VW_DoanhThuPhim AS
SELECT P.TENPHIM, P.THELOAI, SUM(V.GIAVEMUA) AS DOANHTHU
FROM PHIM P
JOIN SUAT_CHIEU SC ON P.MAPHIM = SC.MAPHIM
JOIN VE V ON SC.MASUATCHIEU = V.MASUATCHIEU
GROUP BY P.TENPHIM, P.THELOAI;
GO

-- Tạo View: Hiển thị danh sách lịch chiếu chi tiết bao gồm thông tin suất chiếu, tên phim, thể loại và phòng chiếu.
CREATE VIEW VW_LICH_CHIEU AS
SELECT SC.MASUATCHIEU, P.TENPHIM, P.THELOAI, PC.TENPHONG, SC.NGAYGIOCHIEU, SC.GIAVE, SC.SOGHETOIDA
FROM SUAT_CHIEU AS SC
JOIN PHIM AS P ON SC.MAPHIM = P.MAPHIM
JOIN PHONG_CHIEU AS PC ON SC.MAPHONG = PC.MAPHONG;
GO

-- Tạo View: Tổng hợp lịch sử mua vé của tất cả khách hàng (bao gồm cả hóa đơn và chi tiết từng vé đã mua).
CREATE VIEW VW_KHACHHANG_MUALICHSU AS
SELECT 
    KH.MAKH AS [Mã Khách Hàng],
    KH.HOTEN AS [Họ Tên],
    KH.SDT AS [Số Điện Thoại],
    KH.EMAIL AS [Email],
    HD.MAHOADON AS [Mã Hóa Đơn],
    HD.NGAYMUA AS [Ngày Mua],
    HD.TONGTIEN AS [Tổng Tiền Hóa Đơn],
    V.MAVE AS [Mã Vé],
    P.TENPHIM AS [Tên Phim],
    SC.NGAYGIOCHIEU AS [Suất Chiếu],
    V.MAGHE AS [Mã Ghế],
    V.GIAVEMUA AS [Giá Vé Mua]
FROM KHACH_HANG KH
LEFT JOIN HOA_DON HD ON KH.MAKH = HD.MAKH
LEFT JOIN VE V ON HD.MAHOADON = V.MAHOADON
LEFT JOIN SUAT_CHIEU SC ON V.MASUATCHIEU = SC.MASUATCHIEU
LEFT JOIN PHIM P ON SC.MAPHIM = P.MAPHIM;
GO
-- ---------------------------------------------------------
-- TEST VIEWS
-- ---------------------------------------------------------

-- Lệnh chạy test cho: CREATE VIEW VW_DoanhThuPhim
-- Tác dụng: Xem toàn bộ dữ liệu thống kê doanh thu theo từng phim
SELECT * FROM VW_DoanhThuPhim;

-- Lệnh chạy test cho: CREATE VIEW VW_DoanhThuPhim
-- Tác dụng: Xem doanh thu gộp lại theo từng thể loại phim
SELECT THELOAI, SUM(DOANHTHU) AS TONGDOANHTHU FROM VW_DoanhThuPhim GROUP BY THELOAI;

-- Lệnh chạy test cho: CREATE VIEW VW_LICH_CHIEU
-- Tác dụng: Xem toàn bộ lịch chiếu cùng với chi tiết tên phim và phòng chiếu
SELECT * FROM VW_LICH_CHIEU;

-- Lệnh chạy test cho: CREATE VIEW VW_LICH_CHIEU
-- Tác dụng: Lọc và tra cứu toàn bộ các suất chiếu trong một ngày cụ thể (2026-07-20)
SELECT * FROM VW_LICH_CHIEU WHERE CAST(NGAYGIOCHIEU AS DATE) = '2026-07-20';

-- Lệnh chạy test cho: CREATE VIEW VW_LICH_CHIEU
-- Tác dụng: Lọc và tra cứu toàn bộ lịch chiếu diễn ra tại 'Phòng 1'
SELECT * FROM VW_LICH_CHIEU WHERE TENPHONG = N'Phòng 1';

-- Lệnh chạy test cho: CREATE VIEW VW_KHACHHANG_MUALICHSU
-- Tác dụng: Xem toàn bộ lịch sử mua vé của khách hàng
SELECT * FROM VW_KHACHHANG_MUALICHSU;
