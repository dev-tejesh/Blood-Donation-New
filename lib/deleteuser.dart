// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

// class Deletedata extends StatefulWidget {
//   const Deletedata({super.key});

//   @override
//   State<Deletedata> createState() => _DeletedataState();
// }

// class _DeletedataState extends State<Deletedata> {
//   @override
//   void initState() {
//     // TODO: implement
//     EasyLoading.showToast("Double tap to delete",
//         toastPosition: EasyLoadingToastPosition.center);
//     getuserdonations();
//     super.initState();
//   }

//   List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('YOUR PROFILES')),
//       body: ListView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: docs.length,
//           itemBuilder: (BuildContext context, int index) {
//             if (docs.isNotEmpty) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: InkWell(
//                   onDoubleTap: () {
//                     deletedata(docs[index].id);
//                     docs.removeAt(index);
//                     setState(() {});
//                   },
//                   child: Container(
//                     height: 220,
//                     width: 1000,
//                     decoration: BoxDecoration(
//                         color: Colors.green[300],
//                         borderRadius: const BorderRadius.all(Radius.circular(20))),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text(
//                                 'Name:',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text(
//                                 'Email:',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 docs[index].data()['name'],
//                                 style: const TextStyle(
//                                     color: Colors.white, fontSize: 15),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 docs[index].data()['email'],
//                                 style: const TextStyle(
//                                     color: Colors.white, fontSize: 15),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text(
//                                 'Phone:',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text(
//                                 'Blood Group:',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 docs[index].data()['phone'],
//                                 style: const TextStyle(
//                                     color: Colors.white, fontSize: 15),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 docs[index].data()['blood'],
//                                 style: const TextStyle(
//                                     color: Colors.white, fontSize: 15),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text(
//                                 'City:',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 docs[index].data()['city'],
//                                 style: const TextStyle(
//                                     color: Colors.white, fontSize: 15),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }
//             return const Text(
//                 "Sorry to say this we have no registered users at this time");
//           }),
//     );
//   }

//   Future getuserdonations() async {
//     QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//         .instance
//         .collection("users")
//         .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     docs = snapshot.docs;
//     setState(() {});
//     return docs;
//   }

//   Future deletedata(String docid) async {
//     await FirebaseFirestore.instance.collection("users").doc(docid).delete();
//     return EasyLoading.showToast("You have successfully deleted",
//         toastPosition: EasyLoadingToastPosition.center);
//     return true;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Deletedata extends StatefulWidget {
  const Deletedata({super.key});

  @override
  State<Deletedata> createState() => _DeletedataState();
}

class _DeletedataState extends State<Deletedata> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];

  @override
  void initState() {
    EasyLoading.showToast(
      "Double tap to delete",
      toastPosition: EasyLoadingToastPosition.center,
    );
    getuserdonations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Profiles",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade100, Colors.cyan.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: docs.isEmpty
            ? const Center(
                child: Text(
                  "No profiles found.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12.0),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: () {
                      deletedata(docs[index].id);
                      docs.removeAt(index);
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red.shade400, Colors.red.shade600],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                              label1: "Name:",
                              value1: docs[index].data()['name'] ?? "N/A",
                              label2: "Email:",
                              value2: docs[index].data()['email'] ?? "N/A",
                            ),
                            const SizedBox(height: 10),
                            _buildInfoRow(
                              label1: "Phone:",
                              value1: docs[index].data()['phone'] ?? "N/A",
                              label2: "Blood Group:",
                              value2: docs[index].data()['blood'] ?? "N/A",
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  "City: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  docs[index].data()['city'] ?? "N/A",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildInfoRow({
    required String label1,
    required String value1,
    required String label2,
    required String value2,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label1,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              value1,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label2,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              value2,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> getuserdonations() async {
    EasyLoading.show(status: "Loading...");
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    docs = snapshot.docs;
    setState(() {});
    EasyLoading.dismiss();
  }

  Future<void> deletedata(String docid) async {
    await FirebaseFirestore.instance.collection("users").doc(docid).delete();
    EasyLoading.showToast(
      "You have successfully deleted the profile.",
      toastPosition: EasyLoadingToastPosition.center,
    );
  }
}
