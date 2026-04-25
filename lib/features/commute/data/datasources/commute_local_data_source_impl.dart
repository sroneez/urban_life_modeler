import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_life_modeler/core/errors/exceptions.dart';
import 'package:urban_life_modeler/features/commute/data/datasources/commute_local_data_source.dart';
import 'package:urban_life_modeler/features/commute/data/models/commute_model.dart';
import 'package:urban_life_modeler/features/commute/domain/entities/commute_profile.dart';

class CommuteLocalDataSourceImpl extends CommuteLocalDataSource {
  final SharedPreferences preferences;

  CommuteLocalDataSourceImpl({required this.preferences});

  @override
  Future<void> cacheCommuteProfile(CommuteModel profile) async {
    try {
      final json = profile.toJson();

      final profileData = jsonEncode(json);

      await preferences.setString('CACHED_COMMUTE', profileData);
    } catch (e) {
      throw CacheException('Failed to cache data: $e');
    }
  }

  @override
  Future<CommuteModel> getLastCommuteProfile() async {
    try {
      final jsonString = preferences.getString('CACHED_COMMUTE');
      if (jsonString != null) {
        final jsonMap = jsonDecode(jsonString);
        return CommuteModel.fromJson(jsonMap);
      } else {
        throw CacheException('No cached profile found');
      }
    } catch (e) {
      throw CacheException('Unexpected error:$e');
    }
  }
}
