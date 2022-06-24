import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/get_all_news.dart';
import 'package:flutter_application_1/pages/get_news.dart';
import 'package:flutter_application_1/pages/get_news_detail.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List MyMenu = [];
  List NewDetial = [];
  Future<List> GetMenuList() async {
    var url = 'https://reanweb.com/api/teaching/get-menu.php';
    var rp = await http.get(Uri.parse(url));
    if (rp.statusCode == 200) {
      MyMenu = jsonDecode(rp.body);
    }
    return MyMenu;
  }

  List newsDetail = [];
  Future<List> GetNewDetail() async {
    var url = 'https://reanweb.com/api/teaching/get-news-detail.php?id=2';
    var rp = await http.get(Uri.parse(url));
    if (rp.statusCode == 200) {
      newsDetail = jsonDecode(rp.body);
    }
    return newsDetail;
  }

  List MyList = [];
  var listSport = [];
  var listTechnology = [];
  var listFun = [];
  var listNews = [];
  Future<List> getNews() async {
    var url = 'https://reanweb.com/api/teaching/get-news.php?mid=0';
    var rp = await http.get(Uri.parse(url));
    if (rp.statusCode == 200) {
      MyList = jsonDecode(rp.body);
    }
    var a = 0;
    if (a == 0) {
      for (int i = 0; i < MyList.length; i++) {
        if (int.parse(MyList[i]['menu']) == 1) {
          listSport.add(MyList[i]);
        } else if (int.parse(MyList[i]['menu']) == 2) {
          listTechnology.add(MyList[i]);
        } else if (int.parse(MyList[i]['menu']) == 3) {
          listFun.add(MyList[i]);
        } else {
          listNews.add(MyList[i]);
        }
      }
      a = 1;
    }
    return MyList;
  }

  var img = {
    0: 'https://cdnuploads.aa.com.tr/uploads/Contents/2022/01/27/thumbs_b_c_cd7d53840cc64190294b625c10398ac5.jpg?v=150353',
    1: 'https://greatpeopleinside.com/wp-content/uploads/2017/05/HR-GR8-technology.jpg',
    2: 'https://thoughtcatalog.com/wp-content/uploads/2016/12/7-fun-types-of-people-everyone-needs-in-their-friend-group.jpg',
    3: 'https://omarimc.com/wp-content/uploads/2017/01/news-636978_960_720.jpg',
  };
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (con) {
          return HomePage();
        }));
        index = 0;
      }
      if (index == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (con) {
          return GetAllNews();
        }));
        index = 0;
      }
      if (index == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (con) {
          return HomePage();
        }));
      }
      if (index == 3) {
        Navigator.push(context, MaterialPageRoute(builder: (con) {
          return HomePage();
        }));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 252, 252),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Hot News'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return GetAllNews();
                  }),
                ),
              );
            },
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getNews(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.more)
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 90,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: MyMenu.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) {
                                    return GetNews(
                                      idmenu: int.parse(MyMenu[index]['id']),
                                      Nmenu: MyMenu[index]['name'],
                                    );
                                  }),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              height: double.infinity,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${img[index]}',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: 80,
                                  height: 30,
                                  color: Colors.white70,
                                  child: Text(
                                    '${MyMenu[index]['name']}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                getCategories('កីឡា', 1),
                newDetail(listSport),
                getCategories('បច្ចេកវិទ្យា', 2),
                newDetail(listTechnology),
                getCategories('កម្សាន្ត', 3),
                newDetail(listFun),
                getCategories('ព័ត៌មាន', 4),
                newDetail(listNews),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      drawer: Drawer(
        backgroundColor: Colors.brown,
        child: FutureBuilder(
          future: GetMenuList(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GetNews(
                            idmenu: int.parse(MyMenu[index]['id']),
                            Nmenu: MyMenu[index]['name'],
                          ),
                        ),
                      );
                    },
                    title: Text(
                      MyMenu[index]['name'],
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.brown,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases_rounded),
            label: 'News',
            backgroundColor: Colors.brown,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_label),
            label: 'Hot News',
            backgroundColor: Colors.brown,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
            backgroundColor: Colors.brown,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget newDetail(List ls) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 240,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ls.length,
            itemBuilder: (cosntext, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NewsDetail(id: int.parse(ls[index]['id']));
                  }));
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  padding: EdgeInsets.all(5),
                  height: double.infinity,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(207, 121, 85, 72),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            ls[index]['title'],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Image.network(
                            ls[index]['img'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget getCategories(String cateName, int menuId) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  cateName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.new_releases_outlined),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (con) {
                  return GetNews(idmenu: menuId, Nmenu: cateName);
                }));
              },
              child: const Text(
                'See more',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
