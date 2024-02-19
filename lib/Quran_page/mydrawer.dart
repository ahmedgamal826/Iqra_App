import 'package:flutter/material.dart';
import 'package:iqra_app/Quran_page/settings.dart';
import 'package:share_plus/share_plus.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/quran.png',
                  height: 80,
                ),
                const Text(
                  'Al Quran',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: const Text('Share'),
            onTap: () {
              Share.share(
                  ' https://github.com/ahmedgamal826/Quran_Karim_Using_Flutter.git');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
