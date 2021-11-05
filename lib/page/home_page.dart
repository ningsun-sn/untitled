import 'package:flutter/material.dart';
import 'package:untitled/page/moive/movie_list.dart';
import 'package:untitled/page/wechat/wechat_authors_page.dart';

import 'main/all_application_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}
class HomePageState extends State<HomePage>{
  int _tabIndex = 0;
  var _pageCur;
  @override
  void initState() {
    super.initState();
    _pageCur = PageController(initialPage: 0, keepPage: true);
  }
  @override
  void dispose() {
    _pageCur.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageCur,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          AllApplicationPage(),
          MovieList(),
          WeChatAuthorsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:  _tabIndex ,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        //ThemeData.primaryColor
//        selectedItemColor: Colors.deepPurpleAccent,
        items:const [
          BottomNavigationBarItem(icon:Icon(Icons.home),label:"首页"),
          BottomNavigationBarItem(icon:Icon(Icons.favorite),label:"喜欢"),
          BottomNavigationBarItem(icon:Icon(Icons.airport_shuttle),label:"公众号"),
        ] ,
        onTap: _onItemTapped,
      ),

    );

  }
  void _onItemTapped(int index){
      setState(() {
        _tabIndex = index;
        _pageCur.jumpToPage(index);
      });
  }
}