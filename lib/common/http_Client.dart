import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';

final httpClient = Dio(
  BaseOptions(
      baseUrl: 'http://localhost:3000',
      validateStatus: (status) => status != null),
)..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final authInfo = AuthRepository.authChangeNotifier.value;
      if (authInfo != null && authInfo.accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer ${authInfo.accessToken}';
      }
      handler.next(options);
    },
  ));
