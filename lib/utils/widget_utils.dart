import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/utils/color_utils.dart';

 class Constants {
  static Text titleStyle(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 16, color: Colors.white),
    );
  }

  static AppBar getAppBar(String appBarTitle) {
    return AppBar(
      title: Text(appBarTitle),
      backgroundColor: Colors.blue,
      //设置appbar背景颜色
      centerTitle: true, //设置标题是否局中
    );
  }

  static AppBar getAppBarWithAction(BuildContext context, String appBarTitle,
      [String action = ""]) {
      List colors = List.filled(3, null, growable: false);
      colors.add(Colors.cyan);
      colors.add(Colors.blue);
      colors.add(Colors.blueAccent);
      return AppBar(
        flexibleSpace: Container(
          // decoration: BoxDecoration(
          //   gradient:LinearGradient(
          //          begin: Alignment.topLeft,
          //          end: Alignment(0.8, 0.0),  // 10% of the width, so there are ten blinds.
          //         colors: [const Color(0xffee0000), const Color(0xffeeee00)], // red to yellow
          //     // tileMode: TileMode.repeated, // repeats the gradient over the canvas
          //   ),
          //
          //   // LinearGradient(
          //   //   colors
          //   // ),
          // ),
        ),
        title: Text(appBarTitle),
//        backgroundColor: Colors.blue,
        //设置appbar背景颜色
        centerTitle: true,
        //设置标题是否局中
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            //But don't use SystemNavigator.pop() for iOS, Apple says that the application should not exit itself :)
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                SystemNavigator.pop();
              }
            }),

        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 15),
            child: Center(
              child: Text(
                action,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      );
  }

  static Widget getGrayText(String text,[double size = 10]) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: ColorUtils.grayText,),
    );
  }


}
