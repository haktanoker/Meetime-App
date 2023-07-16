import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeon/pages/home_router_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/project_classes.dart';
import '../core/project_utilitys.dart';

class postDetail extends StatefulWidget {
  const postDetail({super.key});

  @override
  State<postDetail> createState() => _postDetailState();
}

class _postDetailState extends State<postDetail> {
  final _requestDetail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.Bgcolor,
      appBar: AppBar(
        backgroundColor: ProjectColors.DarkBlue,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'İlan Detayları',
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
                _UserInfo(),
// Kullanıcının Bilgilerinin Geldiği Yer Bitiş

                Divider(height: 1, color: ProjectColors.DarkBlue),
                const SizedBox(height: 25),
// Kullanıcıyla İletişime Geçme Bölümü Başlangıç
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: textCreater(
                          text: 'İlana Başvur',
                          fontSize: 26,
                          textColor: ProjectColors.DarkBlue,
                        ),
                      ),
                      sizedBoxCreator(context, 0.02),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CreateInput(
                          controller: _requestDetail,
                          inputName: 'Mesaj',
                          hintText: 'Bu mesaj ilan sahibine gösterilecektir',
                          maxKarakter: 300,
                          maxLine: 6,
                        ),
                      ),
// Yayınla Butonu
                      sizedBoxCreator(context, 0.05),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ProjectColors.DarkBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 35),
                          elevation: 4.0,
                          shadowColor: ProjectColors.DarkBlue.withOpacity(0.4),
                        ),
                        onPressed: () async {
                          if (_requestDetail.text == '') {
                            flutterToastCreater(context,
                                'Lütfen tüm alanları eksiksiz doldurun');
                            return;
                          } else {
                            final storage = FlutterSecureStorage();

                            final cpPostOwnerId =
                                await storage.read(key: 'cpPostOwnerId');
                            final cpTitle = await storage.read(key: 'cpTitle');
                            final cpDescription =
                                await storage.read(key: 'cpDescription');
                            final cpPostId =
                                await storage.read(key: 'cpPostId');
                            final userId = await storage.read(key: 'user_id');
                            final name = await storage.read(key: 'name');
                            final email = await storage.read(key: 'email');
                            final resim = await storage.read(key: 'resim');
                            try {
                              await FirebaseFirestore.instance
                                  .collection('postreq')
                                  .add({
                                'post_owner_id': cpPostOwnerId,
                                'post_title': cpTitle,
                                'post_description': cpDescription,
                                'post_id': cpPostId,
                                'post_comment': _requestDetail.text,
                                'applicant_id': userId,
                                'applicant_name': name,
                                'applicant_email': email,
                                'applicant_avatar': resim,
                              });

                              // ignore: use_build_context_synchronously
                              flutterToastCreater(
                                  context, 'İlana istek gönderildi');
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  sayfaDegistir(
                                    builder: (context) =>
                                        const homeRouterPage(),
                                    beginOffset: -3.0,
                                  ));
                            } catch (e) {
                              // ignore: use_build_context_synchronously
                              flutterToastCreater(
                                  context, 'Bir hatayla karşılaştık');
                            }
                          }
                        },
                        child: Text(
                          'Yayınla',
                          style: TextStyle(
                            color: ProjectColors.DarkMainColor,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
// Kullanıcıyla İletişime Geçme Bölümü Bitiş
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({
    Key? key,
  }) : super(key: key);

  Future<String?> _readValue(String key) async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: key);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _readValue('cpTitle'),
        _readValue('cpDescription'),
        _readValue('cpOwnerName'),
        _readValue('cpAvatar'),
      ]),
      builder: (context, AsyncSnapshot<List<String?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: ProjectColors.DarkBlue,
          );
        }
        if (snapshot.hasError) {
          return Text('Veriler alınırken bir hata oluştu');
        }
        final List<String?> data = snapshot.data ?? [];
        final String? cpTitle = data[0];
        final String? cpDescription = data[1];
        final String? cpOwnerName = data[2];
        final String? cpAvatar = data[3];

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 15),
          padding: ProjectPaddings().postPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textCreater(
                text: cpTitle ?? 'postTitle',
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
                text: cpDescription ?? 'postDescription',
                fontSize: 16,
                textColor: ProjectColors.DarkBlue,
                textHeight: 1.4,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: ProjectColors.DarkBlue,
                          child: Image.asset(
                            cpAvatar ?? 'assets/images/avatarlar/avatar1.png',
                            fit: BoxFit.fitHeight,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        sizedBoxCreator(context, 0, width: 8),
                        textCreater(
                          text: cpOwnerName ?? 'ownerName',
                          fontSize: 16,
                          textColor: ProjectColors.DarkBlue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
