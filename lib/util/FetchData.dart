import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ListItemModel.dart';

Future<List<ListItemModel> > fetchPropertyData(String place) async {
  List<ListItemModel> results = List();
  http.Response response = await http.get('http://localhost:3000/?place='+place);
  Map<String, dynamic> responseBody = json.decode(response.body);
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