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
      Map<String, dynamic> response = json.decode(_cache[url]);
      return NetworkManager.getPropertiesFromResponse(json.encode(response['body']));
    }
    return List();
  }

  Future<List<ListItemModel> > getPropertyData(String place) async {
    String url = NetworkManager.getUrl(place.toLowerCase());
    http.Response response = await NetworkManager.fetchPropertyData(url);
    List<ListItemModel> results = response != null && response.statusCode == 200 ? 
      NetworkManager.getPropertiesFromResponse(response.body) : _getCachedData(url);
    print(results.length);
    return results;
  }

  Future<String> _loadFileAsString(String location) async {
    return await rootBundle.loadString(location);
  }

  void _loadDatabase() async {
    Map<String, dynamic> database = json.decode(await _loadFileAsString('database/Database.json'));
    for (String place in database.keys) {
      String url = NetworkManager.getUrl(place);
      String response = await _loadFileAsString('database/'+database[place]);
      _cache[url] = response;
    }
  }
}