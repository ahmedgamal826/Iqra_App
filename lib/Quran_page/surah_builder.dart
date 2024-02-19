import 'package:flutter/material.dart';
import 'package:iqra_app/Quran_page/show_snack_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener =
    ItemPositionsListener.create();

bool fabIsClicked = true;

class SurahBuilder extends StatefulWidget {
  final sura;
  final arabic;
  final suraName;
  int ayah;

  SurahBuilder(
      {Key? key, this.sura, this.arabic, this.suraName, required this.ayah})
      : super(key: key);

  @override
  State<SurahBuilder> createState() => _SurahBuilderState();
}

class _SurahBuilderState extends State<SurahBuilder> {
  // initstate
  // jumb to ayah
  // save bookmark
  // verseBuilding
  // single surah Builders

  bool view = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumbToAyah());

    super.initState();
  }

  jumbToAyah() {
    if (fabIsClicked) {
      itemScrollController.scrollTo(
          index: widget.ayah,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    }

    fabIsClicked = false;
  }

  saveBookMark(surah, ayah) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("surah", surah);
    await prefs.setInt("ayah", ayah);
  }

  Row verseBuilder(int index, previousVerses) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.arabic[index + previousVerses]['aya_text'],
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: arabicFontSize,
                fontFamily: arabicFont,
                color: const Color.fromARGB(196, 0, 0, 0),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [],
            )
          ],
        ))
      ],
    );
  }

  SafeArea SingleSuraBuilder(LenghtOfSura) {
    String fullSura = '';
    int previousVerses = 0;
    if (widget.sura + 1 != 1) {
      for (int i = widget.sura - 1; i >= 0; i--) {
        previousVerses = previousVerses + numberOfSurah[i];
      }
    }

    if (!view)
      for (int i = 0; i < LenghtOfSura; i++) {
        fullSura += (widget.arabic[i + previousVerses]['aya_text']);
      }

    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 253, 251, 240),
        child: view
            ? ScrollablePositionedList.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      (index != 0) ||
                              (widget.sura == 0) ||
                              (widget.sura ==
                                  8) // == 0 (سورة الفاتحة) // == 8 (سورة التوبة)
                          ? const Text('')
                          : const ReturnBasmala(),
                      Container(
                        color: index % 2 != 0
                            ? const Color.fromARGB(255, 253, 251, 240)
                            : const Color.fromARGB(255, 253, 247, 230),
                        child: PopupMenuButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: verseBuilder(index, previousVerses),
                            ),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      showSnakeBar(
                                          context, 'تم حفظ الآية بنجاح');
                                      setState(() {
                                        saveBookMark(widget.sura + 1, index);
                                      });
                                    },
                                    child: Row(
                                      children: const [
                                        Text(
                                          'حفظ الآية',
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.bookmark_add,
                                            color: Colors.brown),
                                      ],
                                    ),
                                  ),
                                ]),
                      ),
                    ],
                  );
                },
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                itemCount: LenghtOfSura,
              )
            : ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.sura + 1 != 1 &&
                                    widget.sura + 1 !=
                                        9 // سورة الفاتحة && سورة التوبة
                                ? const ReturnBasmala()
                                : const Text(''),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                fullSura, //mushaf mode
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: mushafFontSize,
                                  fontFamily: arabicFont,
                                  color: const Color.fromARGB(196, 44, 44, 44),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget build(BuildContext context) {
    int LenghtOfSura = numberOfSurah[widget.sura];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          centerTitle: true,
          leading: Image.asset(
            'assets/images/quran (1).png',
            width: 20,
            color: Colors.white,
          ),
          title: Text(
            'سورة ' + widget.suraName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'quran',
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 35,
                ))
          ],
        ),
        body: SingleSuraBuilder(LenghtOfSura),
      ),
    );
  }
}

class ReturnBasmala extends StatelessWidget {
  const ReturnBasmala({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: Text(
              'بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ ',
              style: TextStyle(fontSize: 30, fontFamily: 'me_quran'),
              textDirection: TextDirection.rtl,
            ),
          ),
        )
      ],
    );
  }
}
