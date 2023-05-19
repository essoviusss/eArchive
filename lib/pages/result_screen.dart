import 'package:e_archive/Constants/size_constant.dart';
import 'package:e_archive/pages/home_screen.dart';
import 'package:e_archive/pages/pdfview_screen.dart';
import 'package:e_archive/pages/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ResultScreen extends StatefulWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> results = [];

  Future<void> searchQuery(String searchQuery) async {
    try {
      final data = {'search_query': searchQuery};
      final response = await http.post(
        Uri.parse('http://192.168.1.18/earchive_api/search_result.php'),
        body: data,
      );
      setState(() {
        results = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
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
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text('Home'),
              ),
              SizedBox(
                width: ScreenUtil.widthVar / 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ScanScreen()),
                  );
                },
                child: const Text('Scan Again'),
              ),
              SizedBox(
                width: ScreenUtil.widthVar / 10,
              ),
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
                      color: Colors.grey,
                    ),
                    margin: EdgeInsets.only(
                        left: ScreenUtil.widthVar / 12,
                        right: ScreenUtil.widthVar / 12,
                        bottom: ScreenUtil.heightVar / 90),
                    child: ListTile(
                      title: Text("Title: ${results[index]['research_title']}"),
                      subtitle: Text(
                          'Publication Year: ${DateTime.parse(results[index]['publication_date']).year}\nAuthor Names: ${results[index]['author_names'].join(', ')}'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
