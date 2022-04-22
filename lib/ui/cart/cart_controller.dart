import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week7_getx_upload/mixins/formatter.dart';
import 'package:week7_getx_upload/model/airsoft.dart';
import 'package:week7_getx_upload/repository/upload_repository.dart';

class CartController extends GetxController {
  var isLoading = false.obs;
  final uploadRepository = Get.find<UploadRepository>();

  RxList<Airsoft> list = [
    Airsoft(
        id: 1,
        name: "Airsoft M14 AEG",
        price: 1000000,
        image: "assets/m14.jpg",
        qty: 0),
    Airsoft(
        id: 2,
        name: "Airsoft M1 Garrand GBB",
        price: 2000000,
        image: "assets/m1_garand.jpg",
        qty: 0),
    Airsoft(
        id: 3,
        name: "Airsoft Mosin Nagant Spring",
        price: 2800000,
        image: "assets/mosin_nagant.jpg",
        qty: 0),
    Airsoft(
        id: 4,
        name: "Airsoft AK47 AEG",
        price: 2700000,
        image: "assets/ak47.jpg",
        qty: 0),
    Airsoft(
        id: 5,
        name: "Airsoft M4 AEG",
        price: 3500000,
        qty: 0,
        image: "assets/m4.jpg"),
    Airsoft(
        id: 6,
        qty: 0,
        name: "Airsoft Dragunov GBB",
        price: 6000000,
        image: "assets/dragunov.jpg"),
  ].obs;

  RxInt grand_total = 0.obs;

  void showDialogSuccess(List<Airsoft> cart) {
    Get.defaultDialog(
        title: "Request Success",
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ))
        ],
        titleStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 17,
            fontWeight: FontWeight.bold),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 300,
              height: 200,
              child: ListView.separated(
                separatorBuilder: (_, i) => Divider(),
                itemCount: cart.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: Container(
                      width: 60,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(cart[index].image))),
                    ),
                    title: Text(
                      cart[index].name,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    subtitle: Text(
                      "Rp. " +
                          Formatter.format.format(cart[index].price) +
                          " x " +
                          cart[index].qty.toString(),
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontSize: 10),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  void proceedPost() {
    List<Airsoft> airsoftReq = list.value.where((element) {
      return element.qty > 0;
    }).toList();
    if (airsoftReq.isEmpty) {
      Get.snackbar("Pesan", "QTY Belum terisi !");
    } else {
      List<int> id_airsoft = [];
      for (int i = 0; i < airsoftReq.length; i++) {
        id_airsoft.add(i);
      }
      var requestJSON = json.encode({
        "ids": id_airsoft,
        "items": airsoftReq.map((e) => e.toJson()).toList(),
      });
      // Map<String, dynamic> request = {
      //   "ids": [1],
      //   "items": [
      //     {
      //       "id": 1,
      //       "name": "M14",
      //       "price": 300000,
      //       "qty": 4,
      //       "image": "assets/image.png"
      //     }
      //   ]
      // };

      // var encodedJSON = json.encode(request);

      isLoading.value = true;
      uploadRepository.postJSON(requestJSON).then((value) {
        isLoading.value = false;
        if (value.success == true) {
          showDialogSuccess(value.data!);

          ///kembalikan qty ke 0 semua
          for (int i = 0; i < list.length; i++) {
            list[i].qty = 0;
            list.refresh();
          }
          grand_total.value = 0;
        } else {
          Get.snackbar("Pesan", value.message!);
        }
      }).onError((error, stackTrace) {
        isLoading.value = false;
        Get.snackbar("Pesan", "Terjadi kesalahan pada Server");
        print("kesalahan $error $stackTrace");
      });
    }
  }

  void getGrandTotal() {
    grand_total.value = 0;
    for (int i = 0; i < list.length; i++) {
      grand_total = grand_total + (list[i].qty * list[i].price);
    }
  }

  ///row pada variable cart diupdate qtynya
  void updateQty(int index) async {
    list[index].qty++;
    list.refresh();
    getGrandTotal();
  }

  void minusQty(int index) async {
    if (list[index].qty >= 1) {
      list[index].qty--;
      list.refresh();
      getGrandTotal();
    }
  }

  @override
  void onInit() {
    getGrandTotal();
    // TODO: implement onInit
    super.onInit();
  }
}
