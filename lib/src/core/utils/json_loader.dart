import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pond_care/src/core/utils/log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JsonLoader {
  static Future<List<T>> loadData<T>(
    String key,
    String assetPath,
    T Function(Map<String, dynamic>) fromMap,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final jsonData = prefs.getString(key);
    if (jsonData != null) {
      final List<dynamic> decodedJson = jsonDecode(jsonData) as List<dynamic>;
      logger.d(decodedJson);
      return decodedJson
          .whereType<Map<String, dynamic>>()
          .map((json) => fromMap(json))
          .toList();
    } else {
      final assetJson = await rootBundle.loadString(assetPath);
      prefs.setString(key, assetJson);
      logger.d(assetJson);
      return (json.decode(assetJson) as List<dynamic>)
          .map((e) => fromMap(e as Map<String, dynamic>))
          .toList();
    }
  }

  static Future<void> saveData<T>(
    String key,
    T item,
    Future<List<T>> Function() loadData,
    Map<String, dynamic> Function(T) toMap,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<T> itemList = await loadData();
    itemList.add(item);

    prefs.setString(key, json.encode(itemList.map(toMap).toList()));
  }

  static Future<void> removeData<T>(
    String key,
    T item,
    Future<List<T>> Function() loadData,
    Map<String, dynamic> Function(T) toMap,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<T> itemList = await loadData();

    itemList.remove(item);

    prefs.setString(key, json.encode(itemList.map(toMap).toList()));
  }

  static Future<void> modifyDataList<T>(
    String key,
    T item,
    Future<List<T>> Function() loadData,
    Map<String, dynamic> Function(T) toMap,
    Future<void> Function(List<T>) modifyAction,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<T> itemList = await loadData();

    await modifyAction(itemList);

    prefs.setString(key, json.encode(itemList.map(toMap).toList()));
  }
}
