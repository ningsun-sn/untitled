import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:untitled/entiey/article_entity.dart';
import 'package:untitled/entiey/base_json_entity.dart';
import 'package:untitled/entiey/base_list_entity.dart';
import 'package:untitled/entiey/we_chat_author_entity.dart';

class ApiManager {
  Dio? _dio;

  factory ApiManager() => _getInstance()!;
  static ApiManager? _instance;

  ApiManager._internal() {
    var options = BaseOptions(
        baseUrl: "https://www.wanandroid.com/",
        connectTimeout: 10000,
        receiveTimeout: 3000);
    _dio = Dio(options);
    (_dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client){
      client.findProxy = (url){
        return "PROXY 192.168.0.119:8888";
      };
      //抓Https包设置
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
  }

  static ApiManager? _getInstance() {
    _instance ??= ApiManager._internal();
    return _instance;
  }

  static ApiManager? get instance => _getInstance();

  /// 获取推荐微信公众号
  Future<List<WeChatAuthorEntity>> getWechatCount() async {
    try {
      Response response = await _dio!.get("wxarticle/chapters/json");
      BaseEntity<List<WeChatAuthorEntity>> baseEntity = BaseEntity.fromJson(response.data);
      return baseEntity.data;
    } catch (e) {
      return <WeChatAuthorEntity>[];
    }
  }

  /// 获取微信文章列表
  Future<List<ArticleEntity>> getWechatArticle(int cid, int page) async {
    try {
      Response response = await _dio!.get("wxarticle/list/$cid/$page/json");
      print("response${response.data}");
      BaseEntity<BaseListEntity> baseEntity = BaseEntity.fromJson(response.data);
      List<ArticleEntity> list = baseEntity.data.datas.map((e) => ArticleEntity().fromJson(e)).toList();
      return list;
    } catch (e) {
      return [];
    }
  }

  /// 获取项目分类
  Future<Response?> getProjectClassify() async {
    try {
      Response response = await _dio!.get("project/tree/json");
      return response;
    } catch (e) {
      return null;
    }
  }

  /// 获取项目列表
  Future<Response?> getProjectList(int cid, int page) async {
    try {
      Response response = await _dio!.get("project/list/$page/json", queryParameters: {"cid": "$cid"});
      return response;
    } catch (e) {
      return null;
    }
  }

  /// 获取首页Banner
  Future<Response?> getHomeBanner() async {
    try {
      Response response = await _dio!.get("banner/json");
      return response;
    } catch (e) {
      return null;
    }
  }

  /// 获取首页文章列表
  Future<Response?> getHomeArticle(int page) async {
    try {
      Response response = await _dio!.get("article/list/$page/json");
      return response;
    } catch (e) {
      return null;
    }
  }
}
