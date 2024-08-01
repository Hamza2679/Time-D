import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'fetures/home/pages/main_page.dart';
import 'fetures/splash_screen/pages/splash_screen1.dart';

class AuthenticationRepository extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  late final Rx<User?> firebaseUser;

  static AuthenticationRepository get instance => Get.find();

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    String? token = await _storage.read(key: 'authToken');
    if (token != null) {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      int expiryTime = payload['exp'] * 1000;
      int currentTime = DateTime.now().millisecondsSinceEpoch;

      if (currentTime < expiryTime) {
        Get.offAll(() => MainPage());
        return;
      } else {
        await _storage.delete(key: 'authToken');
      }
    }

    user == null ? Get.offAll(() => SplashScreen1()) : Get.offAll(() => MainPage());
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'authToken', value: token);
  }

  Future<void> logout() async {
    await _storage.delete(key: 'authToken');
    await _auth.signOut();
  }
}
