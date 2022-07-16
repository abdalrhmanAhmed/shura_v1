// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_it;
import 'package:get_storage/get_storage.dart';

class Api {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://admin.shurasd.com/api/',
      receiveDataWhenStatusError: true,
    ),
  );

  static void initializeInterceptors() {
    dio.options.connectTimeout = 5000;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) async {
        var token = await GetStorage().read('login_token');

        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'contentTypeHeader': 'application/json',
          'Authorization': 'Bearer $token',
        };

        request.headers.addAll(headers);
        print('${request.method} ${request.path}');
        print('${request.headers}');
        return handler.next(request); //continue
      },
      onResponse: (response, handler) {
        print('${response.data}');
        if (response.data['error'] == 1) throw response.data['message'];

        return handler.next(response); // continue
      },
      onError: (error, handler) {
        if (get_it.Get.isDialogOpen == true) {
          get_it.Get.back();
        }
        get_it.Get.snackbar(
          'خطأ',
          'هنالك خطأ في الإتصال',
          snackPosition: get_it.SnackPosition.BOTTOM,
          colorText: Colors.black,
        );
        // GET.Get.snackbar(
        //   'error'.tr,
        //   '${error.message}',
        //   snackPosition: GET.SnackPosition.BOTTOM,
        //   colorText: Colors.black,
        // );

        return handler.next(error); //continue
      },
    ));
  } // end of initializeInterceptor

  static Future<Response> getCategories() async {
    return dio.post('categuries');
  } //end of getcateguries

  static Future<Response> getServices({required int catId}) async {
    return dio.post('services', queryParameters: {'categurie_id': catId});
  } //end of getServices

  static Future<Response> getAllServices() async {
    return dio.get('services/all');
  } //end of getServices

  static Future<Response> getConsle({required int serviceId}) async {
    return dio.post('service/consoles', data: {'service_id': serviceId});
  } //end of getConsoles

  static Future<Response> orderCreate(
      {required Map<String, dynamic> orderData}) async {
    FormData formData = FormData.fromMap(orderData);
    return dio.post('orders/create', data: formData);
  } //end of orderCreate

  static Future<Response> getConsoleOrders() async {
    return dio.post('console/orders');
  } //end of getConsoleOrders

  static Future<Response> clientOrders() async {
    return dio.post('client/orders');
  } //end of getConsoleOrders

  static Future<Response> activeOrder({required int orderId}) async {
    return dio.post('orders/confirm', data: {'order_id': orderId});
  } //end of activeOrder

  static Future<Response> getUser() async {
    return dio.get('user');
  } //end of getUser

} //end of api
