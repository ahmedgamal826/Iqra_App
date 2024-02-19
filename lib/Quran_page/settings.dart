import 'package:flutter/material.dart';

import 'constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white, size: 30),
            centerTitle: true,
            title: Text(
              "Settings",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            backgroundColor: Colors.brown),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'حجم الخط العربي',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                      activeColor: Colors.brown,
                      value: arabicFontSize,
                      min: 20,
                      max: 40,
                      onChanged: (value) {
                        setState(() {
                          arabicFontSize = value;
                        });
                      }),
                  Text(
                    "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
                    style: TextStyle(
                        fontFamily: 'quran', fontSize: arabicFontSize),
                    textDirection: TextDirection.rtl,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Divider(),
                  ),
                  const Text(
                    'حجم الخط في وضع المصحف',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                      activeColor: Colors.brown,
                      value: mushafFontSize,
                      min: 20,
                      max: 50,
                      onChanged: (value) {
                        mushafFontSize = value;
                      }),
                  Text(
                    "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
                    style: TextStyle(
                        fontFamily: 'quran', fontSize: arabicFontSize),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown),
                          onPressed: () {
                            setState(() {
                              arabicFontSize = 28;
                              mushafFontSize = 40;
                            });

                            saveSettings();
                          },
                          child: const Text(
                            'Reset',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown),
                          onPressed: () {
                            saveSettings();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
