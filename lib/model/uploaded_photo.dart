import 'package:flutter/foundation.dart';

class UploadedPhoto {
  String? caption;
  String? image_file;

  UploadedPhoto({
    @required this.caption,
    @required this.image_file,
  });

  factory UploadedPhoto.fromJson(Map<String, dynamic> json) => UploadedPhoto(
        caption: json["caption"],
        image_file: json["image_file"],
      );
}
