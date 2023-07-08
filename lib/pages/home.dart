import 'package:comeon/pages/post_detail.dart';
import 'package:flutter/material.dart';

import '../core/project_classes.dart';
import '../core/project_utilitys.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.DarkMainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: ProjectPaddings().pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const textCreater(text: 'Kategoriler', fontSize: 24),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (String category in categorys)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ProjectColors.White,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: textCreater(
                                text: category,
                                fontSize: 12,
                                textColor: ProjectColors.DarkMainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const _homePost(
                  title: 'asdadsadsa',
                  description: 'asdadasdadasd',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _homePost extends StatelessWidget {
  const _homePost({
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        sayfaDegistir(
                          builder: (context) => postDetail(),
                          beginOffset: 3.0,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ProjectColors.White,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      textCreater(
                        text: 'Detayları Gör',
                        fontSize: 16,
                        textColor: ProjectColors.DarkMainColor,
                        fontWeight: FontWeight.bold,
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: ProjectColors.DarkMainColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
