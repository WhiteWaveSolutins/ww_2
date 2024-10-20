import 'package:dio/dio.dart';
import 'package:ww_2/data/api/api_settings.dart';
import 'package:ww_2/data/api/interceptor.dart';

class Api {
  late Dio _client;

  Api() {
    _client = Dio(
      BaseOptions(
        baseUrl: ApiSettings.url,
        connectTimeout: const Duration(seconds: 30),
        headers: {
          'x-rapidapi-key': ApiSettings.key,
          'x-rapidapi-host': ApiSettings.host,
        },
      ),
    );

    _client.interceptors.add(AppInterceptor.talker);
    _client.interceptors.add(AppInterceptor.base);
  }

  Dio get api => _client;
}
