import 'package:comeon/core/project_utilitys.dart';
import 'package:comeon/pages/home_router_page.dart';
import 'package:comeon/pages/register_page.dart';
import 'package:comeon/service/auth.dart';
import 'package:flutter/material.dart';
import '../core/project_classes.dart';
import 'create_post.dart';

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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Başlangıç
                SizedBox(
                  width: size.width * .6,
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
                signInput(
                    Controller: _emailController,
                    inputName: 'Email',
                    iconName: Icons.person,
                    keyboardType: TextInputType.emailAddress),
                // Email İnput Bitiş
                // Şifre İnput Başlangıç
                signInput(
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

                sizedBoxCreator(context, 0.02),
// Giriş Butonu Başlangıç
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ProjectColors.DarkMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    elevation: 4.0,
                    shadowColor: ProjectColors.DarkMainColor.withOpacity(0.4),
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
                      Navigator.push(
                        context,
                        sayfaDegistir(
                            builder: (context) => const createPost(),
                            beginOffset: 3.0),
                      );
                    }
                  },
                  child: Text(
                    'Giriş Yap',
                    style: TextStyle(
                      color: ProjectColors.White,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
// Giriş Butonu Bitiş
                sizedBoxCreator(context, 0.05),
// Kayıt Ol Yazısı Başlangıç
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Henüz kayıtlı değil misin?'),
                    sizedBoxCreator(context, 0, width: 5.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          sayfaDegistir(
                              builder: (context) => registerPage(),
                              beginOffset: 3.0),
                        );
                      },
                      child: Text(
                        'Kayıt Ol',
                        style: TextStyle(
                          color: ProjectColors.DarkMainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
// Kayıt Ol Yazısı Bitiş
                SizedBox(height: 2),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      sayfaDegistir(
                          builder: (context) => const homeRouterPage(),
                          beginOffset: 3.0),
                    );
                  },
                  child: Text('Ana Sayfaları Gör'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
