import 'package:blooddonation/deleteuser.dart';
import 'package:blooddonation/donateblood.dart';
import 'package:blooddonation/main.dart';
import 'package:blooddonation/needblood.dart';
import 'package:blooddonation/registeredusers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Sign-out function
  Future<void> tej() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('repeat');
    Get.offAll(const MyHomePage(title: 'tej'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text(
            'Hey, Welcome!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan.shade100, Colors.cyan.shade600],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Network Image Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://t3.ftcdn.net/jpg/02/22/82/30/360_F_222823036_n9ocpis9ILjK6KuOMV4v7urh4dlHCvSq.jpg',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Text(
                            'Image failed to load',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Donate Blood Section
              _buildActionCard(
                title: 'DONATE BLOOD',
                icon: Icons.bloodtype,
                onTap: () {
                  Get.to(const Donateblood());
                },
                color: Colors.red.shade400,
              ),
              const SizedBox(height: 20),
              // Need Blood Section
              _buildActionCard(
                title: 'NEED BLOOD',
                icon: Icons.health_and_safety,
                onTap: () {
                  Get.to(const Needblood());
                },
                color: Colors.red.shade700,
              ),
            ],
          ),
        ),
        drawer: _buildDrawer(),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.cyan.shade100,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyan.shade300, Colors.cyan.shade600],
                ),
              ),
              child: const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            _buildDrawerItem(
              title: 'REGISTERED USERS',
              onTap: () {
                Get.to(const Registeredusers());
              },
              icon: Icons.people,
            ),
            _buildDrawerItem(
              title: 'DONATE BLOOD',
              onTap: () {
                Get.to(const Donateblood());
              },
              icon: Icons.bloodtype,
            ),
            _buildDrawerItem(
              title: 'NEED BLOOD',
              onTap: () {
                Get.to(const Needblood());
              },
              icon: Icons.health_and_safety,
            ),
            _buildDrawerItem(
              title: 'DELETE PROFILE',
              onTap: () {
                Get.to(const Deletedata());
              },
              icon: Icons.delete,
            ),
            _buildDrawerItem(
              title: 'LOGOUT',
              onTap: tej,
              icon: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.cyan.shade700),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
