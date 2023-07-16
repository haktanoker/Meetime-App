// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

// Proje Renkleri
class ProjectColors {
  static Color DarkBlue = const Color(0xFF2271CC);
  static Color passiveFilter = const Color(0xFF0C4484);
  static Color Bgcolor = const Color(0xF7FFFFFF);
  static Color White = const Color(0xFFFFFFFF);
  static Color TextGray = const Color(0x88000000);
  static Color DarkMainColor = const Color(0xFFFFFFFF);
  static Color Black = const Color(0xFF000000);
  static Color PassiveIcon = const Color(0xFFC8C8C8);
  static Color bottomBg = const Color(0xFF336CDA);
  static Color postBg = const Color(0xFF4378DE);
  static Color red = const Color(0xFFB00000);
}

// Sık Kullanılan Paddingler
class ProjectPaddings {
  final v15 = const EdgeInsets.symmetric(vertical: 15);
  final a5 = const EdgeInsets.all(5.0);
  final a10 = const EdgeInsets.all(10.0);
  final h6 = const EdgeInsets.symmetric(horizontal: 6);
  final pagePadding = const EdgeInsets.all(20);
  final postPadding = const EdgeInsets.all(15);
}

// İlan Kategori Listesi
List<String> categorys = [
  'Yazılım',
  'Kişisel Gelişim',
  'Kitap',
  'Kahve',
  'Etkinlik',
  'Yabancı Dil',
  'Spor',
  'Sanat',
  'Sohbet',
  'Oyun',
];

// Avatarların listesi
List<String> avatars = [
  'assets/images/avatarlar/avatar1.png',
  'assets/images/avatarlar/avatar2.png',
  'assets/images/avatarlar/avatar3.png',
  'assets/images/avatarlar/avatar4.png',
  'assets/images/avatarlar/avatar5.png',
  'assets/images/avatarlar/avatar6.png',
  'assets/images/avatarlar/avatar7.png',
  'assets/images/avatarlar/avatar8.png',
  'assets/images/avatarlar/avatar9.png',
  'assets/images/avatarlar/avatar10.png',
];

// Kayıt kısmı için şehir listesi
List<String> cityList = [
  'Adana',
  'Adıyaman',
  'Afyonkarahisar',
  'Ağrı',
  'Aksaray',
  'Amasya',
  'Ankara',
  'Antalya',
  'Ardahan',
  'Artvin',
  'Aydın',
  'Balıkesir',
  'Bartın',
  'Batman',
  'Bayburt',
  'Bilecik',
  'Bingöl',
  'Bitlis',
  'Bolu',
  'Burdur',
  'Bursa',
  'Çanakkale',
  'Çankırı',
  'Çorum',
  'Denizli',
  'Diyarbakır',
  'Düzce',
  'Edirne',
  'Elazığ',
  'Erzincan',
  'Erzurum',
  'Eskişehir',
  'Gaziantep',
  'Giresun',
  'Gümüşhane',
  'Hakkâri',
  'Hatay',
  'Iğdır',
  'Isparta',
  'İstanbul',
  'İzmir',
  'Kahramanmaraş',
  'Karabük',
  'Karaman',
  'Kars',
  'Kastamonu',
  'Kayseri',
  'Kırıkkale',
  'Kırklareli',
  'Kırşehir',
  'Kilis',
  'Kocaeli',
  'Konya',
  'Kütahya',
  'Malatya',
  'Manisa',
  'Mardin',
  'Mersin',
  'Muğla',
  'Muş',
  'Nevşehir',
  'Niğde',
  'Ordu',
  'Osmaniye',
  'Rize',
  'Sakarya',
  'Samsun',
  'Şanlıurfa',
  'Siirt',
  'Sinop',
  'Sivas',
  'Şırnak',
  'Tekirdağ',
  'Tokat',
  'Trabzon',
  'Tunceli',
  'Uşak',
  'Van',
  'Yalova',
  'Yozgat',
  'Zonguldak',
];

// Kategori renkleri
Map<String, Color> categoryColors = {
  'Yazılım': const Color(0xFF76C8F4),
  'Kişisel Gelişim': const Color(0xFFD6A699),
  'Kitap': const Color(0xFFFD9D8F),
  'Kahve': const Color(0xFFD8AD6D),
  'Etkinlik': const Color(0xFF77D0B7),
  'Yabancı Dil': const Color(0xFFA685E2),
  'Spor': const Color(0xFF86A491),
  'Sanat': const Color(0xFFFABA5B),
  'Sohbet': const Color(0xFFDBBE8C),
  'Oyun': const Color(0xFFBB9ED1),
};
