import 'package:flutter/material.dart';
import '../core/project_classes.dart';
import '../core/project_utilitys.dart';

class community extends StatefulWidget {
  const community({super.key});

  @override
  State<community> createState() => _communityState();
}

class _communityState extends State<community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.DarkMainColor,
      appBar: AppBar(
        backgroundColor: ProjectColors.DarkMainColor,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Topluluk Fırsatları',
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
            child: const Column(
              children: [
                _communityPost(
                  baslik: 'İzmir Kıyı Cafe',
                  tarih: '1 Ağustos - 4 Ağustos',
                  fotograf: 'topluluk_kiyi_kafe.jpg',
                  aciklama:
                      '1-4 Ağustos tarihleri arasında Kıyı Cafe’nin yeni ürünü Orman Şöleni, Meetime kullanıcılarına özel %50 indirimli',
                ),
                _communityPost(
                  baslik: 'İstanbul Lavie Cafe',
                  tarih: '7 Ağustos',
                  fotograf: 'topluluk_istanbul_lavie_cafe.jpg',
                  aciklama:
                      '7 Ağustos Lavie Cafe açılışında Meetime kullanıcılarına özel, hesapta %10 indirim fırsatını kaçırma',
                ),
                _communityPost(
                    baslik: 'Parkorman Tabiat Parkı Konseri',
                    tarih: '14 Ağustos',
                    fotograf: 'topluluk_tabiat_parki.jpg',
                    aciklama:
                        'En seçkin sanatçıların bulunduğu Parkorman Tabiat Parkı konserinde birlikte eğlenmek ister misin? O zaman MEETİME kodu ile hemen %25 indirimli biletini al'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _communityPost extends StatelessWidget {
  final String baslik;
  final String tarih;
  final String fotograf;
  final String aciklama;
  const _communityPost({
    super.key,
    required this.baslik,
    required this.tarih,
    required this.fotograf,
    required this.aciklama,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: (MediaQuery.of(context).size).width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textCreater(
                text: baslik,
                fontSize: 26,
              ),
              textCreater(
                text: tarih,
                fontSize: 16,
                textColor: ProjectColors.PassiveIcon,
              ),
              sizedBoxCreator(context, 0.01),
              Container(
                width: (MediaQuery.of(context).size).width * .8,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset('assets/images/$fotograf'),
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size).width * .8,
                padding: ProjectPaddings().postPadding,
                decoration: BoxDecoration(
                  color: ProjectColors.postBg,
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
