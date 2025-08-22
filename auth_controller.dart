import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../services/firebase_auth_service.dart';
import '../views/home/object_list_screen.dart';
import '../views/auth/login_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuthService _authService = Get.find();

  var isLoading = false.obs;

  void loginWithPhone(String phone) async {
    isLoading(true);
    try {
      await _authService.sendSmsCode(phone);
      Get.to(() => OtpScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void verifyOtp(String smsCode) async {
    isLoading(true);
    try {
      await _authService.verifySmsCode(smsCode);
      Get.offAll(() => ObjectListScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void logout() async {
    await _authService.signOut();
    Get.offAll(() => LoginScreen());
  }
}
