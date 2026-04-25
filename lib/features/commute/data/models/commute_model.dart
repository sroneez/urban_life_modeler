import 'package:urban_life_modeler/features/commute/domain/entities/commute_profile.dart';

class CommuteModel extends CommuteProfile {
  CommuteModel({
    required super.id,
    required super.departureTime,
    required super.durationMinutes,
    required super.transitMode,
  });

  factory CommuteModel.fromJson(Map<String, dynamic> json) {
    return CommuteModel(
      id: json['_id'] ?? json['id'],
      departureTime: DateTime.parse(json['departureTime']),
      durationMinutes: json['durationMinutes'],
      transitMode: json['transitMode'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'departureTime': departureTime.toIso8601String(),
    'durationMinutes': durationMinutes,
    'transitMode': transitMode,
  };
}
