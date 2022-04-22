import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week7_getx_upload/mixins/server.dart';
import 'package:week7_getx_upload/model/res/upload_res.dart';
import 'package:week7_getx_upload/repository/upload_repository.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  Rx<File> fileImagePicker = Rx(File(""));
  final ImagePicker _picker = ImagePicker();
  TextEditingController? captionController;
  UploadRepository uploadRepository = Get.find<UploadRepository>();
  var isLoading = false.obs;

  void choosePhotoFrom() {
    Get.defaultDialog(
        title: "Upload photo from...",
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              onTap: () {
                showImagePicker("gallery");
                Get.back();
              },
              title: Text("Gallery"),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                showImagePicker("camera");
                Get.back();
              },
              title: Text("Camera"),
            )
          ],
        ));
  }

  void showDialog(String imageurl, String caption) {
    Get.defaultDialog(
        title: "Upload Success",
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))))),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.white),
              ))
        ],
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                Server.alamat_gambar + imageurl,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              caption,
            )
          ],
        ));
  }

  void submitToServer() {
    if (fileImagePicker.value.existsSync()) {
      isLoading.value = true;
      uploadRepository
          .uploadPhoto(fileImagePicker.value, captionController!.text)
          .then((UploadRes value) {
        isLoading.value = false;
        if (value.success == true) {
          showDialog(
              value.uploadedPhoto!.image_file!, value.uploadedPhoto!.caption!);
        } else {
          Get.snackbar("Pesan", value.message!);
        }
      }).onError((error, stackTrace) {
        isLoading.value = false;
        print("Error $stackTrace  $error");
        Get.snackbar("Pesan", "Terjadi kesalahan pada Server !");
      });
    } else {
      Get.snackbar("Pesan", "Gambar masih kosong !");
    }
  }

  void showImagePicker(String from) async {
    if (from == "gallery") {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      fileImagePicker.value = File(image!.path);
    } else {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      fileImagePicker.value = File(image!.path);
    }
  }

  @override
  void onInit() {
    captionController = TextEditingController();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    captionController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
