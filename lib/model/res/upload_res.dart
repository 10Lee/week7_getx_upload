import 'package:flutter/foundation.dart';
import 'package:week7_getx_upload/model/uploaded_photo.dart';

class UploadRes {
  bool? success;
  String? message;
  UploadedPhoto? uploadedPhoto;

  UploadRes({
    @required status,
    @required message,
    @required uploadedPhoto,
  });

  UploadRes.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"];

    if (json["data"] != null) {
      print("Kesini");
      uploadedPhoto = UploadedPhoto.fromJson(json["data"]);
    }
  }
}
