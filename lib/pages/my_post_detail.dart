import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeon/pages/home_router_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/project_classes.dart';
import '../core/project_utilitys.dart';

class myPostDetail extends StatefulWidget {
  const myPostDetail({super.key});

  @override
  State<myPostDetail> createState() => _myPostDetailState();
}

class _myPostDetailState extends State<myPostDetail> {
  final storage = const FlutterSecureStorage();
  String? mpPostId;

  Future<String> _fetchUserId() async {
    mpPostId = await storage.read(key: 'mpPostId');
    return mpPostId!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.Bgcolor,
      appBar: AppBar(
        backgroundColor: ProjectColors.DarkBlue,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Başvuranlar',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: ProjectPaddings().pagePadding,
            child: Column(
              children: [
// Kullanıcının Bilgilerinin Geldiği Yer Başlangıç
                const _UserInfo(),
// Kullanıcının Bilgilerinin Geldiği Yer Bitiş

                Divider(height: 2, color: ProjectColors.DarkBlue),
                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
// Aktif İlanlar Yazısı
                      textCreater(
                        text: 'Başvurular',
                        fontSize: 24,
                        textColor: ProjectColors.DarkBlue,
                      ),
                      sizedBoxCreator(context, 0.03),
                      FutureBuilder<String>(
                        future: _fetchUserId(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Veriler alınırken bir hata oluştu');
                          }
                          if (snapshot.hasData) {
                            final userId = snapshot.data!;

                            return FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('postreq')
                                  .where('post_id', isEqualTo: userId)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator(
                                    color: ProjectColors.White,
                                  );
                                }
                                if (snapshot.hasError) {
                                  return const Text(
                                      'Veriler alınırken bir hata oluştu');
                                }
                                if (snapshot.hasData) {
                                  final applications = snapshot.data!.docs;

                                  if (applications.isEmpty) {
                                    return textCreater(
                                      text:
                                          'Maalesef herhangi bir başvuru bulunmamaktadır',
                                      fontSize: 18,
                                      textColor: ProjectColors.DarkBlue,
                                    );
                                  }

                                  return Column(
                                    children: applications.map((application) {
                                      final applicantAvatar =
                                          application['applicant_avatar'];
                                      final applicantEmail =
                                          application['applicant_email'];
                                      final applicantName =
                                          application['applicant_name'];
                                      final postComment =
                                          application['post_comment'];

                                      return _gelenBasvuru(
                                        applicantAvatar: applicantAvatar,
                                        applicantEmail: applicantEmail,
                                        applicantName: applicantName,
                                        postComment: postComment,
                                      );
                                    }).toList(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _gelenBasvuru extends StatelessWidget {
  final String applicantAvatar;
  final String applicantEmail;
  final String applicantName;
  final String postComment;

  const _gelenBasvuru({
    Key? key,
    required this.applicantAvatar,
    required this.applicantEmail,
    required this.applicantName,
    required this.postComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();

    return FutureBuilder<String?>(
      future: storage.read(key: 'mpCategory'), // mpCategory değerini oku
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Veri okunurken bir hata oluştu');
        }

        final String category = snapshot.data ?? '';
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
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: ProjectColors.White,
                    child: Image.asset(
                      applicantAvatar,
                      fit: BoxFit.fitHeight,
                      width: 45,
                      height: 45,
                    ),
                  ),
                  sizedBoxCreator(context, 0, width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textCreater(
                        text: applicantName,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 5),
                      textCreater(
                        text: applicantEmail,
                        fontSize: 16,
                      ),
                    ],
                  )
                ],
              ),
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
                text: postComment,
                fontSize: 16,
                textColor: ProjectColors.White,
                textHeight: 1.4,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({
    super.key,
  });

  Future<String?> _readValue(String key) async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: key);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _readValue('mpTitle'),
        _readValue('mpDescription'),
        _readValue('mpPostId'),
      ]),
      builder: (context, AsyncSnapshot<List<String?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: ProjectColors.DarkBlue,
          );
        }
        if (snapshot.hasError) {
          return const Text('Veriler alınırken bir hata oluştu');
        }
        final List<String?> data = snapshot.data ?? [];
        final String? mpTitle = data[0];
        final String? mpDescription = data[1];
        final String? mpPostId = data[2];

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textCreater(
                text: mpTitle ?? 'Post Başlığı',
                fontSize: 20,
                textColor: ProjectColors.DarkBlue,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Container(
                    color: ProjectColors.DarkBlue,
                  ),
                ),
              ),
              textCreater(
                text: mpDescription ?? 'Post Açıklaması',
                fontSize: 16,
                textColor: ProjectColors.DarkBlue,
                textHeight: 1.4,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  textCreater(
                    text: 'Eğer çalışma arkadaşını bulduysan',
                    fontSize: 16,
                    textColor: ProjectColors.DarkBlue,
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final FirebaseFirestore firestore =
                          FirebaseFirestore.instance;

                      // posts koleksiyonundan silme işlemi
                      QuerySnapshot postsSnapshot =
                          await firestore.collection('posts').get();
                      for (QueryDocumentSnapshot postDoc
                          in postsSnapshot.docs) {
                        if (postDoc['post_id'] == mpPostId) {
                          await postDoc.reference.delete();
                        }
                      }

                      // postreq koleksiyonundan silme işlemi
                      QuerySnapshot postreqSnapshot =
                          await firestore.collection('postreq').get();
                      for (QueryDocumentSnapshot postreqDoc
                          in postreqSnapshot.docs) {
                        if (postreqDoc['post_id'] == mpPostId) {
                          await postreqDoc.reference.delete();
                        }
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        sayfaDegistir(
                          builder: (context) => const homeRouterPage(),
                          beginOffset: 3.0,
                        ),
                      );
                      flutterToastCreater(context, 'İlan başarıyla kaldırıldı');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ProjectColors.White,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: ProjectColors.red),
                      ),
                    ),
                    child: textCreater(
                      text: 'İlanı Sil',
                      fontSize: 14,
                      textColor: ProjectColors.red,
                      fontWeight: FontWeight.bold,
                      textHeight: 1.3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
