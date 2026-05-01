import 'package:dio/dio.dart';
import '../env/env.dart';

class CustomAuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // OpenWeatherMap requires the API key as a query parameter named 'appid'
    // If you were using Bearer tokens, you would add it to options.headers['Authorization']
    options.queryParameters['appid'] = Env.weatherApiKey;

    // Pass the modified request onward
    super.onRequest(options, handler);
  }
}