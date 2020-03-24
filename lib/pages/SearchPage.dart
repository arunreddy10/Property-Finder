import 'package:PropertyFinder/widgets/SearchResultsWidget.dart';
import 'package:flutter/material.dart';
import '../models/ListItemModel.dart';
import '../pages/ProductPage.dart';
import '../util/NetworkManager.dart';

class SearchPage extends StatefulWidget {
  final String title;
  final NetworkManager networkManager = NetworkManager();
  String place;
  List<ListItemModel> listings = List();
  bool isLoading = true;

  SearchPage({Key key, this.title, this.place}) : super(key: key);

  @override
	SearchPageState createState() => SearchPageState();

}

class SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController(text: 'london');

  void fetchProperties(String place) async {
    setState(() => {
      widget.isLoading = true
    });
    List<ListItemModel> response = await widget.networkManager.fetchPropertyData(place);
    setState(() => {
      widget.listings = response,
      widget.isLoading = false
    });
  }

  List<ListItemModel> getSimilarItemsForIndex(int index) {
    List<ListItemModel> similarItems = List();
    int current = index;
    while(similarItems.length < 7) {
      current = (current+1)%widget.listings.length;
      similarItems.add(widget.listings[current]);
    }
    return similarItems;
  }
  
  void onTap(ListItemModel listItem, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductPage(listItem: listItem, similarListItems: getSimilarItemsForIndex(index))
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchProperties(widget.place);
  }

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
			),
			body: Center(
				child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: 10, bottom: 10, right: 10), 
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Search via name or postcode',
                      ),
                      onSubmitted: (String text) => fetchProperties(text)
                    ),
                  )
                )
              ]
            ), 
            widget.isLoading ? Container(
              margin: EdgeInsets.only(top: 200),
              child: CircularProgressIndicator()
            ) : widget.listings.isEmpty ? Column(
              children: <Widget> [
                Container(
                  margin: EdgeInsets.only(top: 150),
                  child: Text(
                    'Please enter a valid location',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20
                    )
                  )
                ),
                Container(
								  margin: EdgeInsets.only(top:20), 
								  child: Image(image: AssetImage('images/house.png'))
                ),
              ]
            ) : Flexible(
              child: SearchResultsWidget(listings: widget.listings, onTap: onTap)
            )
          ]
				),
			),
		);
	}
}