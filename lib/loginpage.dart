import 'package:blooddonation/forgotpassword.dart';
import 'package:blooddonation/homepage.dart';
import 'package:blooddonation/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  String showError = "";
  bool isObs = true;

  @override
  void initState() {
    super.initState();
    checkExistingLogin();
  }

  Future<void> checkExistingLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('repeat') && pref.getBool('repeat') == true) {
      Get.offAll(() => const Homepage());
    }
  }

  void showProgress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: SpinKitFadingCircle(
          color: Colors.cyan,
          size: 50.0,
        ),
      ),
    );
  }

  void hideProgress(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

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
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(
                  controller: email,
                  hintText: 'Email',
                  isObscured: false,
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: pass,
                  hintText: 'Password',
                  isObscured: isObs,
                  icon: Icons.lock,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isObs = !isObs;
                      });
                    },
                    child: Icon(
                      isObs ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => const Forgot());
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (showError.isNotEmpty)
                  Text(
                    showError,
                    style: const TextStyle(color: Colors.red),
                  ),
                TextButton(
                  onPressed: () {
                    Get.to(() => RegisterPage());
                  },
                  child: const Text(
                    'Not Registered? Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (email.text.isEmpty || pass.text.isEmpty) {
                        setState(() {
                          showError = "Please fill in all fields.";
                        });
                        return;
                      }

                      showProgress(context);

                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email.text.trim(),
                        password: pass.text.trim(),
                      );

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('repeat', true);

                      hideProgress(context);
                      Get.offAll(() => const Homepage());
                    } on FirebaseAuthException catch (e) {
                      hideProgress(context);
                      setState(() {
                        showError =
                            e.message ?? "An unexpected error occurred.";
                      });
                    } catch (e) {
                      hideProgress(context);
                      setState(() {
                        showError = "An error occurred. Please try again.";
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.cyan.shade800,
                      fontSize: 16,
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
    required bool isObscured,
    required IconData icon,
    Widget? suffixIcon,
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
        obscureText: isObscured,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[700]),
          prefixIcon: Icon(icon, color: Colors.cyan[700]),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          suffixIcon: suffixIcon,
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
