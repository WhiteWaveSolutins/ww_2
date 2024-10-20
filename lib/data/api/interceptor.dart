import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class AppInterceptor {
  static final talker = TalkerDioLogger(
    settings: const TalkerDioLoggerSettings(),
  );

  static final base = InterceptorsWrapper(
    onResponse: (options, handler) {
      //debugPrint('RESPONSE[${options.statusCode}]: PATH: ${options.requestOptions.path}');

      return handler.next(options);
    },
    onRequest: (RequestOptions options, handler) async {
      //debugPrint('REQUEST[${options.method}]: PATH: ${options.path}');
      //final token = await SecureStorageService().getToken();
      //if (token != null) options.headers['Authorization'] = 'Bearer ${token.accessToken}';
      return handler.next(options);
    },
    onError: (error, handler) {
      //debugPrint(
      //    'ERROR[${error.requestOptions.method}]: PATH: ${error.requestOptions.path}, MESSAGE ${error.message}');

      return handler.next(error);
    },
  );
}
