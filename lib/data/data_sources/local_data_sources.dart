import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSources {
  //save token in local
  Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
    log("Login Token: \n$token");
  }

  //get token from local
  Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token') ?? '';
    log("Local Token: \n$token");
    return token;
  }

  //remove token from local
  Future<void> removeToke() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    log("Token Removed");
  }
}
