import 'dart:io';
import 'package:http/http.dart' as http;

String fetchQuery(String place) {
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

Future main() async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    3000,
  );
  print('Listening on localhost:${server.port}');

  await for (HttpRequest request in server) {
    if (request.uri.queryParameters.containsKey('place')) {
      String query = fetchQuery(request.uri.queryParameters['place']);
      http.Response response = await http.get('https://api.nestoria.co.uk/api?'+query)
        .catchError((err) {
          print(err);
        });
      request.response.headers.contentType = new ContentType("application", "json", charset: "utf-8");
      request.response.headers.add("Access-Control-Allow-Methods", "POST, OPTIONS, GET");
      request.response.headers.add("Access-Control-Allow-Origin", "*");
      request.response.headers.add('Access-Control-Allow-Headers', '*'); 
      response != null && response.body != null ? request.response.write(response.body) : request.response.write('');
      await request.response.close();
    }
  }
}
