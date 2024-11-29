// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

// class Registeredusers extends StatefulWidget {
//   const Registeredusers({super.key});

//   @override
//   State<Registeredusers> createState() => _RegisteredusersState();
// }

// class _RegisteredusersState extends State<Registeredusers> {
//   @override
//   void initState() {
//     fetchdata();
//     super.initState();
//   }

//   List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Registered Users"),
//           backgroundColor: Colors.green[300],
//         ),
//         body: SingleChildScrollView(
//           child: ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: docs.length,
//               itemBuilder: (BuildContext context, int index) {
//                 if (docs.isNotEmpty) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 220,
//                       width: 1000,
//                       decoration: BoxDecoration(
//                           color: Colors.green[300],
//                           borderRadius: const BorderRadius.all(Radius.circular(20))),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Name:',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Email:',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   docs[index].data()['name'],
//                                   style: const TextStyle(
//                                       color: Colors.white, fontSize: 15),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   docs[index].data()['email'],
//                                   style: const TextStyle(
//                                       color: Colors.white, fontSize: 15),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Phone:',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Blood Group:',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   docs[index].data()['phone'],
//                                   style: const TextStyle(
//                                       color: Colors.white, fontSize: 15),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   docs[index].data()['blood'],
//                                   style: const TextStyle(
//                                       color: Colors.white, fontSize: 15),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const Row(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'City:',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   docs[index].data()['city'],
//                                   style: const TextStyle(
//                                       color: Colors.white, fontSize: 15),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//                 return const Text(
//                     "Sorry to say this we have no registered users at this time");
//               }),
//         ));
//   }

//   Future<List> fetchdata() async {
//     EasyLoading.show(status: "");
//     QuerySnapshot<Map<String, dynamic>> data =
//         await FirebaseFirestore.instance.collection("users").get();
//     docs = data.docs;
//     print(docs);
//     print('tejesh');
//     setState(() {});
//     EasyLoading.dismiss();
//     return docs;
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Registeredusers extends StatefulWidget {
  const Registeredusers({super.key});

  @override
  State<Registeredusers> createState() => _RegisteredusersState();
}

class _RegisteredusersState extends State<Registeredusers> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registered Users",
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
                  "No registered users at this time",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12.0),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black54, Colors.black12],
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
                          _buildUserRow(
                            label1: "Name:",
                            value1: docs[index].data()['name'] ?? "N/A",
                            label2: "Email:",
                            value2: docs[index].data()['email'] ?? "N/A",
                          ),
                          const SizedBox(height: 12),
                          _buildUserRow(
                            label1: "Phone:",
                            value1: docs[index].data()['phone'] ?? "N/A",
                            label2: "Blood Group:",
                            value2: docs[index].data()['blood'] ?? "N/A",
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                "City: ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                  );
                },
              ),
      ),
    );
  }

  Widget _buildUserRow({
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
                  color: Colors.white),
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
                  color: Colors.white),
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

  Future<void> fetchdata() async {
    EasyLoading.show(status: "Loading...");
    QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection("users").get();
    docs = data.docs;
    setState(() {});
    EasyLoading.dismiss();
  }
}
