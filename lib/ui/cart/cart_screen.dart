import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week7_getx_upload/mixins/formatter.dart';
import 'package:week7_getx_upload/ui/cart/cart_controller.dart';
import 'package:week7_getx_upload/ui/cart/widgets/row_cart.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final _controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Cart",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          color: Colors.white,
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildList()),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Grand Total : Rp. " +
                            Formatter.format
                                .format(_controller.grand_total.value),
                        style: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(
                        () => InkWell(
                          onTap: () {
                            if (_controller.isLoading.value == false) {
                              _controller.proceedPost();
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                                child: Text(
                              _controller.isLoading.value
                                  ? "Loading.."
                                  : "Proceed",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          })),
    );
  }

  Widget _buildList() {
    return ListView.separated(
        itemBuilder: (ctx, index) => RowCart(
              airsoft: _controller.list[index],
              index: index,
            ),
        separatorBuilder: (ctx, index) => const Divider(),
        itemCount: _controller.list.length);
  }
}
