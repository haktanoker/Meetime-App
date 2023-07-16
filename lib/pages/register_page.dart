import 'package:comeon/core/project_utilitys.dart';
import 'package:comeon/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  final _againpasswordController = TextEditingController();
  String? _selectedGender;
  String? _selectedCity;
  String _selectedAvatar = 'assets/images/user_icon.png';
  final TextEditingController _birthdateController = TextEditingController();

  int selectedAvatarIndex = 0; // Başlangıçta seçili avatarın indeksi
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(250, 255, 255, 255),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                            sayfaDegistir(
                                builder: (context) => loginPage(),
                                beginOffset: -3.0),
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
                sizedBoxCreator(context, 0.05),
// İnputlar Başlangıç
                // Seçilen Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundColor: ProjectColors.White,
                  child: Image.asset(
                    _selectedAvatar,
                    fit: BoxFit.fitHeight,
                    width: 80,
                    height: 80,
                  ),
                ),
                sizedBoxCreator(context, 0.02),
                // Listelenen Avatarlar
                Container(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: avatars.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAvatarIndex = index;
                            _selectedAvatar = avatars[selectedAvatarIndex];
                          });
                        },
                        child: Padding(
                          padding: ProjectPaddings().h6,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: ProjectColors.White,
                            child: Image.asset(
                              avatars[index],
                              fit: BoxFit.fitHeight,
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                sizedBoxCreator(context, 0.02),
                // Ad Soyad
                signInput(
                  Controller: _nameController,
                  inputName: 'Ad Soyad',
                  iconName: Icons.person,
                  keyboardType: TextInputType.name,
                  maxKarakter: 30,
                ),
                // Email
                signInput(
                  Controller: _emailController,
                  inputName: 'Email',
                  iconName: Icons.mail_outline_outlined,
                  keyboardType: TextInputType.emailAddress,
                  maxKarakter: 40,
                ),
                // Şifre
                signInput(
                  Controller: _passwordController,
                  inputName: 'Şifre',
                  iconName: Icons.lock_open_outlined,
                  sifreGizle: true,
                  maxKarakter: 20,
                ),
                // Şifre Yeniden
                signInput(
                  Controller: _againpasswordController,
                  inputName: 'Şifre Yeniden',
                  iconName: Icons.lock_open_outlined,
                  sifreGizle: true,
                  maxKarakter: 20,
                ),
                // Cinsiyet, Şehir ve Doğum Tarihi Seçimi Başlangıç
                Container(
                  width: size.width * .8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                sizedBoxCreator(context, 0.02),
                // Doğum Tarihi Seçimi Başlangıç
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  width: 150,
                  child: TextFormField(
                    controller: _birthdateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Doğum Tarihi',
                      prefixIcon: Icon(
                        Icons.calendar_today,
                      ),
                      contentPadding: EdgeInsets.only(bottom: -35),
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                                  primary: ProjectColors.DarkBlue),
                              buttonTheme: ButtonThemeData(
                                  textTheme: ButtonTextTheme.primary),
                            ),
                            child: child!,
                          );
                        },
                      ).then(
                        (selectedDate) {
                          if (selectedDate != null) {
                            setState(
                              () {
                                _birthdateController.text =
                                    '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}';
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                // Doğum Tarihi Seçimi Bitiş

                // Cinsiyet, Şehir ve Doğum Tarihi Seçimi Bitiş
// İnputlar Bitiş
                sizedBoxCreator(context, 0.05),
// Kayıt Ol Butonu Başlangıç
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ProjectColors.DarkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    elevation: 4.0,
                    shadowColor: ProjectColors.DarkBlue.withOpacity(0.4),
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
// Google ile Giriş Butonu Başlangıç
                sizedBoxCreator(context, 0.05),
                InkWell(
                  onTap: () async {
                    await _googleGetInfo();
                  },
                  child: Container(
                    color: ProjectColors.DarkBlue,
                    child: Padding(
                      padding: ProjectPaddings().a5,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            color: ProjectColors.White,
                            child: Padding(
                              padding: ProjectPaddings().a5,
                              child: Image.asset(
                                'assets/images/google_icon.png',
                                width: 15,
                                height: 15,
                              ),
                            ),
                          ),
                          sizedBoxCreator(context, 0, width: 10),
                          Text(
                            'Google ile bağlan',
                            style: TextStyle(
                              fontSize: 16,
                              color: ProjectColors.White,
                            ),
                          ),
                          sizedBoxCreator(context, 0, width: 5),
                        ],
                      ),
                    ),
                  ),
                ),
// Google ile Giriş Butonu Bitiş
              ],
            ),
          ),
        ),
      ),
    );
  }

// Butona tıklanıldığında google hesabında oturum açan ve bilgileri getiren kod bloğu
  Future<void> _googleGetInfo() async {
    final googleSignIn = GoogleSignIn();
    // Açık olan hesabı kapatan kod bloğu
    if (googleSignIn.currentUser == null) {
      await googleSignIn.signOut();
    }
    final account = await googleSignIn.signIn();
    // Hesaba giriş yapılmasını sağlayan ve inputları dolduran kod
    if (account != null) {
      setState(() {
        _nameController.text = account.displayName ?? '';
        _emailController.text = account.email;
      });
    }
  }

// İnput Kontrol Şartları
  void inputControls(BuildContext context) {
    if (_nameController.text == '' ||
        _emailController.text == '' ||
        _passwordController.text == '' ||
        _againpasswordController.text == '' ||
        _selectedGender == null ||
        _selectedCity == null ||
        _selectedAvatar == 'assets/images/user_icon.png' ||
        _birthdateController.text == '') {
      flutterToastCreater(context, 'Lütfen bilgilerinizi eksiksiz girin');
      return;
    }
    if (_passwordController.text != _againpasswordController.text) {
      flutterToastCreater(context, 'Şifreler eşleşmiyor');
      return;
    } else {
      AuthService().signUp(
        context: context,
        name: _nameController.text,
        email: _emailController.text.replaceAll(' ', ''),
        password: _passwordController.text,
        cinsiyet: _selectedGender.toString(),
        sehir: _selectedCity.toString(),
        avatar: _selectedAvatar,
        dogumTarihi: DateTime.now().year -
            (int.parse(_birthdateController.text.substring(0, 4))),
      );
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1250),
          pageBuilder: (context, animation, secondaryAnimation) =>
              loginPage(), // Geçiş yapılacak hedef sayfanın adı
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(-3.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    }
  }
}
