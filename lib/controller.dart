import 'package:get/get.dart';
import 'package:grocery_app/product_guid_page.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  // Add validation
  bool validate() {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return false;
    }
    return true;
  }

  // Dummy login function
  void login() {
    if (validate()) {
      // Navigate to product grid after login
      Get.to(ProductGridPage());
    }
  }
}
