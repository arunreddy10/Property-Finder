import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/ListItemModel.dart';

const TIMEOUT = 5;
class NetworkManager {
  static String getUrl(String place) {
    if(kIsWeb) {
      return _getLocalUrl(place);
    } else {
      return _getNestoriaUrl(place);
    }
  }

  static Future<http.Response> fetchPropertyData(String url) async {
    return await http.get(url)
      .timeout(Duration(seconds: TIMEOUT))
      .catchError((err) {
        print(err);
      }
    );
  }

  static List<ListItemModel> getPropertiesFromResponse(String body) {
    List<ListItemModel> results = List();
    if(body == null || body.isEmpty || body.startsWith('<')) {
      return results;
    }
    Map<String, dynamic> responseBody = json.decode(body);
    if (responseBody.containsKey('response')) {
      Map<String, dynamic> responseJson = responseBody['response'];
      if (responseJson.containsKey('listings')) {
        for (dynamic listing in responseJson['listings']) {
          results.add(ListItemModel(listing['title'], listing['img_url'], listing['price_formatted'], listing['summary'], listing['property_type'], 
            listing['updated_in_days_formatted'], listing['bathroom_number'].toString(), listing['bedroom_number'].toString(), 
            listing['car_spaces'].toString()));
        }
        if (results.isNotEmpty) {
          while(results.length <= 500) {
            int count = results.length;
            for (int i = 0; i < count; i++) {
              results.add(ListItemModel(results[i].title, results[i].imageUrl, results[i].price, results[i].summary, results[i].propertyType,
                results[i].lastUpdated, results[i].bathroomNumber, results[i].bedroomNumber, results[i].carSpaces));
            }
          }
        }
      }
    }
    return results;
  }

  static String _getNestoriaQuery(String place) {
    Map<String, String> requestData = {
      'country': 'uk',
      'pretty': '1',
      'encoding': 'json',
      'listing_type': 'buy',
      'action': 'search_listings',
      'page': '1',
      'place_name': place
    };
    return requestData.keys.map((key) => key + '=' + Uri.encodeComponent(requestData[key])).join('&'); 
  }

  static String _getLocalUrl(String place){
    return 'http://localhost:3000/?place='+place;
  }

  static String _getNestoriaUrl(String place){
    String query = _getNestoriaQuery(place);
    return 'https://api.nestoria.co.uk/api?'+query;
  }
}