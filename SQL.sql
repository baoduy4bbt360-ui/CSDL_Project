CREATE DATABASE QUANLYXEMPHIM
USE QUANLYXEMPHIM


CREATE TABLE PHIM (
MAPHIM VARCHAR(10) PRIMARY KEY,
TENPHIM NVARCHAR(100) NOT NULL,
THELOAI NVARCHAR(50) NOT NULL,
THOILUONG INT
)

INSERT INTO PHIM VALUES
('P001',N'Avengers: Endgame',N'Hành động',181),
('P002',N'Avatar 2',N'Khoa học viễn tưởng',192),
('P003',N'Conan Movie 27',N'Hoạt hình',110),
('P004',N'Lật Mặt 8',N'Hài',125),
('P005',N'Quỷ Cẩu',N'Kinh dị',105),
('P006',N'Doraemon',N'Hoạt hình',100),
('P007',N'John Wick 4',N'Hành động',169),
('P008',N'Fast X',N'Hành động',142),
('P009',N'Inside Out 2',N'Hoạt hình',98),
('P010',N'Elemental',N'Hoạt hình',102),
('P011',N'Kungfu Panda 4',N'Hoạt hình',95),
('P012',N'Your Name',N'Tình cảm',106),
('P013',N'Interstellar',N'Khoa học viễn tưởng',169),
('P014',N'Inception',N'Khoa học viễn tưởng',148),
('P015',N'Titanic',N'Tình cảm',194),
('P016',N'Parasite',N'Tâm lý',132),
('P017',N'Train To Busan',N'Kinh dị',118),
('P018',N'Minions',N'Hoạt hình',91),
('P019',N'The Batman',N'Hành động',176),
('P020',N'Spider-Man',N'Hành động',150);
SELECT * FROM PHIM;


CREATE TABLE PHONG_CHIEU (
MAPHONG VARCHAR(10) PRIMARY KEY,
TENPHONG NVARCHAR(50) NOT NULL
)
INSERT INTO PHONG_CHIEU VALUES
('PC01',N'Phòng 1'),
('PC02',N'Phòng 2'),
('PC03',N'Phòng 3'),
('PC04',N'Phòng 4'),
('PC05',N'Phòng VIP');
SELECT * FROM PHONG_CHIEU;


CREATE TABLE SUAT_CHIEU (
MASUATCHIEU VARCHAR(15) PRIMARY KEY,
MAPHIM VARCHAR(10),
FOREIGN KEY (MAPHIM) REFERENCES PHIM(MAPHIM),
MAPHONG VARCHAR(10),
FOREIGN KEY (MAPHONG) REFERENCES PHONG_CHIEU(MAPHONG),
NGAYGIOCHIEU DATETIME,
GIAVE DECIMAL(15,2),
SOGHETOIDA INT
)
INSERT INTO SUAT_CHIEU VALUES
('SC001','P001','PC01','2026-07-20 09:00',90000,100),
('SC002','P002','PC02','2026-07-20 10:00',100000,100),
('SC003','P003','PC03','2026-07-20 11:00',80000,80),
('SC004','P004','PC04','2026-07-20 13:00',90000,80),
('SC005','P005','PC05','2026-07-20 15:00',120000,50),
('SC006','P006','PC01','2026-07-21 09:00',80000,100),
('SC007','P007','PC02','2026-07-21 11:00',100000,100),
('SC008','P008','PC03','2026-07-21 13:00',100000,80),
('SC009','P009','PC04','2026-07-21 15:00',90000,80),
('SC010','P010','PC05','2026-07-21 19:00',120000,50),
('SC011','P011','PC01','2026-07-22 09:00',90000,100),
('SC012','P012','PC02','2026-07-22 11:00',100000,100),
('SC013','P013','PC03','2026-07-22 13:00',110000,80),
('SC014','P014','PC04','2026-07-22 15:00',100000,80),
('SC015','P015','PC05','2026-07-22 19:00',120000,50),
('SC016','P016','PC01','2026-07-23 09:00',90000,100),
('SC017','P017','PC02','2026-07-23 11:00',90000,100),
('SC018','P018','PC03','2026-07-23 13:00',80000,80),
('SC019','P019','PC04','2026-07-23 15:00',100000,80),
('SC020','P020','PC05','2026-07-23 19:00',120000,50);
SELECT * FROM SUAT_CHIEU;


