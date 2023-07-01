import 'package:comeon/core/project_utilitys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Login & Register Page İnput Creater Class
class createInput extends StatelessWidget {
  const createInput({
    Key? key,
    required TextEditingController Controller,
    required this.inputName,
    required this.iconName,
    this.keyboardType,
    this.maxKarakter,
    this.sifreGizle = false,
  })  : _InputController = Controller,
        super(key: key);

  final TextEditingController _InputController;
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
            controller: _InputController,
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
        sizedBoxCreator(context, 0.03),
      ],
    );
  }
}

// Sized Box Creater Class
Widget sizedBoxCreator(BuildContext context, double height,
    {double width = 0}) {
  return SizedBox(
    height: (MediaQuery.of(context).size).width * height,
    width: width,
  );
}

// Fluttertoast Creater Class
void flutterToastCreater(BuildContext context, String msg, {int duration = 3}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: duration == 0 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    timeInSecForIosWeb: duration,
  );
}
