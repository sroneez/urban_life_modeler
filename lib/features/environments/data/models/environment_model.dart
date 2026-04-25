import 'package:urban_life_modeler/features/environments/domain/entities/environment_state.dart';

class EnvironmentModel extends EnvironmentalState {
  EnvironmentModel({
    required super.locationId,
    required super.temperature,
    required super.weatherCondition,
    required super.aqiScore,
    required super.timeStamp,
  });

  factory EnvironmentModel.fromJson(Map<String, dynamic> json) {
    return EnvironmentModel(
      locationId: json['location_id'],
      temperature: json['temp_c'],
      weatherCondition: json['condition'],
      aqiScore: json['aqi_score'],
      timeStamp: DateTime.parse(json['last_updated']),
    );
  }
}