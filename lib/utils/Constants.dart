import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 class Constants {
  static Text titleStyle(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 16, color: Colors.white),
    );
  }

//  static Color gradientColor(){
//    return ColorTween(
//       begin:Colors.blue,
//       end: Colors.blueAccent,
//     ).animate(new CurvedAnimation(parent: AnimationController(), curve: Interval(0, 1))).value;
//  }
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
      style: TextStyle(fontSize: size, color: Constants.grayText,),
    );
  }

  static getRandomColor() {
    return Color.fromARGB(255, Random.secure().nextInt(255),
        Random.secure().nextInt(255), Random.secure().nextInt(255));
  }

  static const Color blue = Color(0xff212121);
  static const Color primaryText = Color(0xff212121);
  static const Color blackText = Color(0xff333333);
  static const Color grayText = Color(0xff999999);
  static const Color grayBackground = Color(0xffEDEDED);
  static const Color grayDeepBackground = Color(0xffDEDEDE);
  static const Color dividerColor = Color(0xffBDBDBD);
  static const Color transparentGaryColor = Color(33333333);
}
