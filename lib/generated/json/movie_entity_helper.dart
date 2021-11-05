import 'package:untitled/page/moive/movie_entity.dart';

movieEntityFromJson(MovieEntity data, Map<String, dynamic> json) {
	if (json['subjects'] != null) {
		data.subjects = (json['subjects'] as List).map((v) => MovieSubjects().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> movieEntityToJson(MovieEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['subjects'] =  entity.subjects?.map((v) => v.toJson())?.toList();
	return data;
}

movieSubjectsFromJson(MovieSubjects data, Map<String, dynamic> json) {
	if (json['episodes_info'] != null) {
		data.episodesInfo = json['episodes_info'].toString();
	}
	if (json['rate'] != null) {
		data.rate = json['rate'].toString();
	}
	if (json['cover_x'] != null) {
		data.coverX = json['cover_x'] is String
				? int.tryParse(json['cover_x'])
				: json['cover_x'].toInt();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['url'] != null) {
		data.url = json['url'].toString();
	}
	if (json['playable'] != null) {
		data.playable = json['playable'];
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['cover_y'] != null) {
		data.coverY = json['cover_y'] is String
				? int.tryParse(json['cover_y'])
				: json['cover_y'].toInt();
	}
	if (json['is_new'] != null) {
		data.isNew = json['is_new'];
	}
	return data;
}

Map<String, dynamic> movieSubjectsToJson(MovieSubjects entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['episodes_info'] = entity.episodesInfo;
	data['rate'] = entity.rate;
	data['cover_x'] = entity.coverX;
	data['title'] = entity.title;
	data['url'] = entity.url;
	data['playable'] = entity.playable;
	data['cover'] = entity.cover;
	data['id'] = entity.id;
	data['cover_y'] = entity.coverY;
	data['is_new'] = entity.isNew;
	return data;
}