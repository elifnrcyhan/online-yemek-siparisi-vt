-- data.sql

-- Müşteri Verileri
INSERT INTO Musteri (Musteri_ad, Musteri_soyad, Musteri_Eposta, Musteri_Telefon, Musteri_Sifre, Kayit_tarihi, Son_giris_tarihi) VALUES
('Elif Nur', 'Ceyhan', 'elif@email.com', '5551112233', 'sifre12345', '2026-01-10', '2026-05-19'),
('Ahmet', 'Yılmaz', 'ahmet@email.com', '5552223344', 'secure987', '2026-02-15', '2026-05-18'),
('Ayşe', 'Demir', 'ayse@email.com', '5553334455', 'ayse_pass', '2026-03-20', '2026-05-15');

-- Adres Verileri
INSERT INTO Adres (Adres_basligi, Tam_adres, il, ilce, Musteri_ID) VALUES
('Ev', 'Özlüce Mah. Çiçek Sok. No:5', 'Bursa', 'Nilüfer', 1),
('İş', 'Teknopark A Blok Ofis:12', 'Bursa', 'Görükle', 1),
('Ev', 'Atatürk Cad. Neşe Apartmanı No:10', 'İstanbul', 'Kadıköy', 2),
('Ev', 'Hürriyet Mah. Yeşil Sok. No:2', 'Bursa', 'Osmangazi', 3);

-- Kampanya Verileri
INSERT INTO Kampanya (Kupon_Kodu, Indirim_Orani, Baslangic_Tarihi, Bitis_Tarihi) VALUES
('BAHAR20', 20, '2026-03-01', '2026-05-31'),
('LEZZET50', 50, '2026-05-01', '2026-06-01'),
('HOŞGELDİN10', 10, '2026-01-01', '2026-12-31');

-- Sipariş Verileri
INSERT INTO Siparis (Siparis_tarihi, Siparis_durumu, Toplam_tutar, Musteri_ID, Adres_ID, Kampanya_ID) VALUES
('2026-05-10', 'Teslim Edildi', 250.00, 1, 1, 1),
('2026-05-18', 'Kurye Yolda', 180.00, 1, 2, NULL),
('2026-05-15', 'Teslim Edildi', 320.00, 2, 3, 2),
('2026-05-19', 'Hazırlanıyor', 120.00, 3, 4, NULL);

-- Ödeme Verileri
INSERT INTO Odeme (Odeme_tutari, Islem_no, Odeme_durumu, Odeme_yontemi, Odeme_tarihi, Siparis_ID) VALUES
(250.00, 987654, 'Başarılı', 'Kredi Kartı', '2026-05-10', 1),
(180.00, 987655, 'Bekliyor', 'Nakit', '2026-05-18', 2),
(320.00, 987656, 'Başarılı', 'Banka Kartı', '2026-05-15', 3),
(120.00, 987657, 'Başarısız', 'Kredi Kartı', '2026-05-19', 4);

-- Analiz Verileri
INSERT INTO Analiz (Cok_kullanilan_kategori, Ort_harcama, Toplam_siparis_sayisi, Musteri_ID) VALUES
('Fast Food', 215.00, 2, 1),
('Ev Yemekleri', 320.00, 1, 2),
('Tatlı', 120.00, 1, 3);