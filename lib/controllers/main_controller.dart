import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shura/models/refresh_token_model.dart';
import 'package:shura/view/intro_app/introduction_animation/introduction_animation_screen.dart';
import 'package:shura/view/main_app_screens/nav.dart';
import 'package:shura/view/auth/we.dart';

class MainController extends GetxController {
  var nToken = RefreshTokenModel().obs;
  @override
  void onInit() async {
    redirect();
    super.onInit();
  }

  Future<void> redirect() async {
    var token = await GetStorage().read('login_token');
    var first = await GetStorage().read('login_first');

    if (token != null) {
      Get.off(
        () => Nav(),
        duration: Duration(seconds: 5),
        transition: Transition.native,
      );
    } //old clinet go to home
    if (token == null && first == null) {
      Get.off(
        () => IntroductionAnimationScreen(),
        duration: Duration(seconds: 5),
        transition: Transition.native,
      );
    } //new clinet go to interduction
    if (token == null && first != null) {
      Get.off(
        () => const We(),
        duration: const Duration(seconds: 5),
        transition: Transition.native,
      );
    } //old clinet go to we
  } //end redirect

  Future<void> logout() async {
    await GetStorage().remove('login_token');
    Get.offAll(() => We());
  } //end of logout

}
