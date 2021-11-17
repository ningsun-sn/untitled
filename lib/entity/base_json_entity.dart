import 'package:untitled/generated/json/base/json_convert_content.dart';

class BaseEntity<T> with JsonConvert<BaseEntity> {
	late T data;
	late int errorCode;
	late String errorMsg;
	@override
  String toString() {
    return 'data:$data';
  }

  BaseEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null&&json['data']!='null') {
      data = JsonConvert.fromJsonAsT<T>(json['data']);
      print('data:$data');
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }

}
