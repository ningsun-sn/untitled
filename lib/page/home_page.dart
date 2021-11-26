import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/page/movie/movie_list.dart';
import 'package:untitled/page/wechat/wechat_authors_page.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'main/all_application_page.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}
class HomePageState extends State<HomePage>{
  late Map<String, Object> _locationResult;
  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();
  late StreamSubscription<Map<String, Object>> _locationListener;
  int _tabIndex = 0;
  late var _pageCur;
  @override
  void initState(){
    super.initState();
    requestPermission();
    _pageCur = PageController(initialPage: 0, keepPage: true);
  }

  void _initLocation(){
    AMapFlutterLocation.updatePrivacyShow(true, true);
    AMapFlutterLocation.updatePrivacyAgree(true);

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }
    ///注册定位结果监听
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      print(result.toString());
      setState(() {
        _locationResult = result;
      });
    });
  }

  ///开始定位
  void _startLocation() {
    if (null != _locationPlugin) {
      ///开始定位之前设置定位参数
      _setLocationOption();
      _locationPlugin.startLocation();
    }
  }

  ///停止定位
  void _stopLocation() {
    if (null != _locationPlugin) {
      _locationPlugin.stopLocation();
    }
  }

  void _setLocationOption(){
    if (null != _locationPlugin) {
      AMapLocationOption locationOption = new AMapLocationOption();
      locationOption.onceLocation = false;
      locationOption.needAddress = true;
      locationOption.geoLanguage = GeoLanguage.DEFAULT;
      locationOption.desiredLocationAccuracyAuthorizationMode =
          AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

      locationOption.fullAccuracyPurposeKey = "AMapLocationScene";
      locationOption.locationInterval = 20000;
      locationOption.locationMode = AMapLocationMode.Hight_Accuracy;
      ///设置iOS端
      locationOption.distanceFilter = -1;
      locationOption.desiredAccuracy = DesiredAccuracy.Best;
      locationOption.pausesLocationUpdatesAutomatically = false;

      _locationPlugin.setLocationOption(locationOption);
    }
  }
  ///获取iOS native的accuracyAuthorization类型
  void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
    await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
      _initLocation();
      _startLocation();
    } else {
      print("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请

      status = await Permission.location.request();
      print("status$status");
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
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