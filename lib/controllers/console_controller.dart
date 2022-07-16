import 'dart:async';

import 'package:get/get.dart';
import 'package:shura/api_services/api.dart';
import 'package:shura/controllers/main_controller.dart';
import 'package:shura/models/consele_model.dart';
import 'package:shura/responses/console_response.dart';

class ConsoleController extends GetxController {
  final maincontroller = Get.put(MainController());
  var isLoding = true.obs;
  var console = <ConsoleModel>[].obs;

  Future<void> getconsole(int servicesId) async {
    isLoding.value = true;
    var response = await Api.getConsle(serviceId: servicesId);
    if (response.data["msg"] == "Token is Expired") {
      // maincontroller.refreshToken();
      // Timer(Duration(seconds: 2),
      //     () async => response = await Api.getConsle(serviceId: servicesId));

      // print('Expired');
      // // RefreshTokenController.Refresh();
      maincontroller.logout();
    }
    var consoleResponse = ConsoleResponse.fromJson(response.data);
    console.clear();
    console.addAll(consoleResponse.console);
    isLoding.value = false;
  } //end of getGenres

} //end of controller
