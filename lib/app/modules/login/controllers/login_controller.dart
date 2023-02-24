import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tokoonline/app/utils/api.dart';

class LoginController extends GetxController {
  final _getConnect = GetConnect();
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authToken = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailContoller.dispose();
    passwordController.dispose();
  }
  // void increment() => count.value++;
  void loginNow() async {
    final response = await _getConnect.post(BaseUrl.auth,{
      'email': emailContoller.text,
      'password': passwordController.text,
    },
    );
    
    if (response.body['success'] == true) { 
      authToken.write('token', response.body['access_token']);
    } else { 
      Get.snackbar(
        'Error', 
        response.body['message'].toString(), 
        icon: const Icon(Icons.error), 
        backgroundColor: Colors.red, 
        colorText: Colors.white, 
        forwardAnimationCurve: Curves.bounceIn, 
        margin: const EdgeInsets.only( 
          top: 10,
          left: 5,
          right: 5,
        ),
      );
    }
  }
}