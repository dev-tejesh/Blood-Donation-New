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
  @override
  void initState() {
    // TODO: implement
    EasyLoading.showToast("Double tap to delete",
        toastPosition: EasyLoadingToastPosition.center);
    getuserdonations();
    super.initState();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YOUR PROFILES')),
      body: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: docs.length,
          itemBuilder: (BuildContext context, int index) {
            if (docs.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onDoubleTap: () {
                    deletedata(docs[index].id);
                    docs.removeAt(index);
                    setState(() {});
                  },
                  child: Container(
                    height: 220,
                    width: 1000,
                    decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Name:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Email:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                docs[index].data()['name'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                docs[index].data()['email'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Phone:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Blood Group:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                docs[index].data()['phone'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                docs[index].data()['blood'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'City:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                docs[index].data()['city'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Text(
                "Sorry to say this we have no registered users at this time");
          }),
    );
  }

  Future getuserdonations() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    docs = snapshot.docs;
    setState(() {});
    return docs;
  }

  Future deletedata(String docid) async {
    await FirebaseFirestore.instance.collection("users").doc(docid).delete();
    return EasyLoading.showToast("You have successfully deleted",
        toastPosition: EasyLoadingToastPosition.center);
    return true;
  }
}
