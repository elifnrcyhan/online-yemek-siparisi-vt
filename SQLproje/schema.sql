-- schema.sql

CREATE TABLE Musteri (
    Musteri_ID INT NOT NULL AUTO_INCREMENT,
    Musteri_ad VARCHAR(45) NOT NULL,
    Musteri_soyad VARCHAR(45) NOT NULL,
    Musteri_Eposta VARCHAR(45) NOT NULL UNIQUE,
    Musteri_Telefon VARCHAR(45),
    Musteri_Sifre VARCHAR(45) NOT NULL,
    Kayit_tarihi DATE NOT NULL,
    Son_giris_tarihi DATE,
    PRIMARY KEY (Musteri_ID)
);

CREATE TABLE Adres (
    Adres_ID INT NOT NULL AUTO_INCREMENT,
    Adres_basligi VARCHAR(45) NOT NULL,
    Tam_adres VARCHAR(255) NOT NULL,
    il VARCHAR(45) NOT NULL,
    ilce VARCHAR(45) NOT NULL,
    Musteri_ID INT NOT NULL,
    PRIMARY KEY (Adres_ID),
    FOREIGN KEY (Musteri_ID) REFERENCES Musteri(Musteri_ID) ON DELETE CASCADE
);

CREATE TABLE Kampanya (
    Kampanya_ID INT NOT NULL AUTO_INCREMENT,
    Kupon_Kodu VARCHAR(45) NOT NULL UNIQUE,
    Indirim_Orani INT NOT NULL,
    Baslangic_Tarihi DATE NOT NULL,
    Bitis_Tarihi DATE NOT NULL,
    PRIMARY KEY (Campanya_ID)
);

CREATE TABLE Siparis (
    Siparis_ID INT NOT NULL AUTO_INCREMENT,
    Siparis_tarihi DATE NOT NULL,
    Siparis_durumu ENUM('Hazırlanıyor', 'Kurye Yolda', 'Teslim Edildi', 'İptal Edildi') NOT NULL,
    Toplam_tutar DECIMAL(10,2) NOT NULL,
    Musteri_ID INT NOT NULL,
    Adres_ID INT NOT NULL,
    Kampanya_ID INT NULL, -- Kampanya kullanımı zorunlu olmadığı için NULL olabilir
    PRIMARY KEY (Siparis_ID),
    FOREIGN KEY (Musteri_ID) REFERENCES Musteri(Musteri_ID),
    FOREIGN KEY (Adres_ID) REFERENCES Adres(Adres_ID),
    FOREIGN KEY (Kampanya_ID) REFERENCES Kampanya(Kampanya_ID) ON DELETE SET NULL
);

CREATE TABLE Odeme (
    Odeme_ID INT NOT NULL AUTO_INCREMENT,
    Odeme_tutari DECIMAL(10,2) NOT NULL,
    Islem_no INT NOT NULL UNIQUE,
    Odeme_durumu ENUM('Bekliyor', 'Başarılı', 'Başarısız', 'İade Edildi') NOT NULL,
    Odeme_yontemi ENUM('Kredi Kartı', 'Banka Kartı', 'Nakit', 'Havale/EFT') NOT NULL,
    Odeme_tarihi DATE NOT NULL,
    Siparis_ID INT NOT NULL,
    PRIMARY KEY (Odeme_ID),
    FOREIGN KEY (Siparis_ID) REFERENCES Siparis(Siparis_ID) ON DELETE CASCADE
);

CREATE TABLE Analiz (
    Analiz_ID INT NOT NULL AUTO_INCREMENT,
    Cok_kullanilan_kategori VARCHAR(45),
    Ort_harcama DECIMAL(10,2) DEFAULT 0.00,
    Toplam_siparis_sayisi INT DEFAULT 0,
    Musteri_ID INT NOT NULL,
    PRIMARY KEY (Analiz_ID),
    FOREIGN KEY (Musteri_ID) REFERENCES Musteri(Musteri_ID) ON DELETE CASCADE
);