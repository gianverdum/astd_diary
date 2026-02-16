import 'package:http_interceptor/http_interceptor.dart';
import 'dart:developer';

import 'package:logger/logger.dart';

class LoggerInterceptor extends InterceptorContract {
  Logger logger = Logger();

  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    log('----- Request -----');
    log(request.toString());
    log(request.headers.toString());
    if (request is Request) {
      log('Body: ${request.body}');
    }
    // if (request is Request) {
    //   logger.t('Making a ${request.method} to the URL: ${request.url}\nHeaders: ${request.headers}\nBody: ${Uri.decodeComponent(request.body)}');
    // }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    // if (response.statusCode ~/ 100 ==2){
    //   logger.i('Received a response with status code: ${response.statusCode}');
    // } else if (response.statusCode ~/ 100 == 4) {
    //   logger.w('Received a client error with status code: ${response.statusCode}');
    // } else if (response.statusCode ~/ 100 == 5) {
    //   logger.e('Received a server error with status code: ${response.statusCode}');
    // }
    log('----- Response -----');
    log('Code: ${response.statusCode}');
    if (response is Response) {
      log((response).body);
    }
    // if (response is Response) {
    //   logger.t('Response with status code: ${response.statusCode}\nBody: ${response.body}');
    // }
    return response;
  }
}
