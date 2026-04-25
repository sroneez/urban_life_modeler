class CommuteProfile {
  final String id;
  final DateTime departureTime;
  final int durationMinutes;
  final String transitMode;

  CommuteProfile({
    required this.id,
    required this.departureTime,
    required this.durationMinutes,
    required this.transitMode,
  });
}
