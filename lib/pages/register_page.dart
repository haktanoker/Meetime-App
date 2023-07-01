import 'package:comeon/core/project_utilitys.dart';
import 'package:comeon/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../core/project_classes.dart';
import '../service/auth.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final TextEditingController _againpasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedGender;
  String? _selectedCity;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 255, 255, 255),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
// Geri Dönüş Butonu ve Hesap Oluştur Yazısı Başlangıç
                Stack(
                  children: [
// Geri Dönüş Butonu Başlangıç
                    Positioned(
                      left: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1250),
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  loginPage(), // Geçiş yapılacak hedef sayfanın adı
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = Offset(-3.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: const CircleBorder(),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 9.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
// Hesap Oluştur Yazısı Başlangıç
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Hesap Oluştur',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Katılmak için lütfen bilgilerini gir',
                            style: TextStyle(
                              fontSize: 14,
                              color: ProjectColors.TextGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
// Geri Dönüş Butonu ve Hesap Oluştur Yazısı Bitiş
                sizedBoxCreator(context, 0.07),
// İnputlar Başlangıç
                // Fotoğraf Ekle
                GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/user_icon.png'),
                        backgroundColor: ProjectColors.DarkMainColor,
                      ),
                      Positioned(
                        bottom: -13,
                        right: -13,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBoxCreator(context, 0.04),
                // Ad Soyad
                createInput(
                  Controller: _nameController,
                  inputName: 'Ad Soyad',
                  iconName: Icons.person,
                  keyboardType: TextInputType.name,
                  maxKarakter: 30,
                ),
                // Email
                createInput(
                  Controller: _emailController,
                  inputName: 'Email',
                  iconName: Icons.mail_outline_outlined,
                  keyboardType: TextInputType.emailAddress,
                  maxKarakter: 40,
                ),
                // Şifre
                createInput(
                  Controller: _passwordController,
                  inputName: 'Şifre',
                  iconName: Icons.lock_open_outlined,
                  sifreGizle: true,
                  maxKarakter: 20,
                ),
                // Şifre Yeniden
                createInput(
                  Controller: _againpasswordController,
                  inputName: 'Şifre Yeniden',
                  iconName: Icons.lock_open_outlined,
                  sifreGizle: true,
                  maxKarakter: 20,
                ),
                // Telefon
                createInput(
                  Controller: _phoneController,
                  inputName: 'Telefon (5xxxxxxxxx)',
                  iconName: Icons.phone_android_outlined,
                  keyboardType: TextInputType.phone,
                  maxKarakter: 10,
                ),
                // Cinsiyet ve Şehir Seçimi Başlangıç
                Container(
                  width: size.width * .8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cinsiyet Seçimi Başlangıç
                      Container(
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<String>(
                          value: _selectedGender,
                          hint: Text('Cinsiyet'),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedGender = newValue;
                            });
                          },
                          items: <String>['Erkek', 'Kadın']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      // Cinsiyet Seçimi Bitiş
                      // Şehir Seçimi Başlangıç
                      Container(
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<String>(
                          value: _selectedCity,
                          hint: Text('Şehir'),
                          items: cityList.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCity = newValue;
                            });
                          },
                        ),
                      ),
                      // Şehir Seçimi Bitiş
                    ],
                  ),
                ),
                // Cinsiyet ve Şehir Seçimi Bitiş
// İnputlar Bitiş
                sizedBoxCreator(context, 0.05),
// Kayıt Ol Butonu Başlangıç
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ProjectColors.DarkMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    elevation: 4.0,
                    shadowColor: ProjectColors.MainColor.withOpacity(0.4),
                  ),
                  onPressed: () {
                    inputControls(context);
                  },
                  child: const Text(
                    'Kayıt Ol',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
// Kayıt Ol Butonu Bitiş
              ],
            ),
          ),
        ),
      ),
    );
  }

// İnput Kontrol Şartları
  void inputControls(BuildContext context) {
    if (_nameController.text == '' ||
        _emailController.text == '' ||
        _passwordController.text == '' ||
        _againpasswordController.text == '' ||
        _phoneController.text == '' ||
        _selectedGender == null ||
        _selectedCity == null) {
      flutterToastCreater(context, 'Lütfen bilgilerinizi eksiksiz girin');
    }
    if (_passwordController.text != _againpasswordController.text) {
      flutterToastCreater(context, 'Şifreler eşleşmiyor');
    }
    if (_phoneController.text.replaceAll(' ', '').length != 10) {
      flutterToastCreater(context, 'Numaranız 10 haneli olmalıdır');
    } else {
      AuthService().signUp(
        context: context,
        name: _nameController.text,
        email: _emailController.text.replaceAll(' ', ''),
        password: _passwordController.text,
        cinsiyet: _selectedGender.toString(),
        sehir: _selectedCity.toString(),
      );
      flutterToastCreater(context, 'Kayıt başarılı');
    }
  }
}
