import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeon/core/project_classes.dart';
import 'package:comeon/core/project_utilitys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class profileVisit extends StatefulWidget {
  const profileVisit({super.key});

  @override
  State<profileVisit> createState() => _profileVisitState();
}

class _profileVisitState extends State<profileVisit> {
  final storage = FlutterSecureStorage();
  String avatarUrl = 'assets/images/avatarlar/avatar1.png';
  String userName = 'Kullanıcı İsmi';
  String userAgeGender = 'Yaş / Cinsiyet';
  String userCity = 'Kullanıcı Şehri';

  Future<void> fetchUserData() async {
    final cpPostOwnerId = await storage.read(key: 'cpPostOwnerId');
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    final userData = snapshot.docs
        .firstWhere((doc) => doc['user_id'] == cpPostOwnerId)
        .data();

    setState(() {
      avatarUrl = userData['resim'];
      userName = userData['name'];
      userAgeGender = '${userData['yas']} / ${userData['cinsiyet']}';
      userCity = userData['sehir'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  String? userId;

  Future<String> _fetchUserId() async {
    userId = await storage.read(key: 'cpPostOwnerId');
    return userId!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.DarkBlue,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Profil Ziyareti',
          style: TextStyle(
            fontSize: 22,
            color: ProjectColors.White,
            fontWeight: FontWeight.normal,
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
      backgroundColor: ProjectColors.Bgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: ProjectPaddings().pagePadding,
            child: Column(
              children: [
                // Avatar
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: ProjectColors.DarkBlue,
                    child: Image.asset(
                      avatarUrl,
                      fit: BoxFit.fitHeight,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                sizedBoxCreator(context, 0.015),
                // Kullanıcı Adı
                textCreater(
                  text: userName,
                  fontSize: 30,
                  textColor: ProjectColors.DarkBlue,
                ),
                sizedBoxCreator(context, 0.005),
                // Kullanıcı Yaş ve Cinsiyeti
                textCreater(
                  text: userAgeGender,
                  fontSize: 16,
                  textColor: ProjectColors.DarkBlue,
                ),
                sizedBoxCreator(context, 0.005),
                // Kullanıcı Şehri
                textCreater(
                  text: userCity,
                  fontSize: 16,
                  textColor: ProjectColors.DarkBlue,
                ),
                sizedBoxCreator(context, 0.04),
                Divider(height: 1, color: ProjectColors.DarkBlue),
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
// İlanları Firestore'dan Çekme
                FutureBuilder<String>(
                  future: _fetchUserId(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: ProjectColors.DarkBlue,
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
                            return const textCreater(
                                text: 'Veriler alınırken bir hata oluştu',
                                fontSize: 16);
                          }
                          if (snapshot.hasData) {
                            final posts = snapshot.data!.docs;
                            if (posts.isEmpty) {
                              // Kullanıcının ilanı yoksa
                              return const Center(
                                child: textCreater(
                                  text: 'Aktif İlan Bulunamadı',
                                  fontSize: 18,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// İlan Oluşturma
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
