import 'package:flutter/material.dart';
import '../models/ListItemModel.dart';

class ListItemWidget extends StatelessWidget {
  final ListItemModel item;

  ListItemWidget({Key key, this.item}) : super(key: key);
  
	@override
	Widget build(BuildContext context) {
		return GestureDetector (
      onTap: () {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('You pressed an item')));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [ 
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Image(
            image: NetworkImage(item.imageUrl),
              width: 80,
              height: 80 
            )
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      item.price,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent)
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      item.title,
                      style: TextStyle(fontSize: 15, color: Colors.grey[700])
                    )
                  )
                ]
              )
            )
          ),
        ]
      )
    );
	}
}