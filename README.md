# Veritabanı Yönetim Sistemleri - Dijital Yemek Sipariş Platformu (Müşteri & İşlem Alt Yapısı)

[cite_start]Bu proje, bir **Dijital Yemek Sipariş Platformu** için geliştirilen ilişkisel veritabanı modelinin **Müşteri İlişkileri, Adres Yönetimi, Kampanya Entegrasyonu, Sipariş ve Ödeme Takip** süreçlerini kapsamaktadır[cite: 8, 22]. [cite_start]Proje, bir e-ticaret platformunun kullanıcı odaklı tüm arka plan işlemlerini donanımsal ve mantıksal iş kurallarına uygun şekilde yönetmek üzere tasarlanmıştır[cite: 24, 44].

## 👥 İş Bölümü ve Kapsam
[cite_start]Proje ortak bir ekip çalışması olup, bu depoda (repository) **yalnızca şahsım tarafından tasarlanan ve kodlanan** modüller yer almaktadır[cite: 32]:
* [cite_start]**Elif Nur Ceyhan (23360859023):** Müşteri profilleri, çoklu adres yönetimi, finansal ödeme altyapısı, kupon/indirim modülleri ve müşteri harcama alışkanlıklarının analitik takibi[cite: 9, 34].

---

## 🚀 Modellenen Süreçler ve Özellikler

1. [cite_start]**Kullanıcı & Güvenli Giriş Yönetimi:** Müşterilerin temel iletişim bilgilerinin tutulması, minimum 8 karakterli şifre kuralı ve sisteme son giriş tarihlerinin takibi[cite: 37, 59, 61].
2. [cite_start]**Çoklu Teslimat Adresi:** Her müşterinin "Ev", "İş" gibi başlıklarla sistemde birden fazla açık adres tanımlayabilmesi[cite: 26, 37, 63].
3. [cite_start]**Esnek Sipariş Yapısı:** Siparişlerin anlık durum takibi (`Hazırlanıyor`, `Kurye Yolda`, `Teslim Edildi`, `İptal Edildi`) ve toplam tutar kontrolleri[cite: 27, 40, 131].
4. [cite_start]**Çeşitlendirilmiş Ödeme Altyapısı:** Kredi Kartı, Banka Kartı, Nakit ve Havale yöntemleriyle yapılan ödemelerin başarı durumlarına (`Bekliyor`, `Başarılı`, `Başarısız`, `İade Edildi`) göre kayıt altına alınması[cite: 27, 41, 157, 163].
5. [cite_start]**Kampanya & Promosyon Yönetimi:** Belirli tarihler arasında geçerli, benzersiz kupon kodları ve %0-%100 arası indirim oranlarının sisteme entegrasyonu[cite: 28, 42, 176, 177].
6. [cite_start]**Otomatik Müşteri Analitiği:** Müşterilerin geçmiş sipariş verilerine dayanarak toplam sipariş sayılarının ve ortalama harcama tutarlarının saklanması[cite: 29, 43, 191].

---

## 🗂️ Veritabanı Tablo Yapıları (DDL)

[cite_start]Tasarladığım mimari, normalizasyon standartlarına uygun olarak şu 6 temel tablodan oluşmaktadır[cite: 34]:

* [cite_start]**`Musteri`**: Kullanıcı profil, e-posta (UNIQUE) ve güvenlik verilerini saklar[cite: 37].
* [cite_start]**`Adres`**: Müşteriye bağlı adresleri tutar (`Musteri_ID` ile 1-N ilişkili, `ON DELETE CASCADE`)[cite: 26, 63].
* [cite_start]**`Kampanya`**: İndirim oranlarını, benzersiz kupon kodlarını ve geçerlilik sürelerini yönetir[cite: 28, 42].
* [cite_start]**`Siparis`**: Sipariş durumunu, tarihini ve varsa uygulanan kampanyayı tutar (`ON DELETE SET NULL`)[cite: 27, 40].
* [cite_start]**`Odeme`**: Siparişlere ait finansal işlem numaralarını ve ödeme durumlarını saklar[cite: 27, 41].
* [cite_start]**`Analiz`**: Müşterinin alışveriş istatistiklerini barındırır[cite: 29, 43].

---

## 📂 Proje Dosya Yapısı

* **`schema.sql`**: Sadece kendi sorumluluğumda olan tabloların, veri tiplerinin (`ENUM`, `DECIMAL`), birincil (PK) ve yabancı (FK) anahtar ilişkilerinin kurulduğu SQL kodları.
* [cite_start]**`data.sql`**: İlişkisel bütünlüğü ve iş kurallarını (negatif tutar girilememesi, tarih kontrolleri vb.) test etmek amacıyla hazırlanmış gerçekçi örnek veri kayıtları[cite: 50, 60].
* **`queries.sql`**: Tasarladığım tablolar arasında veri tutarlılığını doğrulamak ve platform yöneticilerine rapor sunmak için hazırladığım spesifik sorgular:
  * **Sorgu 1 (Sipariş & Adres Analizi):** `INNER JOIN` ve `LEFT JOIN` kullanarak siparişlerin hangi müşteri tarafından hangi adrese gönderildiğini ve kullanılan kupon kodlarını listeler.
  * **Sorgu 2 (Başarılı Ödemeler Raporu):** Finansal verileri süzerek yalnızca durumu "Başarılı" olan ödemeleri, işlemi gerçekleştiren müşterinin adı ve ödeme yöntemiyle birlikte raporlar.

---

## 🛠️ Kurulum ve Test

Projeyi kendi yerel SQL ortamınızda (MySQL Workbench, phpMyAdmin vb.) test etmek için:
1. Önce `schema.sql` dosyasını çalıştırarak tabloları ve ilişkileri oluşturun.
2. Ardından ilişkisel bütünlüğün korunması adına `data.sql` dosyasındaki verileri sırasıyla içeri aktarın.
3. Son olarak `queries.sql` dosyasındaki analiz sorgularını çalıştırarak ilişkisel yapının çıktısını gözlemleyebilirsiniz.
