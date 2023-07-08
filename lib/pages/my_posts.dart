import 'package:comeon/core/project_classes.dart';
import 'package:comeon/pages/my_post_detail.dart';
import 'package:flutter/material.dart';
import '../core/project_utilitys.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  final _postTitle = TextEditingController();
  final _postDescription = TextEditingController();
  String? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.DarkMainColor,
      appBar: AppBar(
        backgroundColor: ProjectColors.DarkMainColor,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'İlanlarım',
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
            child: Center(
              child: Column(
                children: [
                  _detailPost(title: 'asdadas', description: 'adasdasda'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _detailPost extends StatelessWidget {
  const _detailPost({
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        sayfaDegistir(
                          builder: (context) => myPostDetail(),
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
                        text: 'Başvuruları Gör',
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
