import 'package:flutter/material.dart';
import './SearchPage.dart';

class HomePage extends StatefulWidget {
	final String title;

	HomePage({Key key, this.title}) : super(key: key);

	@override
	HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController(text: 'london');

	void onSubmit(String text) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(title: 'Search', place: text),
      ),
    );
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
			),
			body: Center(
				child: Container(
					padding: EdgeInsets.all(30),
					margin: EdgeInsets.only(top: 65),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>[
							Container(
								margin: EdgeInsets.only(top:20), 
								child: Text(
									'Search for houses to buy!',
									style: TextStyle(fontSize: 16, color: Colors.grey[700])
                )
              ),
							Container(
								margin: EdgeInsets.only(top:20), 
								child: Text(
									'Search by place-name or postcode.',
									style: TextStyle(fontSize: 16, color: Colors.grey[700])
                )
              ),
							Container(
                margin: EdgeInsets.only(top: 30),
                width: 300,
					      child: TextField(
						      controller: controller,
						      decoration: InputDecoration(
    						    border: OutlineInputBorder(),
    						    labelText: 'Search via name or postcode',
  						    ),
						      onSubmitted: (String text) => onSubmit(text)
                ),
              ),
							Container(
								margin: EdgeInsets.only(top:20), 
								child: Image(image: AssetImage('images/house.png'))
              ),
						],
					),
				),
			),
		);
	}
}