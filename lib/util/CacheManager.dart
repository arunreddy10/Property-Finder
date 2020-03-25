import 'dart:typed_data';
import 'dart:io';
import 'dart:convert';
import 'package:PropertyFinder/models/ListItemModel.dart';
import 'package:PropertyFinder/util/NetworkManager.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheManager extends BaseCacheManager {
  static const key = 'database';
  static final int maxNumberOfFiles = 50;
  static final Duration cacheTimeout = Duration(days: 1);
  static CacheManager _instance;

  factory CacheManager() {
    if (_instance == null) {
      _instance = CacheManager._();
    }
    return _instance;
  }

  CacheManager._() : super(key, maxNrOfCacheObjects: maxNumberOfFiles, maxAgeCacheObject: cacheTimeout) {
    _loadDatabase();
  }

  Future<List<ListItemModel> > getPropertyData(String place) async {
    String url = NetworkManager.getUrl(place);
    File file = await getSingleFile(url);
    if (file != null) {
      String response = await file.readAsString();
      return NetworkManager.getPropertiesFromResponse(response);
    }
    return List();
  }

  Future<String> _loadFileAsString(String location) async {
    return await  rootBundle.loadString(key);
  }

  Future<Uint8List> _loadFileAsBytes(String location) async {
    ByteData bytes = await rootBundle.load(key);
    return bytes.buffer.asUint8List();
  }

  void _loadDatabase() async {
    Map<String, String> database = json.decode(await _loadFileAsString('database/Database.json'));
    for (String place in database.keys) {
      String url = NetworkManager.getUrl(place);
      Uint8List response = await _loadFileAsBytes('database/'+database[place]+'.json');
      putFile(url, response);
    }
  }

  @override
  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return path.join(directory.path, key);
  }
}