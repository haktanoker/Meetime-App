import 'package:comeon/core/project_utilitys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Login & Register Page İnput Creater Class
class signInput extends StatelessWidget {
  const signInput({
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
              color: ProjectColors.DarkBlue,
              fontWeight: FontWeight.bold,
            ),
            cursorColor: ProjectColors.DarkBlue,
            keyboardType:
                keyboardType, //TextInputType.emailAddress şeklinde tanımlanıyor
            decoration: InputDecoration(
              prefixIcon: Icon(
                iconName,
                color: ProjectColors.DarkBlue,
              ),
              filled: true,
              fillColor: ProjectColors.White,
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
                  color: ProjectColors.DarkBlue,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(color: ProjectColors.White),
              ),
            ),
          ),
        ),
        sizedBoxCreator(context, 0.03),
      ],
    );
  }
}

// Uygulama içi İnput Creater Class
class CreateInput extends StatefulWidget {
  const CreateInput({
    Key? key,
    required TextEditingController controller,
    required this.inputName,
    this.maxKarakter,
    this.maxLine,
    this.hintText,
  })  : _inputController = controller,
        super(key: key);

  final TextEditingController _inputController;
  final String inputName;
  final int? maxKarakter;
  final int? maxLine;
  final String? hintText;

  @override
  State<CreateInput> createState() => _CreateInputState();
}

class _CreateInputState extends State<CreateInput> {
  int characterCount = 0;

  @override
  void initState() {
    super.initState();
    widget._inputController.addListener(updateCharacterCount);
  }

  @override
  void dispose() {
    widget._inputController.removeListener(updateCharacterCount);
    super.dispose();
  }

  void updateCharacterCount() {
    setState(() {
      characterCount = widget._inputController.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.inputName,
                style: TextStyle(fontSize: 18, color: ProjectColors.DarkBlue),
              ),
              Text(
                '${widget._inputController.text.length}/${widget.maxKarakter ?? 0}',
                style: TextStyle(fontSize: 12, color: ProjectColors.DarkBlue),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: widget._inputController,
            maxLines: widget.maxLine,
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxKarakter),
              FilteringTextInputFormatter.deny(RegExp('[!?"+-]')),
              // FilteringTextInputFormatter.deny(RegExp('[!?"\'+-]')),
            ],
            style: TextStyle(
              color: ProjectColors.Black,
            ),
            cursorColor: ProjectColors.DarkBlue,
            decoration: InputDecoration(
              contentPadding: ProjectPaddings().a5,
              border: InputBorder.none,
              filled: true,
              fillColor: ProjectColors.White,
              hintText: widget.hintText,
              prefixText: ' ',
              hintStyle: TextStyle(color: ProjectColors.TextGray),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: BorderSide(
                  color: ProjectColors.DarkBlue,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: BorderSide(
                  color: ProjectColors.DarkBlue,
                  width: 2.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
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

// Sayfa Değiştirme Animasyonu
// Sağdan sola (beginOffset ilk değer 3.0) veya soldan sağa (beginOffset ilk değer -3.0)
class sayfaDegistir<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final double beginOffset;
  final int durationMilliseconds;

  sayfaDegistir({
    required this.builder,
    required this.beginOffset,
    this.durationMilliseconds = 1250,
  }) : super(
          settings: RouteSettings(),
          fullscreenDialog: false,
        );

  @override
  bool get opaque => true;

  @override
  bool get barrierDismissible => false;

  @override
  Duration get transitionDuration =>
      Duration(milliseconds: durationMilliseconds);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var tween = Tween(begin: Offset(beginOffset, 0.0), end: Offset.zero)
        .chain(CurveTween(curve: Curves.ease));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;
}

// Yazı Oluşturma
class textCreater extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? textColor;
  final FontWeight fontWeight;
  final double? textHeight;

  const textCreater({
    Key? key,
    required this.text,
    required this.fontSize,
    this.textHeight,
    this.textColor,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor ?? ProjectColors.White,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: textHeight,
      ),
    );
  }
}

// Belirlenen karakter sayısından uzun yazıların sonunda 3 nokta koyma
String yaziyiKes(String name, int maxLength) {
  if (name.length <= maxLength) {
    return name;
  } else {
    return '${name.substring(0, maxLength)}...';
  }
}
