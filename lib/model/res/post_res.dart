import 'package:flutter/foundation.dart';
import 'package:week7_getx_upload/model/airsoft.dart';

class PostRes {
  bool? success;
  String? message;
  List<Airsoft>? data;

  PostRes({
    @required this.success,
    @required this.message,
    @required this.data,
  });

  PostRes.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"];

    if (json["data"] != null) {
      List dataJSON = json["data"];
      data = dataJSON.map((e) => Airsoft.fromMap(e)).toList();
    }
  }
}
