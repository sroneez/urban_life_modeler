class EnvironmentalState {
  final String locationId;
  final String temperature;
  final String weatherCondition;
  final String aqiScore;
  final DateTime timeStamp;

  EnvironmentalState({
    required this.locationId,
    required this.temperature,
    required this.weatherCondition,
    required this.aqiScore,
    required this.timeStamp,
  });
}
