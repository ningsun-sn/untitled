import 'package:flutter/material.dart';
import 'package:untitled/entiey/article_entity.dart';
import 'package:untitled/page/wechat/webview_page.dart';

/// 微信文章列表条目
class WechatArticleItem extends StatefulWidget {
  ArticleEntity article;

  WechatArticleItem(this.article);

  @override
  State<StatefulWidget> createState() {
    return _WechatArticleState();
  }
}

class _WechatArticleState extends State<WechatArticleItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => WebViewPage(
                   widget.article.title, widget.article.link)));
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  widget.article.title.replaceAll("&rdquo;", "").replaceAll("&ldquo;", ""),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.access_time,
                    color: Colors.grey,
                    size: 15,
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          widget.article.niceDate,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ))
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Container(
              color: Colors.grey,
              height: 0.5,
            )
          ],
        ),
      ),
    );
  }
}
