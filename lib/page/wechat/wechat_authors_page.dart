import 'package:flutter/material.dart';
import 'package:untitled/entiey/we_chat_author_entity.dart';
import 'package:untitled/manager/api_manager.dart';
import 'package:untitled/page/wechat/wechat_article_list_page.dart';
import 'package:untitled/wiget/base_widget.dart';

class WeChatAuthorsPage extends StatefulWidget {
  @override
  WeChatAuthorsState createState() => WeChatAuthorsState();
}

class WeChatAuthorsState extends State<WeChatAuthorsPage> with TickerProviderStateMixin {
  List<WeChatAuthorEntity> list = [];
  List<Tab> myTabs = [];
  TabController? _tabController;

  /// 网络请求 获取推荐微信公众号
  Future _getWeChatCount() async {
    List<WeChatAuthorEntity> response =
    await ApiManager().getWechatCount();
    return response;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget((snapshot) {
        return _createListView(snapshot);
      }, _getWeChatCount(),
    );
  }


  Widget _createListView(AsyncSnapshot snapshot) {
    list = snapshot.data;
    myTabs.clear();
    for(var item in list){
      myTabs.add(Tab(text: item.name,));
    }
    _tabController = TabController(length: myTabs.length, vsync: this);
    return Column(
        children: <Widget>[
          TabBar(indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black45,
              controller: _tabController,tabs: myTabs, isScrollable: true),
          Expanded(
            flex: 1,
            child: TabBarView(
                controller: _tabController,
                children: _createPages(list)),
          )
          ]);
  }
  // 创建微信文章列表页
  List<Widget> _createPages(List<WeChatAuthorEntity> list) {
    List<Widget> widgets = [];
    for (WeChatAuthorEntity count in list) {
      var page = WechatArticleListPage(count.id!);
      widgets.add(page);
    }
    return widgets;
  }
}
