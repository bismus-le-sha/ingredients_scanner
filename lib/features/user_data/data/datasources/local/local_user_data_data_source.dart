import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/core_consts.dart';
import '../../../../../core/error/exceptions.dart';
import '../../models/user_data_model.dart';

abstract class LocalUserDataDataSource {
  Future<UserDataModel> getLastUserData();
  Future<Unit> cacheUserData(UserDataModel userDataModel);
}

class LocalUserDataDataSourceImpl implements LocalUserDataDataSource {
  final SharedPreferences sharedPreferences;

  LocalUserDataDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserDataModel> getLastUserData() {
    final jsonString = sharedPreferences.getString(CACHE_USER_DATA);
    if (jsonString != null) {
      return Future.value(UserDataModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<Unit> cacheUserData(UserDataModel userDataModel) {
    sharedPreferences.setString(
        CACHE_USER_DATA, jsonEncode(userDataModel.toJson()));
    return Future.value(unit);
  }
}
