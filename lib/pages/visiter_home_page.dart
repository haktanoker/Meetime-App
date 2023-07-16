import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeon/pages/post_detail.dart';
import 'package:comeon/pages/profil_visit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/project_classes.dart';
import '../core/project_utilitys.dart';

class visiterHomePage extends StatefulWidget {
  const visiterHomePage({Key? key}) : super(key: key);

  @override
  State<visiterHomePage> createState() => _visiterHomePageState();
}

class _visiterHomePageState extends State<visiterHomePage>
    with SingleTickerProviderStateMixin {
  final storage = FlutterSecureStorage();
  final userCollection = FirebaseFirestore.instance.collection("users");
  List<String> selectedCategories = []; // Seçili kategorilerin listesi
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: -3.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _delayedAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _delayedAnimation() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.White,
      appBar: AppBar(
        backgroundColor: ProjectColors.DarkBlue,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Ana Sayfa',
          style: TextStyle(
            fontSize: 26,
            color: ProjectColors.White,
            fontWeight: FontWeight.bold,
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
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (String category in categorys)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(
                                  () {
                                    // Kategori butonuna basıldığında seçili kategorilere ekle/çıkar
                                    if (selectedCategories.contains(category)) {
                                      selectedCategories.remove(category);
                                    } else {
                                      selectedCategories.add(category);
                                    }
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    selectedCategories.contains(category)
                                        ? categoryColors[category]
                                        : ProjectColors.DarkBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: textCreater(
                                text: category,
                                fontSize: 12,
                                textColor: selectedCategories.contains(category)
                                    ? ProjectColors.White
                                    : ProjectColors.DarkMainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection("posts").get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: ProjectColors.DarkBlue,
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('Veriler alınırken bir hata oluştu');
                    }
                    if (snapshot.hasData) {
                      final posts = snapshot.data!.docs;
                      // Seçilen kategorilere göre filtreleme yap
                      List<DocumentSnapshot> filteredPosts =
                          posts.where((post) {
                        String postCategory = post['postCategory'];
                        return selectedCategories.isEmpty ||
                            selectedCategories.contains(postCategory);
                      }).toList();
                      if (filteredPosts.isEmpty) {
                        return Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Center(
                            child: textCreater(
                              text: 'Bu kategoride ilan bulunamadı',
                              fontSize: 18,
                              textColor: ProjectColors.DarkBlue,
                            ),
                          ),
                        );
                      }

                      return AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Column(
                            children: [
                              for (var i = 0; i < filteredPosts.length; i++)
                                AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    final delay = i * 0.15;
                                    final animation = CurvedAnimation(
                                      parent: _animationController,
                                      curve: Interval(delay, 1.0),
                                    );
                                    return FadeTransition(
                                      opacity: animation,
                                      child: _homePost(
                                        title: filteredPosts[i]['postName'],
                                        description: filteredPosts[i]
                                            ['postDescription'],
                                        avatar: filteredPosts[i]['ownerAvatar'],
                                        ownerName: filteredPosts[i]
                                            ['ownerName'],
                                        postId: filteredPosts[i]['post_id'],
                                        ownerId: filteredPosts[i]['ownerId'],
                                        category: filteredPosts[i]
                                            ['postCategory'],
                                      ),
                                    );
                                  },
                                ),
                            ],
                          );
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

class _homePost extends StatelessWidget {
  const _homePost({
    required this.title,
    required this.description,
    required this.avatar,
    required this.ownerName,
    required this.postId,
    required this.ownerId,
    required this.category,
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final String avatar;
  final String ownerName;
  final String postId;
  final String ownerId;
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
          textCreater(text: yaziyiKes(title, 50), fontSize: 20),
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
            text: yaziyiKes(description, 120),
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
                        avatar,
                        fit: BoxFit.fitHeight,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        flutterToastCreater(context,
                            'Kullanıcı profilini görmek için giriş yapmalısın');
                      },
                      child: textCreater(
                        text: yaziyiKes(ownerName, 13),
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    flutterToastCreater(
                        context, 'Detayları görmek için giriş yapmalısın');
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
