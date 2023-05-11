import 'package:e_archive/Constants/size_constant.dart';
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
  List<dynamic> results = [];

  Future<void> searchQuery(String searchQuery) async {
    try {
      // Encode the search query as form data
      final data = {'search_query': searchQuery};

      // Make a POST request to the PHP script
      final response = await http.post(
        Uri.parse('http://192.168.100.102/earchive_api/search_result.php'),
        body: data,
      );

      // Parse the response from the PHP script
      setState(() {
        results = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
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
            child: Text("Scan Result: ${widget.text}"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
                child: const Text('Scan Again'),
              ),
              SizedBox(
                width: ScreenUtil.widthVar / 10,
              ),
              ElevatedButton(
                onPressed: () {
                  searchQuery(widget.text);
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
}
