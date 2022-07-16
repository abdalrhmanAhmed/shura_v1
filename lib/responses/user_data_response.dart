import 'package:shura/models/user_data_model.dart';

class UserDataResponse {
  late UserDataModel user;

  UserDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 200) {
      user = UserDataModel.fromJson(json['data']);
    }
  }
} //end of response