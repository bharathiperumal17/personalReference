import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  static const String tokenKey = 'token';
  static const String userid = "userid";

  Future<void> saveToken(String token, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
    await prefs.setString(userid, userId);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<String?> getUSerid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userid);
  }

  Future<void> clearUseridToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(userid);
  }

  Future<void> setPrefredIndex(List<dynamic> indexStock) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("IndexList", jsonEncode(indexStock));
  }

  Future<void> setHeatValue(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("check", value);
  }

  Future<int?> getHeatValue() async {
    final prefs = await SharedPreferences.getInstance();
    var index = prefs.getInt("check");

    return index;
  }

  Future<String?> getIndexList() async {
    final prefs = await SharedPreferences.getInstance();
    var index = prefs.getString("IndexList");

    return index;
  }

  Future<void> setExarr(List<dynamic> exarrList) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("exarr", jsonEncode(exarrList));
  }

  Future<String?> getExarr() async {
    final prefs = await SharedPreferences.getInstance();
    var index = prefs.getString("exarr");

    return index;
  }
}
