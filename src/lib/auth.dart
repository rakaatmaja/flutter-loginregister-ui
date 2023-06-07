import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'toast.dart';

class Auth {
  Future<void> register(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'name': name,
        'email': email,
        // Tambahkan data tambahan sesuai kebutuhan Anda
      });
      toast('BerhasilDaftar');
    } catch (e) {
      toast('Gagal mendaftar');
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ignore: unused_local_variable
      User? user = userCredential.user;
      toast('Berhasil masuk!');
      return true;
    } catch (e) {
      toast('Email atau password salah!');
      return false;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
