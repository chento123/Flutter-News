import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';

class NewsDetail extends StatefulWidget {
  int id;
  NewsDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  List detail = [];
  int i = 0;
  Future<List> getNewDetail() async {
    var url =
        "https://reanweb.com/api/teaching/get-news-detail.php?id=${widget.id}";
    var rp = await http.get(Uri.parse(url));
    if (rp.statusCode == 200 && i == 0) {
      var rs = jsonDecode(rp.body);
      detail.add(rs);
      i = 1;
    }
    var des;
    return detail;
  }

 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(233, 219, 213, 213),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('News Detail'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getNewDetail(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: detail.length,
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      child: Html(
                        data: detail[index]['title'],
                        style: {
                          'h2': Style(
                            fontWeight: FontWeight.w600,
                            lineHeight: LineHeight(1.5),
                            fontSize: FontSize(18),
                          ),
                        },
                      ),
                    ),
                    Container(
                      height: 4000,
                      width: double.infinity,
                      child: Html(
                        data: detail[index]['des'],
                        style: {
                          'p': Style(
                            fontWeight: FontWeight.w600,
                            lineHeight: LineHeight(1.5),
                            fontSize: FontSize(18),
                          ),
                        },
                      ),
                    ),
                  ],
                );
              }),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
