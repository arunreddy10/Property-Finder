import 'package:PropertyFinder/models/ListItemModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsWidget extends StatelessWidget {

  final ListItemModel listItem;
  ProductDetailsWidget({Key key, this.listItem}) : super(key : key);

  List<Widget> getDetailsWidgets (ListItemModel listItem){
    List<Widget> detailsWidgets = new List();
    detailsWidgets.add(Container(color: Colors.blue[75],
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only( left: 10, right: 10, bottom: 5),
        child: Text('Property Details:',
          textAlign: TextAlign.left,
          style: GoogleFonts.crimsonText(textStyle: TextStyle(color: Colors.black, fontSize: 26.0,fontWeight: FontWeight.bold, decoration: TextDecoration.underline)) 
        )
      )
    );
    detailsWidgets.add(getDetailsWidget(listItem.propertyType,'Property Type'));
    detailsWidgets.add(getDetailsWidget(listItem.bedroomNumber,'Number of Bedrooms'));
    detailsWidgets.add(getDetailsWidget(listItem.bathroomNumber,'Number of Bathrooms'));
    detailsWidgets.add(getDetailsWidget(listItem.carSpaces,'Number of Car Spaces'));
    return detailsWidgets;
  }

  Widget getDetailsWidget(String value, String type){
    return Container(
      margin: EdgeInsets.only( left: 10, right: 10),
      alignment: Alignment.centerLeft,
      child: Text(type + ':  '+ value,
        textAlign: TextAlign.left,
        style: GoogleFonts.crimsonText(textStyle: TextStyle(color: Colors.black,fontSize: 18.0)) 
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 10),
      child: Column(
        children: getDetailsWidgets(listItem)
      )
    );
  }
}