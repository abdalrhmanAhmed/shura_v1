import 'dart:async';

import 'package:shura/api_services/auth_api.dart';
import 'package:shura/controllers/warning_Controller.dart';
import 'package:get/get.dart';
import 'package:shura/models/otp_model.dart';
import 'package:shura/responses/otp_response.dart';
// import 'package:shura/view/screens/auth/chang_password_screen.dart';
// import 'package:shura/view/screens/auth/forgot_password_verification_page.dart';

class OtpController extends GetxController with WarningController {
  var otp = OtpModel().obs;
  Future<void> getOtp({required String phone}) async {
    showAlert("إجراء العمليات", "جاري معالجة طلبك", "opration");
    var response = await AuthApi.getOtp(phone: phone);

    if (response.statusCode == 200) {
      if (response.data['status'] == 201) {
        var otpResponse = OtpResponse.fromJson(response.data);
        otp.value = otpResponse.otps;
        hideLoading();
        showAlert(
            "إجراء العمليات", "سيتم إرسال كود التحقق إلي رقم هاتفك", "success");
        Timer(const Duration(seconds: 2), () {
          hideLoading();
          // Get.to(() => ForgotPasswordVerificationPage(
          //       phone: phone,
          //     ));
        });
      } else {
        hideLoading();
        showAlert("خطأ في الإدخال", "رقم الهاتف هذا لا يملك حساب", "danger");
      }
    }
  } //end of getOtp

  Future<void> sendOtp({required String code, required String phone}) async {
    showAlert("إجراء العمليات", "جاري معالجة طلبك", "opration");
    var response = await AuthApi.sendOtp(phone: phone, code: code);

    if (response.statusCode == 200) {
      if (response.data['status'] == 201) {
        var otpResponse = OtpResponse.fromJson(response.data);
        otp.value = otpResponse.otps;
        hideLoading();
        showAlert("نجاح العملية", "تم التحقق من مطابقة الرقم", "success");
        Timer(const Duration(seconds: 2), () {
          hideLoading();
          // Get.to(() => ChangPasswordScreen());
        });
      } else {
        hideLoading();
        showAlert("خطأ في الإدخال", "رقم الهاتف هذا لا يملك حساب", "danger");
      }
    }
  } //end of login
}
