import 'package:blooddonation/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController forgotpass = TextEditingController();
  String show = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.cyan.shade200,
              Colors.cyan.shade800,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'RESET PASSWORD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(),
                if (show.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    show,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      show = "";
                    });

                    if (forgotpass.text.isEmpty) {
                      setState(() {
                        show = "Please enter your email address.";
                      });
                      return;
                    }

                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: forgotpass.text);
                      setState(() {
                        show =
                            'An email has been sent with a link to reset your password.';
                      });
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        show = e.message.toString();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'RESET PASSWORD',
                    style: TextStyle(
                      color: Colors.cyan.shade800,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    Get.to(const LoginPage());
                  },
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: forgotpass,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Enter your email',
          hintStyle: TextStyle(color: Colors.grey[700]),
          prefixIcon: Icon(Icons.email, color: Colors.cyan[700]),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
