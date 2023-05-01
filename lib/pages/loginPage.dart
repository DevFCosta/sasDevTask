import 'package:flutter/material.dart';
import 'package:house_rules/components/my_logo.dart';
import 'package:house_rules/components/my_text_field.dart';
import 'package:house_rules/components/my_text_field_pass.dart';
import 'package:house_rules/pages/mainPage.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo

                const AppLogo(
                  size: 100,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  inputLength: 15,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextFieldPassword(
                  controller: passwordController,
                  hintText: 'Password',
                  inputLength: 15,
                ),

                const SizedBox(height: 5),
                ElevatedButton(
                    onPressed: () {
                      signUserIn();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff45424),
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUserIn() async {
    if (emailController.text == 'searchandstay' &&
        passwordController.text == 'SearchAndStay') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyMainPage()),
      );
    }
  }
}
