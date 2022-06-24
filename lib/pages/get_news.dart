import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/get_news_detail.dart';
import 'package:http/http.dart' as http;

class GetNews extends StatefulWidget {
  int idmenu;
  String Nmenu;
  GetNews({Key? key, required this.idmenu, required this.Nmenu})
      : super(key: key);

  @override
  State<GetNews> createState() => _GetNewsState();
}

class _GetNewsState extends State<GetNews> {
  List MyList = [];
  List ls = [];
  Future<List> getNews() async {
    var url = 'https://reanweb.com/api/teaching/get-news.php?mid=0';
    var rp = await http.get(Uri.parse(url));
    if (rp.statusCode == 200) {
      ls = jsonDecode(rp.body);
    }
    for (int i = 0; i < ls.length; i++) {
      if (widget.idmenu == int.parse(ls[i]['menu'])) {
        MyList.add(ls[i]);
      }
    }
    return MyList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(245, 232, 224, 224),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(widget.Nmenu),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getNews(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: MyList.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return NewsDetail(id: int.parse(MyList[index]['id']));
                    })));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(7),
                    clipBehavior: Clip.hardEdge,
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: double.infinity,
                            child: Image.network(
                              MyList[index]['img'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: double.infinity,
                            child: Center(
                                child: Text(
                              MyList[index]['title'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
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
