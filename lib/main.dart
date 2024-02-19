import 'package:flutter/material.dart';
import 'package:iqra_app/splash_screen.dart';

import 'Quran_page/constants.dart';

void main() {
  runApp(const IqraApp());
}

class IqraApp extends StatefulWidget {
  const IqraApp({super.key});

  @override
  State<IqraApp> createState() => _IqraAppState();
}

class _IqraAppState extends State<IqraApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await readJson();
      await getSettings();
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
