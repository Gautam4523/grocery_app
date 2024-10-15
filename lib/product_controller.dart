import 'package:get/get.dart';

import 'model/model.dart';

class ProductController extends GetxController {
  RxList<Product> _productList = RxList([
    Product('Apple', 1.99, 'images/apple.jpg', discount: 10),
    Product('Banana', 0.99, 'images/banana.jpg', discount: 8),
    Product('Orange', 2.99, 'images/orange.jpg', discount: 5),
    Product('Mango', 3.49, 'images/mango.jpg', discount: 6),
  ]);

  List<Product> get product => _productList;

  setProduct(List<Product> value) {
    _productList.addAll(value);
  }
}
