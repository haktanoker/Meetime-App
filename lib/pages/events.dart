import 'dart:ui';
import 'package:comeon/pages/community.dart';
import 'package:flutter/material.dart';
import '../core/project_utilitys.dart';

class events extends StatefulWidget {
  const events({Key? key});

  @override
  State<events> createState() => _eventsState();
}

class _eventsState extends State<events> {
  bool _isLoading = true;
  late List<bool> _imageLoadedStatus;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    await Future.delayed(const Duration(seconds: 0));
    _imageLoadedStatus = List.generate(5, (_) => true);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.DarkBlue,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Topluluk',
          style: TextStyle(
            fontSize: 26,
            color: ProjectColors.White,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(-10),
          child: Container(
            color: ProjectColors.White,
            height: 2,
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CustomEventWidget(
                      image: 'assets/images/events/konser.jpg',
                      description: 'Birbirinden Eğlenceli Konserler',
                      color: Color.fromRGBO(15, 51, 113, 0.6),
                      offset: 3.0,
                    ),
                    SizedBox(height: 10),
                    _CustomEventWidget(
                      image: 'assets/images/events/açık_hava.jpg',
                      description: 'Açık Hava Etkinlikleri',
                      color: Color.fromRGBO(61, 126, 63, 0.6),
                      offset: -3.0,
                    ),
                    SizedBox(height: 10),
                    _CustomEventWidget(
                      image: 'assets/images/events/müze.jpg',
                      description: 'Sanat Gezileri',
                      color: Color.fromRGBO(183, 107, 82, 0.6),
                      offset: 3.0,
                    ),
                    SizedBox(height: 10),
                    _CustomEventWidget(
                      image: 'assets/images/events/topluluk.jpg',
                      description: 'Topluluk Buluşmaları',
                      color: Color.fromRGBO(167, 110, 10, 0.6),
                      offset: -3.0,
                    ),
                    SizedBox(height: 10),
                    _CustomEventWidget(
                      image: 'assets/images/events/kütüphane.jpg',
                      description: 'Kitap Okuma Etkinlikleri',
                      color: Color.fromRGBO(121, 85, 72, 0.6),
                      offset: 3.0,
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: size.width * .80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Stack(
                            children: [
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.srcOver,
                                ),
                                child: Image.asset(
                                  'assets/images/events/tıkla.png',
                                  fit: BoxFit.cover,
                                  // loadingBuilder:
                                  //     (context, child, loadingProgress) {
                                  //   if (loadingProgress == null) return child;
                                  //   return Center(
                                  //     child: CircularProgressIndicator(
                                  //       color: Colors.blue,
                                  //     ),
                                  //   );
                                  // },
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(5),
                                    color: Color.fromRGBO(201, 59, 78, 0.6),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const community(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Bu Ayın Etkinlikleri İçin TIKLA',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontFamily: 'Monsterrat',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _CustomEventWidget extends StatefulWidget {
  const _CustomEventWidget({
    required this.image,
    required this.description,
    required this.color,
    required this.offset,
    Key? key,
  }) : super(key: key);

  final String image;
  final String description;
  final Color color;
  final double offset;

  @override
  State<_CustomEventWidget> createState() => _CustomEventWidgetState();
}

class _CustomEventWidgetState extends State<_CustomEventWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(widget.offset, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SlideTransition(
      position: _slideAnimation,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: size.width * .80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Stack(
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.srcOver,
                  ),
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      color: widget.color,
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 20,
                          color: ProjectColors.White,
                          fontFamily: 'Monsterrat',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
