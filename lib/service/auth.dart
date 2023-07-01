// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeon/core/project_classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;

// Kayıt Ol Başlangıç
  Future<void> signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String cinsiyet,
    required String sehir,
  }) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        _registerUser(
            name: name,
            email: email,
            password: password,
            cinsiyet: cinsiyet,
            sehir: sehir);
        flutterToastCreater(context, 'Kayıt başarıyla oluşturuldu!');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        flutterToastCreater(context, 'Bu mail adresi zaten kullanılıyor');
      }
    }
  }

  Future<void> _registerUser({
    required String name,
    required String email,
    required String password,
    required String cinsiyet,
    required String sehir,
  }) async {
    await userCollection.doc().set({
      'userName': name,
      'email': email,
      'password': password,
      'cinsiyet': cinsiyet,
      'sehir': sehir,
    });

    // Kayıt Ol Bitiş
  }

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

// google girişi
  // Future<User?> signInWithGoogle() async {
  //   // Oturum açma sürecini başlat
  //   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  //   // Bilgileri al
  //   final GoogleSignInAuthentication gAuth = await gUser!.authentication;
  //   // Kullanıcı nesnesini oluştur
  //   final credential = GoogleAuthProvider.credential(
  //       accessToken: gAuth.accessToken, idToken: gAuth.idToken);
  //   // Kullanıcı girişi yap
  //   final UserCredential userCredential =
  //       await firebaseAuth.signInWithCredential(credential);
  //   return userCredential.user;
  // }
}
