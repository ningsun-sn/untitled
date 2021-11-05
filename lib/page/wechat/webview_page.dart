import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {

  String url = "";
  String title = "";

  WebViewPage(this.title, this.url);

  @override
  State<StatefulWidget> createState() {
    return _WebViewState();
  }

}

class _WebViewState extends State<WebViewPage>{
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  @override
  void initState() {
    super.initState();
    print(widget.url);
  }
  @override
  void dispose() {
    super.dispose();
    flutterWebViewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebviewScaffold(
        url: widget.url,
        withZoom: true,
        withLocalStorage: true,
        withJavascript: true,
      ),
    );
  }
}