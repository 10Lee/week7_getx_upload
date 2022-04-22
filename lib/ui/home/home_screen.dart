import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  final _controller = Get.find<HomeController>();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Photo"),
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed("/cart");
            },
            child: const Icon(Icons.shopping_cart),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Obx(() {
                if (_controller.fileImagePicker.value.existsSync()) {
                  return InkWell(
                    onTap: () {
                      _controller.choosePhotoFrom();
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.file(
                        _controller.fileImagePicker.value,
                        height: 300,
                        width: 300,
                      ),
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      _controller.choosePhotoFrom();
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        "assets/no_image.png",
                        height: 300,
                        width: 300,
                      ),
                    ),
                  );
                }
              }),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _controller.captionController,
                decoration: const InputDecoration(hintText: "Caption"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))))),
                  onPressed: () {
                    _controller.submitToServer();
                  },
                  child: Obx(() {
                    if (_controller.isLoading.value == true) {
                      return const Text(
                        "Uploading...",
                        style: TextStyle(color: Colors.white),
                      );
                    } else {
                      return const Text(
                        "Upload To Server",
                        style: TextStyle(color: Colors.white),
                      );
                    }
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
