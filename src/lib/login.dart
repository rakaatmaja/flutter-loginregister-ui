import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import 'register.dart';
import 'service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String? displayName;
  String? photoUrl;
  String? email;

  late SharedPreferences _prefs;

  Future<void> handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          // Simpan informasi pengguna di SharedPreferences
          _prefs = await SharedPreferences.getInstance();
          _prefs.setString('displayName', user.displayName ?? '');
          _prefs.setString('photoUrl', user.photoURL ?? '');
          _prefs.setString('email', user.email ?? '');
          // Login dengan Google berhasil, lakukan navigasi ke halaman berikutnya
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    } catch (e) {
      // Handle error
      print(e.toString());
    }
  }

  bool isLoading = false;
  final _auth = Auth();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back',
              style: kLogin,
            ),
            const SizedBox(height: 16),
            const Text(
              "Welcome back! Please enter your details.",
              style: kLoginSubtitle,
            ),
            const SizedBox(height: 16),
            textFieldLogin('Email', _emailController, validateEmail),
            const SizedBox(height: 20),
            textFieldLogin('Password', _passwordController, validatePassword),
            const SizedBox(height: 20),
            const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(fontWeight: FontWeight.w500),
                )),
            const SizedBox(height: 20),
            btnLogin(),
            const SizedBox(
              height: 16,
            ),
            btnGoogle('Sign in with Google'),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account?  ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Sign up here',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const RegisterPage()));
                        },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  btnLogin() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
                handleLogin();
              },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        child: isLoading
            ? const SpinKitFadingCircle(
                size: 50,
                color: Colors.white,
              )
            : const Text(
                'Sign in',
                style: kLoginButton,
              ),
      ),
    );
  }

  void handleLogin() async {
    setState(() {
      isLoading = true;
    });

    try {
      bool success = await _auth.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      setState(() {
        isLoading = false;
      });

      if (success) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        // ignore: use_build_context_synchronously
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (ctx) => const HomePage()),
        //     (route) => false);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  btnGoogle(String title) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      // shadowColor: Colors.grey[400],
      child: SizedBox(
        height: 55,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Fsearch%20(2).png?alt=media&token=24a918f7-3564-4290-b7e4-08ff54b3c94c",
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(title,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            ],
          ),
          onPressed: handleGoogleSignIn,
        ),
      ),
    );
  }
}
