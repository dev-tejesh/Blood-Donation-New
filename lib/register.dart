import 'package:blooddonation/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebasepractice/homepage.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController displaycontroller = TextEditingController();
  String error = "";
  bool showPass = true;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'REGISTER',
              style: TextStyle(color: Colors.cyan[200], fontSize: 40),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 1000,
                // color: Colors.white,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: TextField(
                    controller: displaycontroller,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[200],
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'DISPLAY NAME',
                        prefixIcon: const Icon(Icons.person),
                        contentPadding: const EdgeInsets.all(8.0),
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 1000,
                // color: Colors.white,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: TextField(
                    controller: emailcontroller,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[200],
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'EMAIL',
                        prefixIcon: const Icon(Icons.email),
                        contentPadding: const EdgeInsets.all(8.0),
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 1000,
                // color: Colors.white,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: TextField(
                    controller: passcontroller,
                    obscureText: showPass,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        fillColor: Colors.cyan[200],
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'PASSWORD',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                            onTap: () {
                              showPass = !showPass;
                              setState(() {});
                            },
                            child: const Icon(Icons.remove_red_eye)),
                        contentPadding: const EdgeInsets.all(8.0),
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            Text(
              error,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(
              height: 60,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: InkWell(
            //     onTap: () async {
            //       try {
            //         print("came");
            //         UserCredential user = await FirebaseAuth.instance
            //             .createUserWithEmailAndPassword(
            //                 email: emailcontroller.text,
            //                 password: passcontroller.text);

            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) {
            //           return const Homepage();
            //         }));
            //       } on FirebaseAuthException catch (e) {
            //         error = e.message.toString();
            //         setState(() {});
            //       }
            //     },
            //     child: Container(
            //       height: 40,
            //       width: 1000,
            //       decoration: BoxDecoration(
            //           color: Colors.cyan[200],
            //           border: Border.all(
            //             color: Colors.white,
            //           ),
            //           borderRadius:
            //               const BorderRadius.all(Radius.circular(20))),
            //       child: const Center(
            //         child: Text(
            //           'CREATE ACCOUNT',
            //           style: TextStyle(color: Colors.white, fontSize: 15),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  if (emailcontroller.text.isEmpty ||
                      passcontroller.text.isEmpty) {
                    error = "Email and password cannot be empty.";
                    setState(() {});
                    return;
                  }

                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(emailcontroller.text)) {
                    error = "Please enter a valid email.";
                    setState(() {});
                    return;
                  }

                  if (passcontroller.text.length < 6) {
                    error = "Password must be at least 6 characters long.";
                    setState(() {});
                    return;
                  }

                  try {
                    print("Creating user...");
                    UserCredential user = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: passcontroller.text);

                    print("User created: ${user.user?.email}");
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return const Homepage();
                    // }));
                    // Get
                    Get.to(() => const Homepage());
                  } on FirebaseAuthException catch (e) {
                    error = e.message ?? "An error occurred: ${e.code}";
                    print("Error: ${e.code}, Message: ${e.message}");
                    setState(() {});
                  }
                },
                child: Container(
                  height: 40,
                  width: 1000,
                  decoration: BoxDecoration(
                      color: Colors.cyan[200],
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Center(
                    child: Text(
                      'CREATE ACCOUNT',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
