
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Needblood extends StatefulWidget {
  const Needblood({super.key});

  @override
  State<Needblood> createState() => _NeedbloodState();
}

class _NeedbloodState extends State<Needblood> {
  final TextEditingController _controller = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
  final List<String> items = ["A+", "A−", 'B+', 'B−', 'AB+', 'AB−', 'O+', 'O−'];
  late String countryValue = "";
  late String stateValue = "";
  late String cityValue = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  Future<void> fetchdata() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection("users").get();
    docs = data.docs;
    setState(() {
      isLoading = false;
    });
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter the following details to get the profiles',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              const SizedBox(height: 20),
              _buildLocationPicker(),
              const SizedBox(height: 20),
              _buildBloodGroupSelector(),
              const SizedBox(height: 20),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildDonorList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationPicker() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SelectState(
          onCountryChanged: (value) {
            setState(() => countryValue = value);
          },
          onStateChanged: (value) {
            setState(() => stateValue = value);
          },
          onCityChanged: (value) {
            setState(() => cityValue = value);
          },
        ),
      ),
    );
  }

  Widget _buildBloodGroupSelector() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Select the blood group you need',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: PopupMenuButton<String>(
              icon: const Icon(Icons.arrow_drop_down),
              onSelected: (value) {
                _controller.text = value;
                setState(() {});
              },
              itemBuilder: (context) {
                return items.map((String value) {
                  return PopupMenuItem(value: value, child: Text(value));
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDonorList() {
    final filteredDocs = docs.where((doc) {
      return doc['blood'] == _controller.text.toUpperCase() &&
          cityValue == doc['city'];
    }).toList();

    if (_controller.text.isEmpty || cityValue.isEmpty) {
      return const Center(
        child: Text(
          'Please select all details to see the donor profiles.',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    if (filteredDocs.isEmpty) {
      return const Center(
        child: Text(
          'No donors available in your city. Kindly check the registered users on the home page.',
          style: TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredDocs.length,
      itemBuilder: (context, index) {
        final doc = filteredDocs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(
                  doc['blood'],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text('Name: ${doc['name']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${doc['email']}'),
                  Text('Phone: ${doc['phone']}'),
                  Text('City: ${doc['city']}'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () async {
                  // final phoneNumber =
                  //     doc['phone']; // Assuming phone number is stored here

                  // // Construct the URL for dialing
                  // final uri = Uri(scheme: 'tel', path: phoneNumber);

                  // // Launch the URL to open the dialer
                  // if (await canLaunchUrl(uri)) {
                  //   await launchUrl(uri);
                  // } else {
                  //   // Handle the error if the URL can't be launched
                  //   print('Could not launch $uri');
                  // }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
