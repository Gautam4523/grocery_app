import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/model.dart';
import '../product_controller.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          product.name ?? '',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            height: double.maxFinite,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffcf0b92),
                  Color(0xff9038c9),
                  Color(0xff5e4dee),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 220,
                  child: Image.asset(
                    product.image ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 220,
                  color: Colors.grey.shade100,
                  child: Column(
                    children: [
                      Text(
                        product.name ?? "",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}' ?? '',
                        style: TextStyle(color: Colors.green, fontSize: 14),
                      ),
                      if (product.discount > 0)
                        Text(
                          '${product.discount}% off' ?? '',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
