import 'package:comeon/core/project_utilitys.dart';
import 'package:comeon/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../core/project_classes.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _againpasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? selectedGender;
  String? selectedCity;

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
// Geri Dönüş Butonu Başlangıç
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 750),
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                loginPage(), // Geçiş yapılacak hedef sayfanın adını buraya yazın
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
                  ],
                ),
// Geri Dönüş Butonu Bitiş
// Hesap Oluştur Yazıları Başlangıç
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
// Hesap Oluştur Yazıları Bitiş
                const sizedBoxCreater(height: 0.05),
// İnputlar Başlangıç
                // Ad Soyad
                createInput(
                  emailController: _nameController,
                  inputName: 'Ad Soyad',
                  iconName: Icons.person,
                  keyboardType: TextInputType.name,
                  maxKarakter: 30,
                ),
                // Email
                createInput(
                  emailController: _emailController,
                  inputName: 'Email',
                  iconName: Icons.mail_outline_outlined,
                  keyboardType: TextInputType.emailAddress,
                  maxKarakter: 40,
                ),
                // Şifre
                createInput(
                  emailController: _passwordController,
                  inputName: 'Şifre',
                  iconName: Icons.lock_open_outlined,
                  sifreGizle: true,
                  maxKarakter: 20,
                ),
                // Şifre Yeniden
                createInput(
                  emailController: _againpasswordController,
                  inputName: 'Şifre Yeniden',
                  iconName: Icons.lock_open_outlined,
                  sifreGizle: true,
                  maxKarakter: 20,
                ),
                // Telefon
                createInput(
                  emailController: _phoneController,
                  inputName: 'Telefon (5xx xxx xxxx)',
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
                          value: selectedGender,
                          hint: Text('Cinsiyet'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGender = newValue;
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
                          value: selectedCity,
                          hint: Text('Şehir'),
                          items: cityList.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCity = newValue;
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
                const sizedBoxCreater(height: 0.05),
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
                    // Butona tıklanınca gerçekleşecek işlemler
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Ya da',
                    style: TextStyle(
                      fontSize: 14,
                      color: ProjectColors.TextGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
