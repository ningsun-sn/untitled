import 'package:flutter/material.dart';
import 'package:untitled/utils/Constants.dart';

import 'Gase2048Page.dart';

class AllApplicationPage extends StatefulWidget {
  @override
  AllApplicationState createState() => AllApplicationState();
}
class ApplicationBean{
  IconData iconData;
  String title;

  ApplicationBean(this.iconData, this.title);
}
class AllApplicationState extends State {
  final _list = <ApplicationBean>[];

  @override
  void initState() {
    super.initState();
    _list.add(ApplicationBean(Icons.access_time, "聊天"));
    _list.add(ApplicationBean(Icons.add, "demo"));
    _list.add(ApplicationBean(Icons.movie, "movie"));
    _list.add(ApplicationBean(Icons.stop, "布局"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("测试"),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: <Widget>[
            GridView.custom(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _itemWidget(index);
                  },
                  childCount: _list.length,
                ),
                shrinkWrap: true),
            const Padding(padding: EdgeInsets.only(top: 2.0)),
            GridView.count(
                crossAxisSpacing: 2.0,
                crossAxisCount: 4,
                children: <Widget>[
                  _itemWidget(0),
                  _itemWidget(1),
                  _itemWidget(2),
                  _itemWidget(3),
                ],
                shrinkWrap: true),
            const Padding(padding: EdgeInsets.only(top: 2.0)),
            GridView.extent(maxCrossAxisExtent: MediaQuery.of(context).size.width/4,
                crossAxisSpacing: 2.0,
                children: <Widget>[
                  _itemWidget(0),
                  _itemWidget(1),
                  _itemWidget(2),
                  _itemWidget(3),
                ],
                shrinkWrap: true)
          ],
        ));
  }

  getItemView() {
    for (var item in _list) {
      _itemWidget(_list.indexOf(item));
    }
  }

  Widget _itemWidget(int index) {
    return GestureDetector(
      onTap: () {
        navigateToMovieDetailPage(index);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _list[index].iconData,
                  color: Constants.getRandomColor(),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _list[index].title,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          )),

    );
  }

  // 跳转页面
  navigateToMovieDetailPage(int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      // if (index == 0) {
      //   return GroupChatPage();
      // } else if (index == 1) {
      //   return LoginPage();
      // } else if (index == 2) {
      //   return MovieList();
      // } else if (index == 3) {
      //   return SampleApp();
      // } else {
        return Gase2048Page();
      // }
    }));
  }

}
