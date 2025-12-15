import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/common/exeptions.dart';

mixin HttpResponseValidator {
  validateResponse(Response response) {
    if (response.statusCode == null) {
      throw AppException(message: 'خطای نامشخص');
    }

    if (response.statusCode! < 200 || response.statusCode! >= 300) {
      final serverMessage =
          response.data is Map ? response.data['message'] : null;
      if (serverMessage == 'email already exists') {
        throw AppException(message: 'ایمیل تکراری است');
      }
      throw AppException(message: 'خطا در ارتباط با سرور');
    }
  }
}
