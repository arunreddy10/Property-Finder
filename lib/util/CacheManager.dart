import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:PropertyFinder/models/ListItemModel.dart';
import 'package:PropertyFinder/util/NetworkManager.dart';
import 'package:flutter/services.dart' show rootBundle;

class CacheManager {
  static Map<String,String> _cache = Map();
  static CacheManager _instance;

  factory CacheManager() {
    if (_instance == null) {
      _instance = CacheManager._();
    }
    return _instance;
  }

  CacheManager._() {
    _loadDatabase();
  }

  List<ListItemModel> _getCachedData(String url) {
    if (_cache.containsKey(url)) {
      return NetworkManager.getPropertiesFromResponse(_cache[url]);
    }
    return List();
  }

  void _updateCache(String url, String response) {
    _cache[url] = response;
  }

  Future<List<ListItemModel> > getPropertyData(String place) async {
    String url = NetworkManager.getUrl(place.toLowerCase());
    http.Response response = await NetworkManager.fetchPropertyData(url);
    if (response != null && response.statusCode == 200) {
      List<ListItemModel> properties = NetworkManager.getPropertiesFromResponse(response.body);
      if (properties.isNotEmpty) {
        _updateCache(url, response.body);
        return properties;
      }
    }
    return _getCachedData(url);
  }

  Future<String> _loadFileAsString(String location) async {
    return await rootBundle.loadString(location);
  }

  void _loadDatabase() async {
    Map<String, dynamic> database = json.decode(await _loadFileAsString('database/Database.json'));
    for (String place in database.keys) {
      String url = NetworkManager.getUrl(place);
      String content = await _loadFileAsString('database/'+database[place]);
      Map<String, dynamic> jsonContent = json.decode(content);
      _cache[url] = json.encode(jsonContent['body']);
    }
  }
}