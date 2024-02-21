import 'package:flutter/material.dart';
import 'package:iqra_app/Quran_page/surah_builder.dart';

import 'constants.dart';
import 'mydrawer.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Go to bookmark',
        child: Icon(
          Icons.bookmark,
          color: Colors.white,
          size: 30,
        ),
        backgroundColor: Colors.brown,
        onPressed: () async {
          if (await readBookMark() == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SurahBuilder(
                          arabic: quran[0],
                          sura: bookmarkedSura - 1,
                          suraName: arabicName[bookmarkedSura - 1]['name'],
                          ayah: bookmarkedAyah,
                        )));
          }
        },
      ),
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Colors.white, size: 35), // to change menu icon
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: Text(
          'القرآن الكريم',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(
              'assets/images/quran (1).png',
              width: 45,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: readJson(), // read json file
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.brown,
            ));
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return HomePageQuran(snapshot.data, context);
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }

  Container HomePageQuran(quran, context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: arabicName.length,
        itemBuilder: (context, index) {
          return Container(
            color: index % 2 == 0
                ? const Color.fromARGB(255, 253, 247, 230) // yellow
                : const Color.fromARGB(255, 253, 251, 240), // white
            child: TextButton(
              child: ListTile(
                leading: Text(
                  '${arabicName[index]['surah']}', // Number of Surah
                  style: TextStyle(fontSize: 25),
                ),
                title: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'آياتها',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          '${numberOfSurah[index]}',
                        )
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      '${arabicName[index]['type']}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                trailing: Text(
                  '${arabicName[index]['name']}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),

              // onPressed of TextButton
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SurahBuilder(
                            arabic: quran[0],
                            sura: index,
                            suraName: arabicName[index]['name'],
                            ayah: 0,
                          )),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
