import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/model/model.dart';
import 'package:grocery_app/screen/product_details.dart';
import 'product_controller.dart';

class ProductGridPage extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

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
          'Products',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(() => Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xffcf0b92),
                Color(0xff9038c9),
                Color(0xff5e4dee),
              ],
            )),
            child: GestureDetector(
              onTap: () {},
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 3 : 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: controller.product.length,
                itemBuilder: (context, index) {
                  final product = controller.product[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                                product: controller.product[index]),
                          ));
                    },
                    child: Card(
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(product.image, fit: BoxFit.cover),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 14),
                                ),
                                if (product.discount > 0)
                                  Text(
                                    '${product.discount}% off',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )),
    );
  }
}
