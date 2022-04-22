import 'dart:convert';
import 'dart:io';
import 'package:week7_getx_upload/mixins/server.dart';
import 'package:week7_getx_upload/model/res/post_res.dart';
import 'package:http/http.dart' as http;
import 'package:week7_getx_upload/model/res/upload_res.dart';

class UploadRepository {
  Future<UploadRes> uploadPhoto(File file, String caption) async {
    var postUri = Uri.parse(Server.base_url + "airsoft/test_upload");
    var request = http.MultipartRequest("POST", postUri);
    //buat menambahkan headers..
    request.headers["Authorization"] = "Bearer your_token";

    request.files.add(
      http.MultipartFile(
        "file",
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split("/").last,
      ),
    );

    request.fields['caption'] = caption;

    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    if (response.body.isNotEmpty) {
      final responseData = json.decode(response.body);
      return UploadRes.fromJson(responseData);
    } else {
      throw Exception();
    }
  }

  Future<PostRes> postJSON(var encodeJSONParams) async {
    http.Response response = await http.post(
        Uri.parse(Server.base_url + "airsoft/test_post_json"),
        body: encodeJSONParams,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer token_"
        });
    if (response.body.isNotEmpty) {
      final responseData = json.decode(response.body);
      return PostRes.fromJson(responseData);
    } else {
      throw Exception();
    }
  }
}
