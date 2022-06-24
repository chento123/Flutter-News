import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/get_news_detail.dart';
import 'package:http/http.dart' as http;

class GetAllNews extends StatefulWidget {
  const GetAllNews({Key? key}) : super(key: key);

  @override
  State<GetAllNews> createState() => _GetAllNewsState();
}

class _GetAllNewsState extends State<GetAllNews> {
  List MyList = [];
  Future<List> GetAllData() async {
    var url = "https://reanweb.com/api/teaching/get-news.php?mid=0";
    var rp = await http.get(Uri.parse(url));
    if (rp.statusCode == 200) {
      MyList = jsonDecode(rp.body);
    }
    return MyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ត្នោ News'),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: GetAllData(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) {
                          return NewsDetail(id: int.parse(MyList[index]['id']));
                        }),
                      ),
                    );
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: double.infinity,
                            color: Colors.brown,
                            child: Image.network(MyList[index]['img']),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: double.infinity,
                            color: Colors.brown,
                            child: Text(
                              MyList[index]['title'],
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

    );
  }
}
