import 'package:comeon/core/project_utilitys.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              Container(
                width: size.width * .5,
                child: Image.asset('assets/images/falci.png'),
              ),
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
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: size.width * .9,
                child: TextField(
                  controller: _emailController,
                  style: TextStyle(
                    color: ProjectColors.MainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  cursorColor: ProjectColors.MainColor,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: ProjectColors.MainColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: 'Email',
                    prefixText: ' ',
                    hintStyle: TextStyle(color: ProjectColors.TextGray),
                    // focusColor: Colors.red,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: ProjectColors.MainColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                width: size.width * .9,
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  style: TextStyle(
                    color: ProjectColors.MainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  cursorColor: ProjectColors.MainColor,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      color: ProjectColors.MainColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: 'Şifre',
                    prefixText: ' ',
                    hintStyle: TextStyle(color: ProjectColors.TextGray),
                    // focusColor: Colors.red,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: ProjectColors.MainColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10.0, 20.0, 15.0),
                child: Container(
                  width: size.width * .9,
                  child: Text('Şifremi Unuttum', textAlign: TextAlign.end),
                ),
              ),
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
                  // Butona tıklanınca gerçekleşecek işlemler
                },
                child: const Text(
                  'Giriş Yap',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
