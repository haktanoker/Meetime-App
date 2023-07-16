import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeon/core/project_classes.dart';
import 'package:comeon/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/project_utilitys.dart';
import 'home_router_page.dart';

class createPost extends StatefulWidget {
  const createPost({super.key});

  @override
  State<createPost> createState() => _createPostState();
}

class _createPostState extends State<createPost> {
  final _postTitle = TextEditingController();
  final _postDescription = TextEditingController();
  String? _selectedCategory;

  late final FlutterSecureStorage storage;
  final userCollection = FirebaseFirestore.instance.collection("users");
  final postCollection = FirebaseFirestore.instance.collection("posts");

  @override
  void initState() {
    super.initState();
    storage = const FlutterSecureStorage();
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
          'İlan Oluştur',
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
            padding: ProjectPaddings().pagePadding,
            child: Center(
              child: Column(
                // Başlık İnputu
                children: [
                  CreateInput(
                    controller: _postTitle,
                    inputName: 'İlan Başlığı',
                    hintText: 'İlan konusu hakkında kısa bir özet...',
                    maxKarakter: 60,
                  ),
                  sizedBoxCreator(context, 0.02),
                  // Açıklama İnputu
                  CreateInput(
                    controller: _postDescription,
                    inputName: 'İlan Açıklaması',
                    hintText: 'İlan hakkında eklemek istediğiniz detaylar...',
                    maxKarakter: 300,
                    maxLine: 5,
                  ),
                  sizedBoxCreator(context, 0.02),
                  // Kategori Seçme
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textCreater(
                            text: 'İlan Kategorisi',
                            fontSize: 18,
                            textColor: ProjectColors.DarkBlue,
                          ),
                          const SizedBox(height: 2),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: ProjectColors.White,
                              child: DropdownButton<String>(
                                value: _selectedCategory,
                                iconEnabledColor: ProjectColors.DarkBlue,
                                iconDisabledColor: ProjectColors.DarkBlue,
                                underline: Container(
                                  height: 1,
                                  color: ProjectColors.DarkBlue,
                                ),
                                hint: const Text(
                                  'Kategori',
                                ),
                                items: categorys.map((String category) {
                                  return DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(category),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedCategory = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
// Gönderme Butonu
                  sizedBoxCreator(context, 0.1),
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
                      if (_postTitle.text == '' ||
                          _postDescription == '' ||
                          _selectedCategory == null) {
                        flutterToastCreater(
                            context, 'Lütfen tüm alanları eksiksiz doldurun');
                        return;
                      } else {
                        const storage = FlutterSecureStorage();

                        final userId = await storage.read(key: 'user_id');
                        final name = await storage.read(key: 'name');
                        final resim = await storage.read(key: 'resim');
                        // ignore: use_build_context_synchronously
                        AuthService().sharePost(
                          context: context,
                          ownerName: name.toString(),
                          ownerAvatar: resim.toString(),
                          ownerId: userId.toString(),
                          postCategory: _selectedCategory.toString(),
                          postDescription: _postDescription.text,
                          postName: _postTitle.text,
                        );
                        setState(() {});
                        _postTitle.text = '';
                        _postDescription.text = '';
                        _selectedCategory = null;
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          sayfaDegistir(
                            builder: (context) => const homeRouterPage(),
                            beginOffset: -3.0,
                          ),
                        );
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
          ),
        ),
      ),
    );
  }
}
