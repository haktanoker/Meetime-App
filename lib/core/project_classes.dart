import 'package:comeon/core/project_utilitys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Login & Register Page İnput Creater Class
class createInput extends StatelessWidget {
  const createInput({
    Key? key,
    required TextEditingController emailController,
    required this.inputName,
    required this.iconName,
    this.keyboardType,
    this.maxKarakter,
    this.sifreGizle = false,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;
  final String inputName;
  final TextInputType? keyboardType;
  final IconData iconName;
  final bool sifreGizle;
  final int? maxKarakter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: (MediaQuery.of(context).size).width * .9,
          child: TextField(
            obscureText: sifreGizle,
            controller: _emailController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxKarakter),
              FilteringTextInputFormatter.deny(RegExp('[!?"\'+-]')),
            ],
            style: TextStyle(
              color: ProjectColors.MainColor,
              fontWeight: FontWeight.bold,
            ),
            cursorColor: ProjectColors.MainColor,
            keyboardType:
                keyboardType, //TextInputType.emailAddress şeklinde tanımlanıyor
            decoration: InputDecoration(
              prefixIcon: Icon(
                iconName,
                color: ProjectColors.MainColor,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              hintText: inputName,
              prefixText: ' ',
              hintStyle: TextStyle(color: ProjectColors.TextGray),
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
        const sizedBoxCreater(height: .03),
      ],
    );
  }
}

// Sized Box Creater Class
class sizedBoxCreater extends StatelessWidget {
  const sizedBoxCreater({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size).width * height,
    );
  }
}