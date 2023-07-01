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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
              SizedBox(
                width: size.width * .5,
                child: Image.asset('assets/images/logo_name.png'),
              ),
// Logo Bitiş
              sizedBoxCreator(context, 0.1),
// Logo Altındaki Yazı Başlangıç
              Text(
                'Hesabına erişebilmek için lütfen mail ve şifreni gir',
                style: TextStyle(
                  fontSize: 14,
                  color: ProjectColors.TextGray,
                ),
              ),
// Logo Altındaki Yazı Bitiş
              sizedBoxCreator(context, 0.03),
// Email İnput Başlangıç
              createInput(
                  Controller: _emailController,
                  inputName: 'Email',
                  iconName: Icons.person,
                  keyboardType: TextInputType.emailAddress),
// Email İnput Bitiş
// Şifre İnput Başlangıç
              createInput(
                  Controller: _passwordController,
                  inputName: 'Şifre',
                  iconName: Icons.lock_open_outlined,
                  sifreGizle: true),
// Şifre İnput Bitiş
// Şifremi Unuttum Başlangıç
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 10.0, 20.0, 15.0),
              //   child: Container(
              //     width: size.width * .9,
              //     child: Text('Şifremi Unuttum', textAlign: TextAlign.end),
              //   ),
              // ),
// Şifremi Unuttum Bitiş
// Giriş Butonu Başlangıç
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ProjectColors.DarkMainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  elevation: 4.0,
                  shadowColor: ProjectColors.MainColor.withOpacity(0.4),
                ),
                onPressed: () {
                  if (_emailController.text == '' ||
                      _passwordController.text == '') {
                    flutterToastCreater(
                      context,
                      'Lütfen bilgilerinizi eksiksiz girin',
                    );
                  } else {
                    AuthService().signIn(
                      context: context,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  }
                },
                child: const Text(
                  'Giriş Yap',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
// Giriş Butonu Bitiş
// Google ile Giriş Butonu Başlangıç
              sizedBoxCreator(context, 0.05),
              InkWell(
                onTap: () {
                  // AuthService().signInWithGoogle();
                },
                child: Container(
                  color: ProjectColors.DarkMainColor,
                  child: Padding(
                    padding: ProjectPaddings().a5,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: ProjectColors.White,
                          child: Padding(
                            padding: ProjectPaddings().a10,
                            child: Image.asset(
                              'assets/images/google_icon.png',
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                        sizedBoxCreator(context, 0, width: 10),
                        Text(
                          'Google ile bağlan',
                          style: TextStyle(
                            fontSize: 18,
                            color: ProjectColors.White,
                          ),
                        ),
                        sizedBoxCreator(context, 0, width: 10),
                      ],
                    ),
                  ),
                ),
              ),
              sizedBoxCreator(context, 0.05),
// Google ile Giriş Butonu Bitiş
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
                          transitionDuration: Duration(milliseconds: 1250),
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
