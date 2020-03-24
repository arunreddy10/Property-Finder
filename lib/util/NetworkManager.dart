import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/ListItemModel.dart';

const int TIMEOUT = 5;

class NetworkManager {
  Future<List<ListItemModel> > fetchPropertyData(String place) async {
    if (kIsWeb) {
      return _fetchPropertyDataFromLocal(place);
    } else {
      return _fetchPropertyDataFromNestoria(place);
    }
  }

  String _fetchQuery(String place) {
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

  List<ListItemModel> _getPropertiesFromResponse(String body) {
    List<ListItemModel> results = List();
    if(body.isEmpty || body.startsWith('<')) {
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

  List<ListItemModel> _handleResponse(http.Response response) {
    return response != null && response.statusCode == 200 ? _getPropertiesFromResponse(response.body) : List();
  }

  Future<List<ListItemModel> > _fetchPropertyDataFromNestoria(String place) async {
    String query = _fetchQuery(place);
    http.Response response = await http.get('https://api.nestoria.co.uk/api?'+query)
      .timeout(Duration(seconds: TIMEOUT))
      .catchError((err) {
        print(err);
      });
    return _handleResponse(response);
  }

  Future<List<ListItemModel> > _fetchPropertyDataFromLocal(String place) async {
    http.Response response = await http.get('http://localhost:3000/?place='+place)
      .timeout(Duration(seconds: TIMEOUT))
      .catchError((err) {
        print(err);
      });
    return _handleResponse(response);
  }
}