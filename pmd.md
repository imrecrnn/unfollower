# insfollow Projesi

## Proje Özeti
Bu proje, Flutter ile geliştirilmiş çok platformlu bir uygulamadır. Android, iOS, web ve masaüstü platformlarını destekler. Instagram API'si ile entegrasyon, kullanıcı kimlik doğrulama ve çeşitli sosyal medya işlemleri sunar.

## Kurulum
1. Gerekli bağımlılıkları yükleyin:
   ```sh
   flutter pub get
   ```
2. Android için:
   - Android Studio ile gerekli SDK ve NDK'nın kurulu olduğundan emin olun.
   - Gerekirse `android/app/build.gradle.kts` dosyasındaki `ndkVersion` değerini kontrol edin.
3. iOS için:
   - Xcode ve gerekli iOS araçlarının kurulu olduğundan emin olun.
   - `cd ios && pod install` komutunu çalıştırın.
4. Uygulamayı başlatmak için:
   ```sh
   flutter run
   ```

## Kullanılan Ana Paketler
- `app_links`: Derin link ve uygulama bağlantıları için.
- `flutter_web_auth_2`: Web tabanlı kimlik doğrulama işlemleri için.
- `flutter_secure_storage`: Güvenli veri saklama için.
- `url_launcher`: Harici bağlantı açmak için.
- `webview_flutter`: Uygulama içi web görünümleri için.

## Önemli Notlar
- Android için NDK sürümü uyumluluğuna dikkat edin. Gerekirse SDK Manager'dan güncelleyin.
- Eski `uni_links` paketi kaldırılmıştır, yerine `app_links` kullanılmaktadır.
- Paketlerin güncel sürümlerini kullanmak için zaman zaman `flutter pub upgrade` komutunu çalıştırabilirsiniz.

## Desteklenen Platformlar
- Android
- iOS
- Web
- macOS
- Windows
- Linux

---
Daha fazla bilgi için `README.md` dosyasına göz atabilirsiniz. 


 


## Gereksinimler ve Yapılacaklar Listesi (Yayınlanan Bir InstaFollow Uygulaması İçin)

### Temel Özellikler
1. **Kullanıcı kimlik doğrulama (Instagram OAuth ile giriş)**
   - Kullanıcılar Instagram hesaplarıyla güvenli şekilde giriş yapabilmeli.
2. **Kullanıcı profil bilgilerini çekme ve görüntüleme**
   - Giriş yapan kullanıcının profil fotoğrafı, adı, kullanıcı adı ve biyografisi gösterilmeli.
3. **Takipçi ve takip edilen listelerini görüntüleme**
   - Kullanıcı, takipçilerini ve takip ettiklerini ayrı ayrı görebilmeli.
4. **Takipçi kazanma/kaybetme analizleri ve geçmişi**
   - Kullanıcı, son günlerde/haftalarda kazandığı ve kaybettiği takipçileri görebilmeli.
5. **Kullanıcıya bildirim gönderme (push notification)**
   - Takipçi değişiklikleri, önemli güncellemeler veya promosyonlar için bildirim desteği olmalı.
6. **Çoklu platform desteği (Android, iOS, Web, masaüstü)**
   - Uygulama tüm ana platformlarda sorunsuz çalışmalı.
7. **Karanlık/aydınlık tema desteği**
   - Kullanıcılar tema tercihini değiştirebilmeli.
8. **Kullanıcı gizlilik politikası ve veri silme talepleri için arayüz**
   - Kullanıcılar gizlilik politikasını görebilmeli ve veri silme talebinde bulunabilmeli.
9. **Uygulama içi satın alma ve premium özellikler**
   - Ekstra analizler veya reklamsız kullanım için premium seçenekler sunulmalı.
10. **Instagram API limit ve hata yönetimi**
    - API limitleri aşıldığında veya hata oluştuğunda kullanıcıya bilgilendirici mesajlar gösterilmeli.
11. **Kullanıcıya uygulama içi yardım ve destek bölümü**
    - SSS, iletişim ve destek talepleri için bir bölüm olmalı.
12. **Uygulama performans ve hata izleme (crash reporting, analytics)**
    - Hatalar ve performans sorunları merkezi olarak izlenmeli.
13. **Çoklu dil desteği (en az İngilizce ve Türkçe)**
    - Uygulama birden fazla dili desteklemeli.
14. **Güncel uygulama mağazası gereksinimlerine (Google Play, App Store) uyumluluk**
    - Tüm mağaza politikalarına ve teknik gereksinimlere uygunluk sağlanmalı.
15. **Kullanıcıdan izinler (kamera, bildirim, internet vb.) için doğru yönetim**
    - Gerekli izinler kullanıcıya açıkça sorulmalı ve yönetilmeli.

---
Her bir gereksinim, uygulamanın sürdürülebilir, güvenli ve kullanıcı dostu olmasını sağlamak için gereklidir. Geliştirme sürecinde bu gereksinimler adım adım tamamlanmalıdır. 