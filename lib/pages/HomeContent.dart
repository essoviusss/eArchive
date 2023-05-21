import 'package:e_archive/Constants/size_constant.dart';
import 'package:e_archive/pages/result_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_archive/Constants/size_constant.dart';
import 'package:e_archive/pages/home_screen.dart';
import 'package:e_archive/pages/pdfview_screen.dart';
import 'package:e_archive/pages/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:network_info_plus/network_info_plus.dart';

class HomeContent extends StatefulWidget {
  final String? text;
  const HomeContent({Key? key, required this.text}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String? user = FirebaseAuth.instance.currentUser!.email;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> results = [];
  bool _isImageScanned = false; // Flag to check if an image has been scanned

  Future<void> searchQuery(String searchQuery) async {
    try {
      final data = {'search_query': searchQuery};
      final response = await http.post(
        Uri.parse('http://192.168.1.102/earchive_api/search_result.php'),
        body: data,
      );
      setState(() {
        results = jsonDecode(response.body);
        _isImageScanned =
            true; // If the search is successful, set the flag to true
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.text != null) {
      _searchController.text = widget.text!;
      searchQuery(widget.text!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.black.withOpacity(0.1),
              builder: (BuildContext context) {
                return Container(
                    color: Colors.black.withOpacity(0.1),
                    height: ScreenUtil.heightVar / 1,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil.widthVar / 20,
                            right: ScreenUtil.widthVar / 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: ScreenUtil.heightVar / 60,
                            ),
                            const Text(
                              "Here are the guidelines for taking pictures of thesis cover page.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.heightVar / 100,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: ScreenUtil.heightVar / 100,
                            ),
                            const Text(
                              " ⚫ Backgrounds should be plain and unobstructive providing no distraction from the area of interest.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.heightVar / 90,
                            ),
                            const Text(
                              " ⚫ General library light may not always be sufficient to light an image. Consider using flash.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.heightVar / 90,
                            ),
                            const Text(
                              " ⚫ Images must be in focus. If your camera is too close to the paper, this usually result in an out of focus photograph. Try zooming in a bit further back.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            );
          },
          backgroundColor: Colors.deepOrangeAccent,
          child: const Icon(Icons.rule_sharp),
        ),
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.only(
              left: ScreenUtil.widthVar / 20,
              right: ScreenUtil.widthVar / 20,
              top: ScreenUtil.heightVar / 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                user == "sample@email.com"
                    ? "Hi, Unknown User!"
                    : user == "sample1@email.com"
                        ? "Hi, Cole"
                        : "",
                style: const TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: ScreenUtil.heightVar / 100,
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: ScreenUtil.heightVar / 100,
              ),
              // If the image is scanned, show search and result widgets.
              if (_isImageScanned) ...[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search Result',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        searchQuery(_searchController.text);
                      },
                      child: const Text('Search'),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil.heightVar / 80,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil.widthVar / 12,
                      right: ScreenUtil.widthVar / 12),
                  child: const Divider(
                    height: 0.1,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil.heightVar / 80,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil.widthVar / 12,
                      right: ScreenUtil.widthVar / 12),
                  alignment: Alignment.centerLeft,
                  child: Text("Results:"),
                ),
                SizedBox(
                  height: ScreenUtil.heightVar / 80,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewScreen(
                                pdfPath:
                                    'assets/pdf/${results[index]['pdf_name']}.pdf',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          margin: EdgeInsets.only(
                              left: ScreenUtil.widthVar / 12,
                              right: ScreenUtil.widthVar / 12,
                              bottom: ScreenUtil.heightVar / 90),
                          child: ListTile(
                            title: Text(
                                "Title: ${results[index]['research_title']}"),
                            subtitle: Text(
                                'Publication Year: ${DateTime.parse(results[index]['publication_date']).year}\nAuthor Names: ${results[index]['author_names'].join(', ')}'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
