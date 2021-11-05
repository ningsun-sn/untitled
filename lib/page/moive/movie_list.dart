import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled/generated/json/base/json_convert_content.dart';
import 'package:dio/dio.dart';
import 'movie_detail_page.dart';
import 'movie_entity.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListSate createState() => _MovieListSate();
}

class _MovieListSate extends State<MovieList> {
  List<MovieSubjects> movies =[];

  @override
  void initState() {
    super.initState();
    _getMovieList();
  }

  Future _getMovieList() async {
    var dio = Dio();
    BaseOptions options = BaseOptions();
    options.baseUrl = "https://movie.douban.com";
    options.connectTimeout = 5000;
    options.receiveTimeout = 3000;
    options.responseType = ResponseType.json;
    dio.options = options;
    try {
      Response response = await dio.get('/j/search_subjects?type=movie&tag=%E7%83%AD%E9%97%A8&sort=recommend&page_limit=100&page_start=0');
      // print(response.data);
      if(response.statusCode == HttpStatus.ok){
        var data = response.data;
        MovieEntity movieEntity = JsonConvert.fromJsonAsT<MovieEntity>(data);
        if(movieEntity.subjects != null) {
          movies = movieEntity.subjects!;
        }
      }
    } catch (e) {
      print(e);
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }

  Widget _buildSuggestions() {
    var body;
    if (movies.isEmpty) {
      body = const Center(
        // 可选参数 child:
        child: CircularProgressIndicator(),
      );
    } else {
      body = ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: movies.length,
        itemBuilder: buildMovieItem,
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("电影列表"),
        ),
        body: body);
  }

  Widget buildMovieItem(BuildContext context, int index) {
//    if (index.isOdd) return new Divider()
    MovieSubjects movie = movies[index];
    var viewItem = Card(
      color: Colors.white70,
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            movie.cover!,
            height: 120.0,
            width: 100.0,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ListTile(
                  title: Text(
                    movie.title!,
                  ),
                  subtitle: Text("评分：" + movie.rate!),
                ),
              ],
            ),
            flex: 1,
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ],
      ),
    );
    var movieItem = GestureDetector(
      //点击事件
      onTap: () =>  navigateToMovieDetailPage(movie, index),
      child: viewItem,
    );
    return movieItem;
  }
  // 跳转页面
  navigateToMovieDetailPage(MovieSubjects movie, Object imageTag) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) {
              return MovieDetailPage(movie, imageTag: imageTag);
            }
        )
    );
  }
}
