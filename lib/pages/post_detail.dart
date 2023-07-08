import 'package:flutter/material.dart';

import '../core/project_classes.dart';
import '../core/project_utilitys.dart';

class postDetail extends StatefulWidget {
  const postDetail({super.key});

  @override
  State<postDetail> createState() => _postDetailState();
}

class _postDetailState extends State<postDetail> {
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

                Divider(height: 1, color: ProjectColors.White),
                const SizedBox(height: 25),
// Kullanıcıyla İletişime Geçme Bölümü Başlangıç
                Container(
                  width: double.infinity,
                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const textCreater(
                          text: 'İlana Başvur',
                          fontSize: 26,
                        ),
                      ),
                      sizedBoxCreator(context, 0.02),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CreateInput(
                          controller: _postDetail,
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
                          backgroundColor: ProjectColors.White,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 35),
                          elevation: 4.0,
                          shadowColor:
                              ProjectColors.DarkMainColor.withOpacity(0.4),
                        ),
                        onPressed: () {},
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: ProjectPaddings().postPadding,
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
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: ProjectColors.White,
                      child: Image.asset(
                        'assets/images/avatarlar/avatar1.png',
                        fit: BoxFit.fitHeight,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    sizedBoxCreator(context, 0, width: 8),
                    const textCreater(
                      text: 'Haktan Öker',
                      fontSize: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
