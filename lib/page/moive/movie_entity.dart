import 'package:untitled/generated/json/base/json_convert_content.dart';
import 'package:untitled/generated/json/base/json_field.dart';

class MovieEntity with JsonConvert<MovieEntity> {
	List<MovieSubjects>? subjects;
}

class MovieSubjects with JsonConvert<MovieSubjects> {
	@JSONField(name: "episodes_info")
	String? episodesInfo;
	String? rate;
	@JSONField(name: "cover_x")
	int? coverX;
	String? title;
	String? url;
	bool? playable;
	String? cover;
	String? id;
	@JSONField(name: "cover_y")
	int? coverY;
	@JSONField(name: "is_new")
	bool? isNew;
}
