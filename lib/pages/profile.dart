import 'package:comeon/core/project_classes.dart';
import 'package:comeon/core/project_utilitys.dart';
import 'package:flutter/material.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  String _selectedAvatar = 'assets/images/avatarlar/avatar1.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.DarkMainColor,
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
                    backgroundColor: ProjectColors.White,
                    child: Image.asset(
                      _selectedAvatar,
                      fit: BoxFit.fitHeight,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                sizedBoxCreator(context, 0.015),
// Kullanıcı Adı
                const textCreater(text: 'Haktan Öker', fontSize: 30),
                sizedBoxCreator(context, 0.005),
// Kullanıcı Yaş ve Cinsiyeti
                const textCreater(text: '22 / Erkek', fontSize: 16),
                sizedBoxCreator(context, 0.005),
// Kullanıcı Şehri
                const textCreater(text: 'Sakarya', fontSize: 16),
                sizedBoxCreator(context, 0.04),
                Divider(height: 1, color: ProjectColors.White),
                sizedBoxCreator(context, 0.04),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const textCreater(text: 'Aktif İlanlar', fontSize: 24),
                      sizedBoxCreator(context, 0.02),
                      const _profilePost(
                        title: 'İngilizce Çalışacak Arkadaş',
                        description:
                            'asdas dasdasf ds asdfasds fasdf asdafs asd a',
                      ),
                      const _profilePost(
                        title: 'İngilizce Çalışacak Arkadaş',
                        description:
                            'asdas dasdasf ds asdfasds fasdf asdafs asd a',
                      ),
                    ],
                  ),
                ),
// Aktif İlanlar Başlangıç
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
    super.key,
  });
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: ProjectPaddings().postPadding,
      decoration: BoxDecoration(
        color: ProjectColors.postBg,
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
