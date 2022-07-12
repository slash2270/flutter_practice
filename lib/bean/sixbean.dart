import 'dart:core';
import '../utils/constants.dart';

class SixBean{

  int id = 0;
  String title = '';
  String content = '';

  SixBean(this.id, this.title, this.content);

  SixBean.fromJson(Map<String, dynamic> json) {
    id = json[Constants.photosId];
    title = json[Constants.photosTitle];
    content = json[Constants.photosContent];
  }

  Map<String, dynamic> toJson() =>
    <String, dynamic> {
      Constants.photosId: id,
      Constants.photosTitle: title,
      Constants.photosContent: content
    };

}