-- =========================================================================
-- TẠO TRIGGERS (Trình kích hoạt)
-- =========================================================================
GO 
-- Tạo Trigger: Ngăn chặn việc bán trùng ghế trong cùng một suất chiếu. Báo lỗi và hủy lệnh chèn nếu phát hiện vé đã tồn tại.
CREATE TRIGGER TRG_KHONG_TRUNG_GHE
ON VE
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
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
GO

-- Tạo Trigger: Kiểm tra số vé đã bán so với số ghế tối đa của suất chiếu. Hủy giao dịch (ROLLBACK) nếu số lượng vé vượt quá giới hạn ghế của phòng.
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
GO
-- ---------------------------------------------------------
-- TEST TRIGGER: TRG_KHONG_TRUNG_GHE
-- ---------------------------------------------------------

BEGIN TRY
    -- Lệnh chạy test cho: CREATE TRIGGER TRG_KHONG_TRUNG_GHE
    -- Tác dụng: Cố tình chèn một vé bị trùng mã ghế (A01) ở cùng một suất chiếu (SC001) để kích hoạt Trigger chặn lỗi
    INSERT INTO VE (MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA) 
    VALUES ('V998', 'HD001', 'SC001', 'A01', 90000);
END TRY
BEGIN CATCH
    -- Lệnh chạy test cho: CREATE TRIGGER TRG_KHONG_TRUNG_GHE
    -- Tác dụng: In ra thông báo lỗi do Trigger báo về khi cố tình thêm trùng ghế
    SELECT ERROR_MESSAGE() AS [Thông Báo Lỗi Trigger];
END CATCH;

-- Lệnh chạy test cho: CREATE TRIGGER TRG_KHONG_TRUNG_GHE
-- Tác dụng: Chèn một vé với mã ghế mới (B01) hợp lệ vào suất chiếu SC001 để đảm bảo Trigger vẫn cho phép chèn dữ liệu đúng
INSERT INTO VE (MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA) 
VALUES ('V999', 'HD001', 'SC001', 'B01', 90000);

-- Lệnh chạy test cho: CREATE TRIGGER TRG_KHONG_TRUNG_GHE
-- Tác dụng: Xem lại danh sách vé của SC001 để nghiệm thu (xác nhận V999 đã có và V998 không lọt vào bảng)
SELECT * FROM VE WHERE MASUATCHIEU = 'SC001';


-- ---------------------------------------------------------
-- TEST TRIGGER: TRG_KIEMTRASOLUONGVE
-- ---------------------------------------------------------

-- Chuẩn bị dữ liệu test: Thêm 1 suất chiếu chỉ có 2 ghế và 1 hóa đơn để test
INSERT INTO SUAT_CHIEU (MASUATCHIEU, MAPHIM, MAPHONG, NGAYGIOCHIEU, GIAVE, SOGHETOIDA) 
VALUES ('SC_TEST', 'P001', 'PC01', '2026-08-01 10:00', 90000, 2);
INSERT INTO HOA_DON (MAHOADON, MAKH, NGAYMUA, TONGTIEN) 
VALUES ('HD_TEST', 'KH001', '2026-08-01', 270000);

-- Lệnh chạy test cho: CREATE TRIGGER TRG_KIEMTRASOLUONGVE
-- Tác dụng: Bán thành công vé đầu tiên (tình trạng 1/2)
INSERT INTO VE (MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA) 
VALUES ('V_TEST1', 'HD_TEST', 'SC_TEST', 'A01', 90000);

-- Lệnh chạy test cho: CREATE TRIGGER TRG_KIEMTRASOLUONGVE
-- Tác dụng: Bán thành công vé thứ hai (tình trạng 2/2 - vừa đầy phòng)
INSERT INTO VE (MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA) 
VALUES ('V_TEST2', 'HD_TEST', 'SC_TEST', 'A02', 90000);

-- Lệnh chạy test cho: CREATE TRIGGER TRG_KIEMTRASOLUONGVE
-- Tác dụng: Bán vé thứ ba (tình trạng 3/2 - quá tải). Lệnh này sẽ kích hoạt Trigger báo lỗi và hủy giao dịch.
INSERT INTO VE (MAVE, MAHOADON, MASUATCHIEU, MAGHE, GIAVEMUA) 
VALUES ('V_TEST3', 'HD_TEST', 'SC_TEST', 'A03', 90000);

-- Lệnh chạy test cho: CREATE TRIGGER TRG_KIEMTRASOLUONGVE
-- Tác dụng: Nghiệm thu kết quả. Kiểm tra lại xem vé thứ 3 (V_TEST3) có tồn tại không. (Mong đợi là không)
SELECT * FROM VE WHERE MASUATCHIEU = 'SC_TEST';