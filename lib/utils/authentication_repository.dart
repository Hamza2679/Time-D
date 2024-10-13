import 'package:delivery_app/fetures/home/pages/main_page.dart';
import 'package:delivery_app/fetures/splash_screen/pages/splash_screen1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxService {
  RxBool isLoggedIn = false.obs;

  static AuthenticationRepository get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    _checkAuthenticationStatus();
  }

  Future<void> _checkAuthenticationStatus() async {
    await Future.delayed(Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    if (token != null && token.isNotEmpty) {
      isLoggedIn.value = true;
      Get.offAll(() => MainPage());
      print("the token :"+token);
    } else {
      isLoggedIn.value = false;
      Get.offAll(() => SplashScreen1());
    }
  }

  Future<void> saveUserData(String token, Map<String, dynamic> user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    await prefs.setString('userId', user['id'] ?? '');
    await prefs.setString('phone', user['phone'] ?? '');
    await prefs.setString('email', user['email'] ?? '');
    await prefs.setString('firstName', user['firstName'] ?? '');
    await prefs.setString('lastName', user['lastName'] ?? '');
    await prefs.setString('profileImage', user['profileImage'] ?? '');

    isLoggedIn.value = true;
    Get.offAll(() => MainPage());
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLoggedIn.value = false;
    Get.offAll(() => SplashScreen1());
  }
}
