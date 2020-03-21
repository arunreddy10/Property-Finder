import 'package:flutter/material.dart';
import '../models/ListItemModel.dart';

class ListItemWidget extends StatelessWidget {
  final ListItemModel item;

  ListItemWidget({Key key, this.item}) : super(key: key);
  
	@override
	Widget build(BuildContext context) {
		return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [ 
        Container(
          margin: EdgeInsets.only(left: 10, right: 15),
          child: Image(
          image: NetworkImage(item.imageUrl),
            width: 80,
            height: 80 
          )
        ),
        Flexible(
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
        ),
      ]
    );
	}
}