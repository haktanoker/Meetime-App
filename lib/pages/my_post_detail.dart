import 'package:flutter/material.dart';

import '../core/project_classes.dart';
import '../core/project_utilitys.dart';

class myPostDetail extends StatefulWidget {
  const myPostDetail({super.key});

  @override
  State<myPostDetail> createState() => _myPostDetailState();
}

class _myPostDetailState extends State<myPostDetail> {
  final _postDetail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.DarkMainColor,
      appBar: AppBar(
        backgroundColor: ProjectColors.DarkMainColor,
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
                _UserInfo(),
// Kullanıcının Bilgilerinin Geldiği Yer Bitiş

                Divider(height: 1, color: ProjectColors.White),
                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
// Aktif İlanlar Yazısı
                      const textCreater(text: 'Aktif İlanlar', fontSize: 24),
// Aktif İlanlar Altındaki Çizgi
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          height: 1,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Container(
                            color: ProjectColors.White,
                          ),
                        ),
                      ),
                      _gelenBasvuru(title: 'asdasd', description: 'adsadsa'),
                      _gelenBasvuru(title: 'asdasd', description: 'adsadsa'),
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

class _UserInfo extends StatelessWidget {
  const _UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const textCreater(
            text: 'asdasdasdasdasd',
            fontSize: 20,
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
            text: 'asdasd sadadaasdasfsdgsdf adsfasdasdf dsfasas dfads',
            fontSize: 16,
            textColor: ProjectColors.White,
            textHeight: 1.4,
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const textCreater(
                text: 'Eğer çalışma arkadaşını bulduysan',
                fontSize: 16,
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ProjectColors.White,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const textCreater(
                  text: 'İlanı Sil',
                  fontSize: 14,
                  textColor: Colors.red,
                  fontWeight: FontWeight.bold,
                  textHeight: 1.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _gelenBasvuru extends StatelessWidget {
  const _gelenBasvuru({
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
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: ProjectColors.White,
                child: Image.asset(
                  'assets/images/avatarlar/avatar1.png',
                  fit: BoxFit.fitHeight,
                  width: 45,
                  height: 45,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textCreater(
                      text: 'Haktan Öker',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  SizedBox(height: 5),
                  textCreater(text: 'okerhaktan@gmail.com', fontSize: 16),
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
