// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeon/core/project_classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import '../pages/home_router_page.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final postCollection = FirebaseFirestore.instance.collection("posts");
  final postreqCollection = FirebaseFirestore.instance.collection("postreq");
  final firebaseAuth = FirebaseAuth.instance;

// Kayıt Ol Başlangıç
  Future<void> signUp(
      {required BuildContext context,
      required String name,
      required String email,
      required String password,
      required String cinsiyet,
      required String sehir,
      required int dogumTarihi,
      required String avatar}) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        _registerUser(
          context: context,
          name: name,
          email: email,
          password: password,
          cinsiyet: cinsiyet,
          sehir: sehir,
          dogumTarihi: dogumTarihi,
          avatar: avatar,
        );
        return;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        flutterToastCreater(context, 'Bu mail adresi zaten kullanılıyor');
        return;
      }
    }
  }

// Bilgileri DB'ye kaydetmek
  Future<void> _registerUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String cinsiyet,
    required String sehir,
    required int dogumTarihi,
    required String avatar,
  }) async {
    String uuid = Uuid().v4(); // UUID oluşturma
    await userCollection.doc().set({
      'name': name,
      'email': email,
      'password': password,
      'cinsiyet': cinsiyet,
      'sehir': sehir,
      'user_id': uuid,
      'yas': dogumTarihi,
      'resim': avatar,
    });
    flutterToastCreater(context, 'Kayıt başarıyla oluşturuldu!');
  }
  // Kayıt Ol Bitiş

// Post Paylaşma
  Future<void> sharePost({
    required BuildContext context,
    required String ownerName,
    required String ownerAvatar,
    required String ownerId,
    required String postCategory,
    required String postDescription,
    required String postName,
  }) async {
    String postUuid = const Uuid().v4(); // UUID oluşturma
    await postCollection.doc().set({
      'ownerName': ownerName,
      'ownerAvatar': ownerAvatar,
      'ownerId': ownerId,
      'postCategory': postCategory,
      'postDescription': postDescription,
      'post_id': postUuid,
      'postName': postName,
    });
    flutterToastCreater(context, 'Post paylaşıldı!');
  }

// Giriş Yap Başlangıç
  final storage = const FlutterSecureStorage();

  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Kullanıcının verilerini Firestore'dan çekme işlemi
        final QuerySnapshot snapshot =
            await userCollection.where('email', isEqualTo: email).get();

        if (snapshot.docs.isNotEmpty) {
          final Map<String, dynamic>? userData =
              snapshot.docs[0].data() as Map<String, dynamic>?;
          if (userData != null) {
            final userId = userData['user_id'];

            // Kullanıcının diğer bilgilerini de alıp depolama
            final name = userData['name'];
            final cinsiyet = userData['cinsiyet'];
            final sehir = userData['sehir'];
            final yas = userData['yas'];
            final resim = userData['resim'];
            final email = userData['email'];
            final password = userData['password'];

            await storage.write(key: 'user_id', value: userId);
            await storage.write(key: 'name', value: name);
            await storage.write(key: 'cinsiyet', value: cinsiyet);
            await storage.write(key: 'sehir', value: sehir);
            await storage.write(key: 'yas', value: yas.toString());
            await storage.write(key: 'resim', value: resim);
            await storage.write(key: 'email', value: email);
            await storage.write(key: 'password', value: password);

            Navigator.pushAndRemoveUntil(
              context,
              sayfaDegistir(
                builder: (context) => const homeRouterPage(),
                beginOffset: 3.0,
              ),
              (Route<dynamic> route) => false,
            );
            flutterToastCreater(context, 'Giriş Başarılı');
          } else {
            print('Kullanıcı verileri bulunamadı');
          }
        } else {
          print('Kullanıcı bulunamadı');
        }
      } else {
        flutterToastCreater(context, 'Kullanıcı bulunamadı');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        flutterToastCreater(context, 'Kullanıcı adı veya şifreniz yanlış');
      }
    }
  }
}

        // Navigator.pushAndRemoveUntil(
        //   context,
        //   sayfaDegistir(
        //     builder: (context) => const loginPage(),
        //     beginOffset: 0.0,
        //   ),
        //   (Route<dynamic> route) => false,
        // );