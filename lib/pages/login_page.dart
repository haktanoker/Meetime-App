import 'package:comeon/core/project_utilitys.dart';
import 'package:comeon/pages/register_page.dart';
import 'package:comeon/service/auth.dart';
import 'package:flutter/material.dart';

import '../core/project_classes.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 255, 255, 255),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
// Logo Başlangıç
              Container(
                width: size.width * .5,
                child: Image.asset('assets/images/falci.png'),
              ),
// Logo Bitiş
// Karşılama Yazısı Başlangıç
              Padding(
                padding: ProjectPaddings().v15,
                child: const Text(
                  'Hoşgeldin!',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                'Hesabına erişebilmek için lütfen mail ve şifreni gir',
                style: TextStyle(
                  fontSize: 14,
                  color: ProjectColors.TextGray,
                ),
              ),
// Karşılama Yazısı Bitiş
              const sizedBoxCreater(height: .03),
// Email İnput Başlangıç
              createInput(
                  Controller: _emailController,
                  inputName: 'Email',
                  iconName: Icons.person,
                  keyboardType: TextInputType.emailAddress),
// Email İnput Bitiş
              const sizedBoxCreater(height: .02),
// Şifre İnput Başlangıç
              createInput(
                  Controller: _passwordController,
                  inputName: 'Şifre',
                  iconName: Icons.lock_open_outlined,
                  sifreGizle: true),
// Şifre İnput Bitiş
// Şifremi Unuttum Başlangıç
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10.0, 20.0, 15.0),
                child: Container(
                  width: size.width * .9,
                  child: Text('Şifremi Unuttum', textAlign: TextAlign.end),
                ),
              ),
// Şifremi Unuttum Bitiş
// Giriş Butonu Başlangıç
              InkWell(
                onTap: () {
                  // _authService
                  //     .signIn(_emailController.text, _passwordController.text)
                  //     .then((value) {
                    // return Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => registerPage()));
                  // });
                },
                child: ElevatedButton(
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
                  onPressed: () {},
                  child: const Text(
                    'Giriş Yap',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
// Giriş Butonu Bitiş
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
// Kayıt Ol Yazısı Başlangıç
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Henüz kayıtlı değil misin?'),
                  const SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 750),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  registerPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = Offset(3.0, 0.0);
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
                    child: Text(
                      'Kayıt Ol',
                      style: TextStyle(
                        color: ProjectColors.MainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
// Kayıt Ol Yazısı Bitiş
            ],
          ),
        ),
      ),
    );
  }
}
