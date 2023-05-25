import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  buildBody() {
    // final height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create an account',
            style: kLogin,
          ),
          const SizedBox(height: 16),
          const Text(
            "Let's get started",
            style: kLoginSubtitle,
          ),
          const SizedBox(height: 30),
          textFieldLogin('Name', nameController),
          const SizedBox(height: 16),
          textFieldLogin('Email', emailController),
          const SizedBox(height: 16),
          textFieldLogin('Password', passwordController),
          const SizedBox(height: 30),
          btnRegister(),
          const SizedBox(
            height: 16,
          ),
          btnGoogle(),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                  text: 'Already have an account? ',
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: 'Sign in here',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const LoginPage()));
                          })
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox btnRegister() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        ),
        child: const Text(
          'Sign up',
          style: kLoginButton,
        ),
      ),
    );
  }

  btnGoogle() {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.grey[400],
      child: SizedBox(
        height: 55,
        child: TextButton(
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
              const Text("Sign up with Google",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  TextField textFieldLogin(title, controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: title,
        focusColor: Colors.grey,
        hoverColor: Colors.grey,
        fillColor: Colors.red,
        hintStyle: kHintText,
      ),
    );
  }
}
