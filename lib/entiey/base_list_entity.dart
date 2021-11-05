import 'package:untitled/generated/json/base/json_convert_content.dart';

class BaseListEntity with JsonConvert<BaseListEntity> {
	late int curPage;
	late List<dynamic> datas;
	late int offset;
	late bool over;
	late int pageCount;
	late int size;
	late int total;
}
