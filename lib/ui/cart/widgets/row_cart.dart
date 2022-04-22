import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week7_getx_upload/mixins/formatter.dart';
import 'package:week7_getx_upload/model/airsoft.dart';
import 'package:week7_getx_upload/ui/cart/cart_controller.dart';

class RowCart extends StatelessWidget {
  CartController controller = Get.find<CartController>();
  late Airsoft airsoft;
  late int index;
  RowCart({Key? key, required this.airsoft, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRowProduct();
  }

  Widget _buildRowProduct() {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(5.0),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(airsoft.image))),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    airsoft.name,
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text("Rp " + Formatter.format.format(airsoft.price),
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 13,
                          color: Colors.black)),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                      "Total - Rp " +
                          Formatter.format.format(airsoft.price * airsoft.qty),
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 13,
                          color: Colors.black)),
                  const SizedBox(
                    height: 7,
                  ),
                  _buildQty()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQty() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => controller.minusQty(index),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1)),
                child: const Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(
              width: 7,
            ),

            /// disi qty yang diambil dari object buku book_on_cart
            Text(airsoft.qty.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              width: 7,
            ),
            InkWell(
              onTap: () => controller.updateQty(index),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1)),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
