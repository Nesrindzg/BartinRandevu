-- Hasta Giri� Yaparken Bilgilerini Kontrol Etmek ��in Yazd���m Prosed�r --
/*
CREATE PROCEDURE sp_HastaKontrol
    @hastaTC varchar(11),
    @hastaSifre varchar(50)
AS
BEGIN
    SELECT * FROM tblHasta WHERE hastaTC = @hastaTC AND hastaSifre = @hastaSifre;
END
*/

-- Hasta Eklemek ��in Olu�turdu�um Prosed�r --
/*
CREATE PROCEDURE sp_HastaEkle
    @hastaAdi varchar(25),
    @hastaSoyadi varchar(25),
    @hastaCinsiyeti varchar(5),
    @hastaTC varchar(11),
    @hastaDTarihi date,
    @hastaTel varchar(11),
    @hastaMail varchar(50),
    @hastaSifre varchar(50),
    @Message varchar(50) OUTPUT
AS
BEGIN
    -- E�er hastaTC daha �nce kullan�lm��sa hata d�nd�r. Burada hastan�n kayd� olup olmad��� kontrol edilir.
    IF EXISTS (SELECT 1 FROM tblHasta WHERE hastaTC = @hastaTC)
    BEGIN
        SET @Message = 'Girilen T.C. Kimlik Numaras� Mevcut';
        RETURN;
    END

    INSERT INTO tblHasta (hastaAdi, hastaSoyadi, hastaCinsiyeti, hastaTC, hastaDTarihi, hastaTel, hastaMail, hastaSifre)
    VALUES (@hastaAdi, @hastaSoyadi, @hastaCinsiyeti, @hastaTC, @hastaDTarihi, @hastaTel, @hastaMail, @hastaSifre);

    SET @Message = 'Kay�t Yap�ld�';
END
*/

-- Mail G�nderebilmek ��in Hasta Bilgilerini Kontrol Etme Prosed�r� --
/*
CREATE PROCEDURE sp_HastaTCveMailKontrol
    @hastaTC varchar(11),
    @hastaMail varchar(50)
AS
BEGIN

    SELECT 
        tblHasta.hastaAdi + ' ' + tblHasta.hastaSoyadi AS adSoyad,
        tblHasta.hastaSifre
    FROM 
        tblHasta
    WHERE 
        tblHasta.hastaTC = @hastaTC
        AND tblHasta.hastaMail = @hastaMail;
END
*/

-- Poliklinkleri Listelemek ��in Yazd���m Prosed�r --
/*
CREATE PROCEDURE sp_PoliklinikleriGetir
AS
BEGIN
    SELECT poliklinikAdi
    FROM tblPoliklinik;
END
*/

-- Se�ilen Poliklinike G�re Doktor Bilgisi Listeleme --
/*
CREATE PROCEDURE sp_PoliklinikDoktoruGetir
    @poliklinikAdi varchar(50)
AS
BEGIN
    SELECT d.doktorID, d.doktorAdi + ' ' + d.doktorSoyadi AS 'doktorAdSoyad'
    FROM tblDoktor d
    INNER JOIN tblPoliklinik p ON p.poliklinikID = d.poliklinikNo
    WHERE p.poliklinikAdi = @poliklinikAdi
END
*/

-- Randevu Uygunlu�unu Kontrol Etmek ��in azd��� Prosed�r --
/*
CREATE PROCEDURE sp_KontrolRandevu
    @doktorNo INT,
    @hastaNo INT,
    @randevuTarihi DATE,
    @randevuSaati TIME
AS
BEGIN
    DECLARE @doktorRandevuCount INT
    DECLARE @hastaRandevuCount INT

    SELECT @doktorRandevuCount = COUNT(*) 
    FROM tblRandevu 
    WHERE doktorNo = @doktorNo 
        AND randevuTarihi = @randevuTarihi 
        AND randevuSaati = @randevuSaati

    SELECT @hastaRandevuCount = COUNT(*) 
    FROM tblRandevu 
    WHERE hastaNo = @hastaNo 
        AND randevuTarihi = @randevuTarihi 
        AND randevuSaati = @randevuSaati

    SELECT @doktorRandevuCount AS doktorRandevuCount, @hastaRandevuCount AS hastaRandevuCount
END
*/

-- Randevu Olu�turma Prosed�r� --
/*
CREATE PROCEDURE sp_EkleRandevu
    @hastaNo INT,
    @doktorNo INT,
    @randevuTarihi DATE,
    @randevuSaati TIME
AS
BEGIN
    INSERT INTO tblRandevu (hastaNo, doktorNo, randevuTarihi, randevuSaati)
    VALUES (@hastaNo, @doktorNo, @randevuTarihi, @randevuSaati)
    
    SELECT SCOPE_IDENTITY() AS randevuID
END
*/

-- Randevu Bilgisi Bulan Prosed�r --
/*
CREATE PROCEDURE sp_BulRandevu
    @randevuID INT,
    @hastaID INT
AS
BEGIN
    SELECT * 
    FROM tblRandevu
    INNER JOIN tblDoktor ON tblRandevu.doktorNo = tblDoktor.doktorID 
	INNER JOIN tblPoliklinik ON tblDoktor.poliklinikNo=tblPoliklinik.poliklinikID
    WHERE randevuID = @randevuID AND hastaNo = @hastaID
END
*/

-- Randevu G�ncelleme Prosed�r� --
/*
CREATE PROCEDURE sp_GuncelleRandevu
    @tarih DATE,
    @saat TIME,
    @randevuID INT
AS
BEGIN
    UPDATE tblRandevu
    SET randevuTarihi = @tarih,
        randevuSaati = @saat
    WHERE randevuID = @randevuID
END
*/

-- Randevu �ptal Etme Prosed�r� --
/*
CREATE PROCEDURE sp_SilRandevu
    @randevuID INT,
    @hastaID INT
AS
BEGIN
    DELETE FROM tblRandevu
    WHERE randevuID = @randevuID AND hastaNo = @hastaID
END
*/

-- Hasta Randevular�n� Listeleme Prosed�r� --
/*
CREATE PROCEDURE sp_HastaRandevulariListele
    @hastaID INT
AS
BEGIN
    SELECT r.randevuID AS 'Randevu_No', p.poliklinikAdi AS 'Poliklinik', CONCAT(d.doktorAdi, ' ', d.doktorSoyadi) AS 'Doktor', FORMAT(r.randevuTarihi, 'dd/MM/yyyy ') AS 'Tarih', r.randevuSaati AS 'Saat'
    FROM tblRandevu r
    INNER JOIN tblDoktor d ON d.doktorID = r.doktorNo
    INNER JOIN tblPoliklinik p ON p.poliklinikID = d.poliklinikNo
    WHERE r.hastaNo = @hastaID
END
*/