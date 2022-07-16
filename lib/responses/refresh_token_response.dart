import 'package:shura/models/refresh_token_model.dart';
import 'package:get/get.dart';
import 'package:shura/controllers/main_controller.dart';

class RefreshTokenResponse {
  final mainController = Get.find<MainController>();
  late RefreshTokenModel nToken;
  RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    nToken = RefreshTokenModel.fromJson(json['access_token']);
  }
}
