import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/entity/movie_detail_bean.dart';

import 'movie_entity.dart';
class MovieDetailPage extends StatefulWidget {


  final MovieSubjects movie;
  final Object imageTag;

  MovieDetailPage(this.movie, {
    required this.imageTag,
  });

  @override
  MovieDetailPageState createState() => MovieDetailPageState();
}

class MovieDetailPageState extends State<MovieDetailPage> {
  MovieDetailBean? movieDetail;


  @override
  Widget build(BuildContext context) {
    var content;
    if (movieDetail == null) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      content = setData(movieDetail!);
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Scrollbar(
          child: content,
        ),
      );
    }


    return Scaffold(
      appBar: AppBar(
        //注意这里的写法 widget.movie，拿到 MovieDetailPage
        title: Text(widget.movie.title!),
      ),
      body: content,
    );
  }

  @override
  void initState() {
    super.initState();
    getMovieDetailData();
  }

  getMovieDetailData() async {
    var dio = Dio();
    BaseOptions options = BaseOptions();
    options.baseUrl = "https://frodo.douban.com";
    https://frodo.douban.com/api/v2/movie/movieid?apiKey=054022eaeae0b00e0fc068c0c0a2102a
    options.connectTimeout = 5000;
    options.receiveTimeout = 3000;
    options.responseType = ResponseType.json;
    dio.options = options;
    try {
      if(widget.movie != null) {
        Response response = await dio.get(
            '/api/v2/movie/' + widget.movie.id!+'?apiKey=054022eaeae0b00e0fc068c0c0a2102a');
        print('url:'+response.realUri.toString());
        print(response.data);
        if (response.statusCode == HttpStatus.ok) {
          var data = response.data;
          // MovieEntity movieEntity = JsonConvert.fromJsonAsT<MovieEntity>(data);
          // if(movieEntity.subjects != null) {
          //   movies = movieEntity.subjects!;
          // }
        }
      }
    } catch (e) {
      print('ddd'+e.toString());

    }
    // var response = await http.get(
    //     'http://api.douban.com/v2/movie/subject/' + widget.movie.id);
    setState(() {
      // movieDetail = MovieDetailBean.allFromResponse(response.body);
    });
  }

  setData(MovieDetailBean movieDetail) {
    var movieImage = Hero(
      tag: widget.imageTag,
      child: Center(
        child: Image.network(
          movieDetail.smallImage,
          width: 120.0,
          height: 140.0,),
      ),
    );

    var movieMsg = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          movieDetail.title,
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14.0
          ),
        ),
        Text('导演：' + movieDetail.director),
        Text('主演：' + movieDetail.cast),
        Text(
          movieDetail.collectCount.toString() + '人看过',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.redAccent,),
        ),
        Text('评分：' + movieDetail.average.toString()),
        Text(
          '剧情简介：' + movieDetail.summary,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
        ),
      ],
    );
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: Scrollbar(
        child: Column(
          children: <Widget>[
            movieImage,
            movieMsg,
          ],
        ),
      ),
    );
  }
}