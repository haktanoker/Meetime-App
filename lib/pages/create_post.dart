import 'package:comeon/core/project_classes.dart';
import 'package:flutter/material.dart';

import '../core/project_utilitys.dart';

class createPost extends StatefulWidget {
  const createPost({super.key});

  @override
  State<createPost> createState() => _createPostState();
}

class _createPostState extends State<createPost> {
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
          'İlan Oluştur',
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
                // Başlık İnputu
                children: [
                  CreateInput(
                    controller: _postTitle,
                    inputName: 'İlan Başlığı',
                    hintText: 'A2 İngilizce için speaking arkadaşı arıyorum...',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textCreater(
                          text: 'İlan Kategorisi',
                          fontSize: 18,
                          textColor: ProjectColors.White,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            color: ProjectColors.White,
                            child: DropdownButton<String>(
                              value: _selectedCategory,
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
                  // Gönderme Butonu
                  sizedBoxCreator(context, 0.1),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ProjectColors.White,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 35),
                      elevation: 4.0,
                      shadowColor: ProjectColors.DarkMainColor.withOpacity(0.4),
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
          ),
        ),
      ),
    );
  }
}