CREATE TABLE KHACH_HANG (
MAKH VARCHAR(15) PRIMARY KEY,
HOTEN NVARCHAR(100) NOT NULL,
SDT VARCHAR(15) NOT NULL,
EMAIL VARCHAR(100) 
)
INSERT INTO KHACH_HANG VALUES
('KH001',N'Nguyễn Văn A','0901111111','a@gmail.com'),
('KH002',N'Trần Văn B','0901111112','b@gmail.com'),
('KH003',N'Lê Văn C','0901111113','c@gmail.com'),
('KH004',N'Phạm Văn D','0901111114','d@gmail.com'),
('KH005',N'Hoàng Văn E','0901111115','e@gmail.com'),
('KH006',N'Nguyễn Văn F','0901111116','f@gmail.com'),
('KH007',N'Đỗ Văn G','0901111117','g@gmail.com'),
('KH008',N'Bùi Văn H','0901111118','h@gmail.com'),
('KH009',N'Võ Văn I','0901111119','i@gmail.com'),
('KH010',N'Ngô Văn K','0901111120','k@gmail.com');
SELECT * FROM KHACH_HANG;


CREATE TABLE HOA_DON (
MAHOADON VARCHAR(20) PRIMARY KEY,
MAKH VARCHAR(15),
FOREIGN KEY (MAKH) REFERENCES KHACH_HANG(MAKH),
NGAYMUA DATETIME NOT NULL,
TONGTIEN DECIMAL(15,2) NOT NULL
)
INSERT INTO HOA_DON VALUES
('HD001','KH001','2026-07-19',90000),
('HD002','KH002','2026-07-19',100000),
('HD003','KH003','2026-07-19',80000),
('HD004','KH004','2026-07-19',90000),
('HD005','KH005','2026-07-19',120000),
('HD006','KH006','2026-07-20',90000),
('HD007','KH007','2026-07-20',100000),
('HD008','KH008','2026-07-20',80000),
('HD009','KH009','2026-07-20',90000),
('HD010','KH010','2026-07-20',120000);
SELECT * FROM HOA_DON;


CREATE TABLE VE (
MAVE VARCHAR(20) PRIMARY KEY,
MAHOADON VARCHAR(20),
FOREIGN KEY (MAHOADON) REFERENCES HOA_DON(MAHOADON),
MASUATCHIEU VARCHAR(15),
FOREIGN KEY (MASUATCHIEU) REFERENCES SUAT_CHIEU(MASUATCHIEU),
MAGHE VARCHAR(10) NOT NULL,
GIAVEMUA DECIMAL(15,2) NOT NULL
)
INSERT INTO VE VALUES
('V001','HD001','SC001','A01',90000),
('V002','HD002','SC002','A01',100000),
('V003','HD003','SC003','A01',80000),
('V004','HD004','SC004','A01',90000),
('V005','HD005','SC005','A01',120000),
('V006','HD006','SC006','A02',90000),
('V007','HD007','SC007','A02',100000),
('V008','HD008','SC008','A02',80000),
('V009','HD009','SC009','A02',90000),
('V010','HD010','SC010','A02',120000);
SELECT * FROM VE;


GO
CREATE VIEW VW_LICH_CHIEU
AS
SELECT SC.MASUATCHIEU, P.TENPHIM, P.THELOAI, PC.TENPHONG, SC.NGAYGIOCHIEU, SC.GIAVE, SC.SOGHETOIDA
FROM SUAT_CHIEU AS SC
JOIN PHIM AS P ON SC.MAPHIM=P.MAPHIM
JOIN PHONG_CHIEU AS PC ON SC.MAPHONG=PC.MAPHONG;
GO
-- Xem toàn bộ lịch chiếu cùng thông tin phim và phòng chiếu
SELECT * FROM VW_LICH_CHIEU;

-----------------------------------
CREATE VIEW VW_KHACHHANG_MUALICHSU
AS
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

-- Xem lịch sử mua vé của khách hàng (Bao gồm cả những khách chưa mua vé nếu có)
SELECT * FROM VW_KHACHHANG_MUALICHSU;

-----------------------------------------
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
-- Test 1: Kiểm tra số ghế trống của suất chiếu SC001 
-- Theo dữ liệu của bạn, SC001 có tối đa 100 ghế và đã bán 2 vé (A01), kết quả mong đợi là 98.
SELECT dbo.fn_SoGheTrong('SC001') AS [Số Ghế Trống SC001];

------------------------------------------------
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
-- Test 2: Tính tổng doanh thu trong một ngày cụ thể (vd: 2026-07-19)
SELECT dbo.fn_TongDoanhThuTheoNgayThang('2026-07-19', NULL, NULL) AS [Doanh Thu Ngày 19/07/2026];

-- Test 3: Tính tổng doanh thu trong một tháng/năm cụ thể (vd: Tháng 7/2026)
SELECT dbo.fn_TongDoanhThuTheoNgayThang(NULL, 7, 2026) AS [Doanh Thu Tháng 07/2026];

--------------------------------------------------------------
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

-- Test 4: Tìm phim có tổng doanh thu cao nhất từ việc bán vé
SELECT * FROM dbo.fn_PhimDoanhThuCaoNhat();

