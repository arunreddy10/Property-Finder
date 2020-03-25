import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:PropertyFinder/widgets/SnackBarWidget.dart';

class ProductPriceWidget extends StatelessWidget {
  final String itemPrice;

  ProductPriceWidget({Key key, this.itemPrice}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget> [
      Container(alignment: Alignment.center,
        margin: EdgeInsets.only( right: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            Text('Price: \n' + itemPrice,
              textAlign: TextAlign.left,
              style: GoogleFonts.libreBaskerville(textStyle: TextStyle(color: Colors.blue, fontSize: 24.0, fontWeight: FontWeight.bold)) 
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text('(50% OFF)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 18.0,fontWeight: FontWeight.bold)
              )
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only( right: 10,top: 5, bottom: 10),
        alignment: Alignment.center,
        child: RaisedButton(
          onPressed: () {
            Scaffold.of(context).showSnackBar(getSnackBar('Added to cart !!'));
          },
          color: Colors.blue,
          disabledColor: Colors.blue,
          child: Text('BUY NOW',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          )
        )
      )
    ]);
  }
}



