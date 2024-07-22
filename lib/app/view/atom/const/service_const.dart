import 'package:dio/dio.dart';

class ServiceConst {
  static const String baseUrl = 'https://equran.id/';
  static final dio = Dio(BaseOptions(baseUrl: baseUrl));
}