--------------------------------------------------------
GO 
CREATE TRIGGER TRG_KHONG_TRUNG_GHE
ON VE
INSTEAD OF INSERT
AS
BEGIN

    IF EXISTS
    (
        SELECT * FROM VE V
        JOIN inserted I ON V.MASUATCHIEU = I.MASUATCHIEU
        AND V.MAGHE = I.MAGHE
    )
    BEGIN
        RAISERROR(N'Ghế này đã được bán trong suất chiếu.',16,1);
        RETURN;
    END

    INSERT INTO VE (MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA)
    SELECT MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA FROM inserted;

END;
-- Test 1: Cố tình chèn một vé bị TRÙNG suất chiếu (SC001) và TRÙNG mã ghế (A01).
-- KẾT QUẢ MONG ĐỢI: Hệ thống sẽ báo lỗi "Ghế này đã được bán trong suất chiếu." và lệnh bị hủy.
BEGIN TRY
    INSERT INTO VE (MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA) 
    VALUES ('V998', 'HD001', 'SC001', 'A01', 90000);
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS [Thông Báo Lỗi Trigger];
END CATCH;

-- Test 2: Chèn một vé với mã ghế MỚI (B01) cho cùng suất chiếu SC001.
-- KẾT QUẢ MONG ĐỢI: Thêm thành công vì ghế này chưa ai mua.
INSERT INTO VE (MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA) 
VALUES ('V999', 'HD001', 'SC001', 'B01', 90000);

-- Kiểm tra lại bảng vé để xác nhận V999 đã được thêm và V998 không tồn tại
SELECT * FROM VE WHERE MASUATCHIEU = 'SC001';

-------------------------------------------------------
CREATE TRIGGER TRG_KIEMTRASOLUONGVE
ON VE
FOR INSERT
AS
BEGIN
DECLARE @MASUATCHIEU VARCHAR(10);
DECLARE @SOVEDABAN INT;
DECLARE @SOGHETOIDA INT;

SELECT @MASUATCHIEU = MASUATCHIEU FROM INSERTED;
SELECT @SOVEDABAN = COUNT(*) FROM VE
WHERE MASUATCHIEU = @MASUATCHIEU;
SELECT @SOGHETOIDA = SOGHETOIDA FROM SUAT_CHIEU
WHERE MASUATCHIEU = @MASUATCHIEU;
IF (@SOVEDABAN > @SOGHETOIDA)
BEGIN
PRINT N'Lỗi: Suất chiếu này đã hết ghế trống! Không thể bán thêm vé.';
ROLLBACK TRANSACTION;
END
ELSE
BEGIN
PRINT N'Bán vé thành công!';
END
END;

-- Bước 1: Chuẩn bị dữ liệu để test
-- Tạo 1 suất chiếu (SC_TEST) giới hạn đúng 2 ghế tối đa
INSERT INTO SUAT_CHIEU (MASUATCHIEU, MAPHIM, MAPHONG, NGAYGIOCHIEU, GIAVE, SOGHETOIDA) 
VALUES ('SC_TEST', 'P001', 'PC01', '2026-08-01 10:00', 90000, 2);

-- Tạo 1 hóa đơn (HD_TEST) của khách hàng KH001 để mua vé
INSERT INTO HOA_DON (MAHOADON, MAKH, NGAYMUA, TONGTIEN) 
VALUES ('HD_TEST', 'KH001', '2026-08-01', 270000);


-- Bước 2: Test kịch bản hợp lệ (Bán vé khi vẫn còn ghế)
-- Bán vé thứ nhất (Tình trạng: 1/2 ghế)
INSERT INTO VE (MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA) 
VALUES ('V_TEST1', 'HD_TEST', 'SC_TEST', 'A01', 90000);
-- Kết quả hệ thống sẽ báo: "Bán vé thành công!"

-- Bán vé thứ hai (Tình trạng: 2/2 ghế -> Vừa đầy)
INSERT INTO VE (MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA) 
VALUES ('V_TEST2', 'HD_TEST', 'SC_TEST', 'A02', 90000);
-- Kết quả hệ thống sẽ báo: "Bán vé thành công!"


-- Bước 3: Test kịch bản vi phạm (Cố tình bán lố ghế)
-- Bán vé thứ ba (Tình trạng: 3/2 ghế -> Bị lố)
INSERT INTO VE (MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA) 
VALUES ('V_TEST3', 'HD_TEST', 'SC_TEST', 'A03', 90000);
-- KẾT QUẢ: Hệ thống báo lỗi đỏ, in ra dòng chữ "Lỗi: Suất chiếu này đã vượt quá..." và lệnh này bị hủy.


-- Bước 4: Nghiệm thu (Kiểm tra lại xem vé thứ 3 có lọt vào bảng không)
SELECT * FROM VE WHERE MASUATCHIEU = 'SC_TEST';
-- Bạn sẽ thấy chỉ có V_TEST1 và V_TEST2 tồn tại. V_TEST3 đã bị Trigger chặn đứng thành công.