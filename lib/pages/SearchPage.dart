import 'package:flutter/material.dart';
import '../models/ListItemModel.dart';
import '../util/FetchData.dart';
import '../widgets/ListItemWidget.dart';

class SearchPage extends StatefulWidget {
  final String title;
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
    List<ListItemModel> response = await fetchPropertyData(place);
    setState(() => {
      widget.listings = response,
      widget.isLoading = false
    });
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
            widget.isLoading ? 
              Container(
                margin: EdgeInsets.only(top: 200),
                child: CircularProgressIndicator()
              ) : Flexible(
                child: ListView.separated(
                  itemCount: widget.listings.length,
                  itemBuilder: ((context, index) => ListItemWidget(item: widget.listings[index])),
                  separatorBuilder: ((context, index) => Divider(color: Colors.grey, thickness: 1)),
                  shrinkWrap: true,
                )
              )
          ]
				),
			),
		);
	}
}