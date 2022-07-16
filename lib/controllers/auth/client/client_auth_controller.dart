import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shura/api_services/auth_api.dart';
import 'package:shura/controllers/warning_Controller.dart';
import 'package:shura/models/auth/client/register_model.dart';
import 'package:shura/models/auth/client/user_model.dart';
import 'package:shura/responses/auth/client/client_register_response.dart';
import 'package:shura/responses/auth/client/user_response.dart';
import 'package:shura/view/main_app_screens/nav.dart';
// import 'package:shura/view/screens/main_app_screens/nav.dart';

class ClientAuthController extends GetxController with WarningController {
  var user = UserModel().obs;
  var reg = RegisterModel().obs;

  Future<void> login({required Map<String, dynamic> loginData}) async {
    showAlert("إجراء العمليات", "جاري معالجة طلبك", "opration");
    var response = await AuthApi.login(loginData: loginData);

    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        var userResponse = UserResponse.fromJson(response.data);
        await GetStorage().write('login_token', userResponse.token);
        await GetStorage().write('login_first', "is_loged");
        await GetStorage().write('gard', userResponse.user.type);
        user.value = userResponse.user;
        hideLoading();
        showAlert(
            "إجراء العمليات", "تم التعرف علي حسابك اهلا من جديد", "success");
        Timer(
          const Duration(seconds: 2),
          () {
            hideLoading();
            Get.offAll(() => Nav());
          },
        );
      } else {
        // print(GetStorage().read('login_first') == null);
        hideLoading();
        showAlert(
            "خطأ في الإدخال", "إسم المستخدم او كلمة المرور خطأ", "danger");
      }
    }
  } //end of login

  Future<void> register({required Map<String, dynamic> registerData}) async {
    showAlert("إجراء العمليات", "جاري معالجة طلبك", "opration");

    var response = await AuthApi.clientRegister(registerData: registerData);
    if (response.statusCode == 200) {
      if (response.data['status'] == 201) {
        var userResponse = ClinetRegisterResponse.fromJson(response.data);
        reg.value = userResponse.register;
        hideLoading();
        showAlert(
            "إجراء العمليات", "تم إنشاء  الحساب بنجاح اهلا  بك", "success");
        Timer(const Duration(seconds: 2), () {
          hideLoading();
          Get.back();
        });
      }
      if (response.data['status'] != 201) {
        hideLoading();
        showAlert(
            "خطأ في الإدخال", "إسم المستخدم او كلمة المرور خطأ", "danger");
      }
    }
  } //end of login
}
