import 'package:dio/dio.dart';

final httpClient = Dio(
  BaseOptions(baseUrl: 'http://localhost:3000'),
);