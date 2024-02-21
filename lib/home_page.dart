import 'package:flutter/material.dart';
import 'package:iqra_app/Ahades_page/Screens/home_page_ahades.dart';
import 'package:iqra_app/Azkar_page/Screens/azkar_screen.dart';
import 'package:iqra_app/Names_page/Names.dart';
import 'package:iqra_app/Quran_page/index_page.dart';
import 'package:iqra_app/Tasbeh_page/Tasbeh_Screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 4;

  List<Widget> pages = [
    Tasbeh_screen(), // Tasbeh Screen
    Names(), // Names Screen
    HomePageAhades(), // Ahades Screen
    AzkarHomePage(), // Azkar Screen
    IndexPage(), // Quran Screen
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting, // shifting from 4 or more
        currentIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              // Tasbeh Icon
              backgroundColor: Colors.brown,
              icon: Image.asset(
                'assets/images/ramadan.png',
                color: Colors.white,
                width: 40,
              ),
              label: 'السبحة الإلكترونية'),
          BottomNavigationBarItem(
              backgroundColor: Colors.brown,
              icon: Image.asset(
                'assets/images/allah.png',
                color: Colors.white,
                width: 40,
              ),
              label: 'أسماء الله الحسني'),
          BottomNavigationBarItem(
              backgroundColor: Colors.brown,
              icon: Image.asset(
                'assets/images/prophet.png',
                color: Colors.white,
                width: 40,
              ),
              label: 'الاحاديث الشريفة'),
          BottomNavigationBarItem(
              backgroundColor: Colors.brown,
              icon: Image.asset(
                'assets/images/dua-hands.png',
                color: Colors.white,
                width: 40,
              ),
              label: 'أذكار المسلم'),
          BottomNavigationBarItem(
              backgroundColor: Colors.brown,
              icon: Image.asset(
                'assets/images/quran (1).png',
                width: 40,
                color: Colors.white,
              ),
              label: 'القرآن الكريم'),
        ],
      ),
    );
  }
}
