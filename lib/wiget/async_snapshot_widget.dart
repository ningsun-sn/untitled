
import 'package:flutter/material.dart';

typedef SuccessWidget=Widget Function(AsyncSnapshot snapshot);

class AsyncSnapshotWidget extends StatelessWidget {
  AsyncSnapshot snapshot;

  SuccessWidget successWidget;

  AsyncSnapshotWidget({required this.snapshot,required this.successWidget});

  @override
  Widget build(BuildContext context) {
    return _parseSnap();
  }

  Widget _parseSnap() {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return const Center(
          child: Text('准备加载...'),
        );
      case ConnectionState.active:
        print('active');
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.waiting:
        print('waiting');
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        return successWidget(snapshot);
    }
  }
}