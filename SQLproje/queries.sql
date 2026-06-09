-- queries.sql

-- SORGU 1
-- Açıklama: Sistemdeki siparişlerin hangi müşteri tarafından, hangi adrese verildiğini 
-- ve siparişte kullanılan kampanya kupon kodunu (eğer kullanıldıysa) listeler.
-- Birleştirme Sütunları: Siparis.Musteri_ID = Musteri.Musteri_ID, Siparis.Adres_ID = Adres.Adres_ID, Siparis.Kampanya_ID = Kampanya.Kampanya_ID

SELECT 
    S.Siparis_ID,
    M.Musteri_ad,
    M.Musteri_soyad,
    A.Adres_basligi,
    A.ilce,
    S.Toplam_tutar,
    S.Siparis_durumu,
    K.Kupon_Kodu AS Kullanilan_Kupon
FROM Siparis S
INNER JOIN Musteri M ON S.Musteri_ID = M.Musteri_ID
INNER JOIN Adres A ON S.Adres_ID = A.Adres_ID
LEFT JOIN Kampanya K ON S.Kampanya_ID = K.Kampanya_ID;


-- SORGU 2
-- Açıklama: Başarıyla tamamlanmış (Başarılı) ödemelerin hangi siparişe ait olduğunu, 
-- ödemeyi yapan müşterinin adını, ödeme yöntemini ve tarihini raporlar.
-- Birleştirme Sütunları: Odeme.Siparis_ID = Siparis.Siparis_ID ve Siparis.Musteri_ID = Musteri.Musteri_ID
-- (Sorgu 1'den tamamen farklı sütun eşleşmeleri kullanılarak ödeme bazlı analiz yapılmıştır)

SELECT 
    O.Odeme_ID,
    O.Islem_no,
    M.Musteri_ad,
    M.Musteri_soyad,
    O.Odeme_tutari,
    O.Odeme_yontemi,
    O.Odeme_tarihi,
    S.Siparis_durumu
FROM Odeme O
INNER JOIN Siparis S ON O.Siparis_ID = S.Siparis_ID
INNER JOIN Musteri M ON S.Musteri_ID = M.Musteri_ID
WHERE O.Odeme_durumu = 'Başarılı';