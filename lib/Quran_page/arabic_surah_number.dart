import 'package:flutter/material.dart';

class ArabicSurahNumber extends StatelessWidget {
  const ArabicSurahNumber({super.key, required this.txt});

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontFamily: 'me_quran',
          fontSize: 25,
          shadows: [
            Shadow(
              offset: Offset(.5, .5),
              blurRadius: 1.0,
              color: Colors.amberAccent,
            )
          ]),
    );
  }
}
