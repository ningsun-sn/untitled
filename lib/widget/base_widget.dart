import 'package:flutter/material.dart';
import 'package:untitled/utils/widget_utils.dart';

import 'async_snapshot_widget.dart';

typedef SuccessWidget = Widget Function(AsyncSnapshot snapshot);

class BaseWidget extends StatelessWidget {
  String appBarTitle;
  SuccessWidget successWidget;
  Future getData;
  BaseWidget(this.successWidget, this.getData, [this.appBarTitle = ""]){
    print('BaseWidget$appBarTitle');
  }

  @override
  Widget build(BuildContext context) {
    return getView();
  }

  ///snapshot就是_calculation在时间轴上执行过程的状态快照
  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    return AsyncSnapshotWidget(snapshot: snapshot,
        successWidget: successWidget
    );
  }

  Widget getView() {
    if (appBarTitle == null) {
     return Scaffold(
          body: FutureBuilder(
            builder: _buildFuture,
            future: getData,
          ));
    } else {
      return Scaffold(
          appBar: Constants.getAppBar(appBarTitle),
          body: FutureBuilder(
            builder: _buildFuture,
            future: getData,
          ));
    }
  }
}