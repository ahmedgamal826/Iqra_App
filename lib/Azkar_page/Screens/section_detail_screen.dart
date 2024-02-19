import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iqra_app/Azkar_page/model_section_ahaes/sectiom_model.dart';

import '../model_section_ahaes/section_detail_model.dart';

class SectionDetailScreen extends StatefulWidget {
  final int id;
  final String title;

  const SectionDetailScreen({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  State<SectionDetailScreen> createState() => _SectionDetailScreenState();
}

class _SectionDetailScreenState extends State<SectionDetailScreen> {
  List<SectionDetailModel> sectionDetails = [];
  int currentIndexPage = 0;

  int counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetailSections();
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Scaffold(
      backgroundColor: Color(0xffE6DECB),
      appBar: AppBar(
        iconTheme: IconThemeData(size: 35, color: Colors.white),
        centerTitle: true,
        title: Text(
          "${widget.title}",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: PageView.builder(
          reverse: true,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ListTile(
                    subtitle: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffD4BEB0),
                        shape: BoxShape.rectangle,
                      ),
                      child: Text(
                        "${sectionDetails[index].content}",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    title: Text(
                      "${sectionDetails[index].reference}",
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              '${currentIndexPage + 1} / ${sectionDetails.length}',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            count = int.parse(
                                sectionDetails[index].count.toString());
                            if (count > 0) {
                              count--;
                              sectionDetails[index].count = count.toString();
                            }
                            if (count == 0 &&
                                currentIndexPage == sectionDetails.length - 1) {
                              setState(() {
                                showAwesomeDialog();
                              });
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.brown,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              '${sectionDetails[index].count}',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          onPageChanged: (index) {
            setState(() {
              currentIndexPage = index;
            });
          },
          itemCount: sectionDetails.length,
        ),
      ),
    );
  }

  void showAwesomeDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      title: 'تقبل الله منا ومنكم صالح الأعمال',
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    )..show();
  }

  loadDetailSections() async {
    sectionDetails = [];
    DefaultAssetBundle.of(context)
        .loadString("assets/database/section_details_db.json")
        .then((data) {
      var response = json.decode(data);
      // print(response);
      response.forEach((section) {
        //print(section["name"]);
        SectionDetailModel _sectionDetail =
            SectionDetailModel.fromJson(section);

        // print(_sectionDetail.sectionId);   // Error : sectionID = null

        if (_sectionDetail.sectionId == widget.id) {
          sectionDetails.add(_sectionDetail); // sections ==> List
        }
      });
      setState(() {}); // to feel Scaffold with the new data
    }).catchError((error) {
      print(error);
    });
  }
}
