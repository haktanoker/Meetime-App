import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeon/core/project_classes.dart';
import 'package:comeon/core/project_utilitys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'login_page.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final Future<String?> _selectedAvatar = UserDataProvider().getResim();
  final Future<String?> _userName = UserDataProvider().getName();
  final Future<String?> _userAge = UserDataProvider().getYas();
  final Future<String?> _userGender = UserDataProvider().getCinsiyet();
  final Future<String?> _userCity = UserDataProvider().getSehir();
  final storage = const FlutterSecureStorage();
  late String userName;
  Future<void> fetchUserName() async {
    final fetchedName = await UserDataProvider().getName();
    setState(() {
      userName = fetchedName ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  String? userId;

  Future<String> _fetchUserId() async {
    userId = await storage.read(key: 'user_id');
    return userId!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.Bgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: ProjectPaddings().pagePadding,
            child: Column(
              children: [
// Avatar
                FutureBuilder<String?>(
                  future: _selectedAvatar,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: ProjectColors.White,
                      );
                    }
                    if (snapshot.hasData) {
                      return Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: ProjectColors.DarkBlue,
                          child: Image.asset(
                            snapshot.data ??
                                'assets/images/avatarlar/avatar1.png',
                            fit: BoxFit.fitHeight,
                            width: 90,
                            height: 90,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: ProjectColors.White,
                          child: const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                  },
                ),
                sizedBoxCreator(context, 0.015),
// Kullanıcı Adı
                UserDataText(
                  userDataFuture: _userName,
                  notFoundText: 'Kullanıcı adı bulunamadı',
                ),
                sizedBoxCreator(context, 0.005),
// Kullanıcı Yaş ve Cinsiyeti
                UserAgeGender(),
                sizedBoxCreator(context, 0.005),
// Kullanıcı Şehri
                UserDataText(
                  userDataFuture: _userCity,
                  notFoundText: 'Kullanıcı şehri bulunamadı',
                  fontSize: 16,
                ),
                sizedBoxCreator(context, 0.04),
                Divider(height: 2, color: ProjectColors.DarkBlue),
                sizedBoxCreator(context, 0.04),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textCreater(
                        text: 'Yayındaki İlanlar',
                        fontSize: 24,
                        textColor: ProjectColors.DarkBlue,
                      ),
                      sizedBoxCreator(context, 0.02),
                    ],
                  ),
                ),
                FutureBuilder<String>(
                  future: _fetchUserId(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: ProjectColors.White,
                      );
                    }
                    if (snapshot.hasError) {
                      return const textCreater(
                          text: 'Veriler alınırken bir hata oluştu',
                          fontSize: 16);
                    }
                    if (snapshot.hasData) {
                      final userId = snapshot.data!;

                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('posts')
                            .where('ownerId', isEqualTo: userId)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(
                                color: ProjectColors.DarkBlue);
                          }
                          if (snapshot.hasError) {
                            return textCreater(
                              text: 'Veriler alınırken bir hata oluştu',
                              fontSize: 16,
                              textColor: ProjectColors.DarkBlue,
                            );
                          }
                          if (snapshot.hasData) {
                            final posts = snapshot.data!.docs;
                            if (posts.isEmpty) {
                              // Kullanıcının ilanı yoksa
                              return Center(
                                child: textCreater(
                                  text: 'Aktif İlan Bulunamadı',
                                  fontSize: 18,
                                  textColor: ProjectColors.DarkBlue,
                                ),
                              );
                            }
                            return Column(
                              children: [
                                for (var post in posts)
                                  _profilePost(
                                    title: post['postName'],
                                    description: post['postDescription'],
                                    category: post['postCategory'],
                                  ),
                              ],
                            );
                          }
                          return Container();
                        },
                      );
                    }
                    return Container();
                  },
                ),
// Çıkış Yapma Butonu
                sizedBoxCreator(context, 0.05),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ProjectColors.DarkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                  onPressed: () async {
                    // Storage'daki tüm kayıtları temizle
                    await storage.deleteAll();
                    // LoginPage'e yönlendir
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      sayfaDegistir(
                        builder: (context) => const loginPage(),
                        beginOffset: 3.0,
                      ),
                    );
                  },
                  child: const Text('Çıkış Yap'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Kullanıcı yaş ve cinsiyeti
  FutureBuilder<String?> UserAgeGender() {
    return FutureBuilder<String?>(
      future: _userAge,
      builder: (context, ageSnapshot) {
        if (ageSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: ProjectColors.DarkBlue,
          );
        }
        if (ageSnapshot.hasData) {
          return FutureBuilder<String?>(
            future: _userGender,
            builder: (context, genderSnapshot) {
              if (genderSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  color: ProjectColors.DarkBlue,
                );
              }
              if (genderSnapshot.hasData) {
                final age = ageSnapshot.data ?? 'Veri yok';
                final gender = genderSnapshot.data ?? 'Veri yok';
                return textCreater(
                  text: '$age / $gender',
                  fontSize: 16,
                  textColor: ProjectColors.DarkBlue,
                );
              } else {
                return textCreater(
                  text: 'Cinsiyet verisi bulunamadı',
                  fontSize: 16,
                  textColor: ProjectColors.DarkBlue,
                );
              }
            },
          );
        } else {
          return const textCreater(text: 'Yaş verisi bulunamadı', fontSize: 16);
        }
      },
    );
  }
}

// Kullanıcı verilerini çekme
class UserDataProvider {
  final storage = const FlutterSecureStorage();

  Future<String?> getUserId() async {
    return await storage.read(key: 'user_id');
  }

  Future<String?> getName() async {
    return await storage.read(key: 'name');
  }

  Future<String?> getpassword() async {
    return await storage.read(key: 'password');
  }

  Future<String?> getCinsiyet() async {
    return await storage.read(key: 'cinsiyet');
  }

  Future<String?> getSehir() async {
    return await storage.read(key: 'sehir');
  }

  Future<String?> getYas() async {
    return await storage.read(key: 'yas');
  }

  Future<String?> getResim() async {
    return await storage.read(key: 'resim');
  }

  Future<String?> getEmail() async {
    return await storage.read(key: 'email');
  }
}

// Kullanıcının adını veya şehrini çekme widgeti
class UserDataText extends StatelessWidget {
  final Future<String?> userDataFuture;
  final String notFoundText;
  final double fontSize;

  const UserDataText({
    Key? key,
    required this.userDataFuture,
    required this.notFoundText,
    this.fontSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: userDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: ProjectColors.DarkBlue,
          );
        }
        if (snapshot.hasData) {
          return textCreater(
            text: snapshot.data!,
            fontSize: fontSize,
            textColor: ProjectColors.DarkBlue,
          );
        } else {
          return textCreater(
            text: notFoundText,
            fontSize: fontSize,
            textColor: ProjectColors.DarkBlue,
          );
        }
      },
    );
  }
}

// Kullanıcının aktif ilanlarını çağırma
class _profilePost extends StatelessWidget {
  const _profilePost({
    required this.title,
    required this.description,
    required this.category,
    super.key,
  });
  final String title;
  final String description;
  final String category;
  @override
  Widget build(BuildContext context) {
    final Color categoryColor =
        categoryColors[category] ?? ProjectColors.postBg;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: ProjectPaddings().postPadding,
      decoration: BoxDecoration(
        color: categoryColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textCreater(text: title, fontSize: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.3,
              child: Container(
                color: ProjectColors.White,
              ),
            ),
          ),
          textCreater(
            text: description,
            fontSize: 16,
            textColor: ProjectColors.White,
            textHeight: 1.4,
          ),
        ],
      ),
    );
  }
}
