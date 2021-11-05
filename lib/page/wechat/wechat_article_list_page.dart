import 'package:flutter/material.dart';
import 'package:untitled/entiey/article_entity.dart';
import 'package:untitled/manager/api_manager.dart';
import 'package:untitled/wiget/item_wechat_article.dart';

/// 微信文章列表页
class WechatArticleListPage extends StatefulWidget {
  int cid = 0;

  WechatArticleListPage(this.cid);

  @override
  State<StatefulWidget> createState() {
    return _WechatArticleListState();
  }
}

class _WechatArticleListState extends State<WechatArticleListPage> with SingleTickerProviderStateMixin {
  List<ArticleEntity> articles = [];
  final ScrollController _scrollController = ScrollController();
  bool isPerformingRequest = false; // 是否有请求正在进行
  int index = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        index++;
        getList();
      }
    });
    getList();

  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
     physics: const AlwaysScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int position){
        return WechatArticleItem(articles[position]);
      },
      controller: _scrollController,
    );
  }

  /// 网络请求，获取微信文章列表
  void getList() async {
    await ApiManager().getWechatArticle(widget.cid, index)
        .then((response){
          print('response:'+response.toString());
          if(response != null){
            setState(() {
              articles.addAll(response);
            });
          }
    });
  }


  @override
  bool get wantKeepAlive => true;

}
