import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
// import 'package:country_state_city_picker/country_state_city_picker.dart';

class Needblood extends StatefulWidget {
  const Needblood({super.key});

  @override
  State<Needblood> createState() => _NeedbloodState();
}

class _NeedbloodState extends State<Needblood> {
  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  var items = [
    "A+",
    "A−",
    'B+',
    'B−',
    'AB+',
    'AB−',
    'O+',
    'O−',
  ];
  int count = 0;
  bool check = true;
  late String countryValue;
  late String stateValue;
  late String cityValue;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Contact'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(15.0, 2.0, 0.0, 0.0),
                child: Text(
                  'Enter the following details to get the profiles',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // height: 600,
                  child: Column(
                    children: [
                      SelectState(
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
                          });
                        },
                      ),
                      // InkWell(
                      //   onTap:(){
                      //     print('country selected is $countryValue');
                      //     print('country selected is $stateValue');
                      //     print('country selected is $cityValue');
                      //   },
                      //   child: Text(' Check')
                      // )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  enabled: true,
                  decoration: InputDecoration(
                    hintText: 'Select the blood group you need',
                    hintStyle: const TextStyle(color: Colors.red),
                    fillColor: Colors.green[200],
                    suffixIcon: PopupMenuButton<String>(
                      // color: Colors.red,

                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      onSelected: (String value) {
                        _controller.text = value;
                        setState(() {});
                      },
                      itemBuilder: (BuildContext context) {
                        return items.map<PopupMenuItem<String>>((String value) {
                          return PopupMenuItem(
                              value: value,
                              child: Text(value));
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
              if (docs.isNotEmpty)
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    // print(docs[index].data()['blood']);
                    // print(_controller.text);

                    if (docs[index].data()['blood'] ==
                            _controller.text.toUpperCase() &&
                        docs.isNotEmpty &&
                        cityValue == docs[index].data()['city']) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 220,
                          width: 1000,
                          decoration: BoxDecoration(
                              color: Colors.green[300],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Name:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Email:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Phone:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Blood Group:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                      );
                    }

                    return index == 0 && _controller.text.isNotEmpty
                        ? Container(
                            child: const Text(
                              'Donors are not available in your city.Kindly check the registered users in home page.',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : Container();
                  },
                )
              else
                const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }

  Future<List> fetchdata() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection("users").get();
    docs = data.docs;
    // print(docs);
    setState(() {});
    return docs;
  }
}
