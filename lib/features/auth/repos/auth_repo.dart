import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_workshop_tweet_app/core/config.dart';
import 'package:flutter_workshop_tweet_app/features/auth/models/user_model.dart';

class AuthRepo {
  static Future<UserModel?> getUserRepo(String uid) async {
    try {
      Dio dio = Dio();
      final response = await dio.get(Config.serverUrl + "user/$uid");

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        UserModel userModel = UserModel.fromMap(response.data);
        return userModel;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> createUserRepo(UserModel userModel) async {
    Dio dio = Dio();
    final response =
        await dio.post(Config.serverUrl + "user", data: userModel.toMap());
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      return true;
    } else {
      return false;
    }
  }
}
