import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {

  final Dio _dio = Dio();

  API() {
    _dio.options.baseUrl = "https://ppmilan.in/public/api/";
    _dio.interceptors.add(PrettyDioLogger(
      request: false,
      responseBody: false,
    ));
  }

  Dio get dio => _dio;
}