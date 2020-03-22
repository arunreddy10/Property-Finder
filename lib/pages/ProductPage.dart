import 'package:PropertyFinder/models/ListItemModel.dart';
import 'package:PropertyFinder/widgets/ProductDetailsWidget.dart';
import 'package:PropertyFinder/widgets/ProductPriceWidget.dart';
import 'package:PropertyFinder/widgets/ProductTitleWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductPage extends StatelessWidget {
  final ListItemModel listItem;

  ProductPage({Key key, this.listItem}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Property Finder"),
      ),
      body: Center(
        child: Column(
          children: <Widget> [
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, top: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[100], width: 1),
                boxShadow: <BoxShadow> [BoxShadow(color: Colors.blue[100], offset: Offset(3,3))]
              ),
              child:Image(
                image: NetworkImage(listItem.imageUrl),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            ProductTitleWidget(itemTitle: listItem.title, itemSummary: listItem.summary),
            Row(
              children: <Widget> [
                Flexible(flex: 6,
                  child: 
                    Column(children: <Widget> [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300], width: 1),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            ProductDetailsWidget(listItem: listItem)
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Text("Last Updated on:  " + listItem.lastUpdated,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(flex: 4,
                  child: ProductPriceWidget(itemPrice: listItem.price)
                )
              ]
            ),   
          ],
        ),
      ),
    );
  }
}