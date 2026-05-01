import 'package:envied/envied.dart';

part 'env.g.dart';


@Envied(path:'.env')
abstract class Env{
  @EnviedField(varName: 'WEATHER_BASE_URL',obfuscate: true)
  static final String weatherBaseUrl = _Env.weatherBaseUrl;

  @EnviedField(varName: 'WEATHER_API_KEY', obfuscate: true)
  static final String weatherApiKey = _Env.weatherApiKey;
}