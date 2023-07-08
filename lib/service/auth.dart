// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeon/core/project_classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
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
      'Name': name,
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

  // Giriş Yap Başlangıç
  Future<void> signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        flutterToastCreater(context, 'Giriş Başarılı');
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
