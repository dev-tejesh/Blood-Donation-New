

import 'package:blooddonation/homepage.dart';
import 'package:blooddonation/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController displayController = TextEditingController();
  String error = "";
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                  'REGISTER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(
                  controller: displayController,
                  hintText: 'Display Name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: passController,
                  hintText: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                ),
                if (error.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 40),
                _buildRegisterButton(screenWidth),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.to(const LoginPage()); // Navigate back to Login Page
                  },
                  child: const Text(
                    'Already have an account? Log in',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
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
        controller: controller,
        obscureText: isPassword && showPass,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[700]),
          prefixIcon: Icon(icon, color: Colors.cyan[700]),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    showPass ? Icons.visibility : Icons.visibility_off,
                    color: Colors.cyan[700],
                  ),
                  onPressed: () {
                    setState(() {
                      showPass = !showPass;
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildRegisterButton(double screenWidth) {
    return ElevatedButton(
      onPressed: () async {
        if (emailController.text.isEmpty || passController.text.isEmpty) {
          setState(() {
            error = "Email and password cannot be empty.";
          });
          return;
        }

        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailController.text)) {
          setState(() {
            error = "Please enter a valid email.";
          });
          return;
        }

        if (passController.text.length < 6) {
          setState(() {
            error = "Password must be at least 6 characters long.";
          });
          return;
        }

        try {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController.text, password: passController.text);
          Get.to(() => const Homepage());
        } on FirebaseAuthException catch (e) {
          setState(() {
            error = e.message ?? "An error occurred: ${e.code}";
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 8,
      ),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(
          color: Colors.cyan[800],
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
