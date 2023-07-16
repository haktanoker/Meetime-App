import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/project_classes.dart';
import '../core/project_utilitys.dart';

class community extends StatefulWidget {
  const community({Key? key});

  @override
  State<community> createState() => _communityState();
}

class _communityState extends State<community> {
  bool _isLoading = true;
  List<String> cities = [];
  List<String> selectedCities = [];
  Color hexToColor(String hexString) {
    String hexColor = hexString.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    int colorValue = int.parse(hexColor, radix: 16);
    return Color(colorValue);
  }

  @override
  void initState() {
    super.initState();
    getCitiesFromFirestore();
  }

  Future<void> getCitiesFromFirestore() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('community').get();
      final List<String> allCities =
          snapshot.docs.map<String>((doc) => doc['city'] as String).toList();
      cities = allCities.toSet().toList();

      await Future.delayed(const Duration(seconds: 0));

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
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
          'Topluluk Etkinlikleri',
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
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: ProjectColors.DarkBlue,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFilterButtons(),
                      const SizedBox(height: 10),
                      _buildCommunityPosts(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cities.map((city) {
              final bool isSelected = selectedCities.contains(city);

              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isSelected) {
                      selectedCities.remove(city);
                    } else {
                      selectedCities.add(city);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSelected ? ProjectColors.postBg : ProjectColors.White,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: ProjectColors.DarkBlue,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: textCreater(
                  text: city,
                  fontSize: 12,
                  textColor:
                      isSelected ? ProjectColors.White : ProjectColors.DarkBlue,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityPosts() {
    final Stream<QuerySnapshot> communityStream =
        FirebaseFirestore.instance.collection('community').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: communityStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final communityPosts = snapshot.data!.docs;

          final filteredPosts = selectedCities.isEmpty
              ? communityPosts
              : communityPosts
                  .where((post) => selectedCities.contains(post['city']))
                  .toList();

          return Column(
            children: filteredPosts.map<Widget>((post) {
              return _communityPost(
                baslik: post['title'] ?? '',
                tarih: post['date'] ?? '',
                fotograf: post['photo'] ?? '',
                aciklama: post['description'] ?? '',
                renk: post['color'] ?? '',
              );
            }).toList(),
          );
        }

        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
        }

        return const SizedBox();
      },
    );
  }

  Widget _communityPost({
    required String baslik,
    required String tarih,
    required String fotograf,
    required String aciklama,
    required String renk,
  }) {
    return Column(
      children: [
        Container(
          width: (MediaQuery.of(context).size).width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                baslik,
                style: TextStyle(
                  fontSize: 26,
                  color: hexToColor(renk),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              textCreater(
                text: tarih,
                fontSize: 16,
                textColor: hexToColor(renk),
              ),
              sizedBoxCreator(context, 0.01),
              Container(
                width: (MediaQuery.of(context).size).width * .8,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/topluluk/$fotograf',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size).width * .8,
                padding: ProjectPaddings().postPadding,
                decoration: BoxDecoration(
                  color: hexToColor(renk),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: textCreater(
                  text: aciklama,
                  fontSize: 18,
                  textColor: ProjectColors.White,
                  textHeight: 1.4,
                ),
              ),
            ],
          ),
        ),
        sizedBoxCreator(context, 0.05),
      ],
    );
  }
}
