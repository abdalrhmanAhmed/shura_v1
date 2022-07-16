import 'dart:async';

import 'package:get/get.dart';
import 'package:shura/api_services/api.dart';
import 'package:shura/controllers/warning_Controller.dart';
import 'package:shura/models/user_data_model.dart';
import 'package:shura/responses/user_data_response.dart';

class UserDataContoller extends GetxController with WarningController {
  var userData = UserDataModel().obs;
  var isLoding = false.obs;

  Future<void> getUserData() async {
    var response = await Api.getUser();
    isLoding.value = false;
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        var userResponse = UserDataResponse.fromJson(response.data);
        userData.value = userResponse.user;
        isLoding.value = true;
      } else {
        showAlert("خطأ في الإتصال",
            "انت تواجة مشكلة في الإتصا او بياناتك غير موجودة", "danger");
      }
    }
  } //end of getUserData
}
