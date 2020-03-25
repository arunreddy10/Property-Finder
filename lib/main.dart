import 'package:PropertyFinder/util/CacheManager.dart';
import 'package:flutter/material.dart';
import './pages/HomePage.dart';
import './pages/SearchPage.dart';

void main() {
  runApp(App());
  CacheManager();
}

class App extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Property Finder',
     	theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Property Finder'),
      initialRoute: '/',
      routes: {
        '/results': (context) => SearchPage(title: 'Property Finder')
      }
    );
	}
}