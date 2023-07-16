import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeon/core/project_classes.dart';
import 'package:comeon/pages/my_post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/project_utilitys.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

// Kullanıcının user_id değerini FlutterSecureStorage'dan çekme
class _MyPostsState extends State<MyPosts> {
  final storage = const FlutterSecureStorage();
  String? userId;

  Future<String> _fetchUserId() async {
    userId = await storage.read(key: 'user_id');
    return userId!;
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
                  FutureBuilder<String>(
                    future: _fetchUserId(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(
                          color: ProjectColors.DarkBlue,
                        );
                      }
                      if (snapshot.hasError) {
                        return textCreater(
                          text: 'Veriler alınırken bir hata oluştu',
                          fontSize: 16,
                          textColor: ProjectColors.DarkBlue,
                        );
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
                                    _detailPost(
                                      title: post['postName'],
                                      description: post['postDescription'],
                                      postId: post['post_id'],
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
      ),
    );
  }
}

class _detailPost extends StatelessWidget {
  const _detailPost({
    required this.title,
    required this.description,
    required this.postId,
    required this.category,
    super.key,
  });
  final String title;
  final String description;
  final String postId;
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
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final storage = FlutterSecureStorage();
                    // mp = my post
                    await storage.write(key: 'mpPostId', value: postId);
                    await storage.write(key: 'mpTitle', value: title);
                    await storage.write(
                        key: 'mpDescription', value: description);
                    await storage.write(key: 'mpCategory', value: category);
                    // ignore: use_build_context_synchronously
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
                        textColor: categoryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      Icon(Icons.arrow_forward_ios, color: categoryColor),
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
