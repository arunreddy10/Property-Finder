import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductTitleWidget extends StatelessWidget {
  final String itemTitle;
  final String itemSummary;

  ProductTitleWidget({Key key, this.itemTitle, this.itemSummary});

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget> [
        Container(alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
          child: Text(itemTitle,
            textAlign: TextAlign.left,
            style: GoogleFonts.pTSerif(textStyle: TextStyle(color: Colors.black,fontSize: 25.0, fontWeight: FontWeight.bold))
          ),
        ),
        Container(alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: SmoothStarRating(
            allowHalfRating: false,
            starCount: 5,
            color: Colors.amber,
            rating: 4.5,
          ),
        ),
        Container(alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          child: Text(itemSummary,
            textAlign: TextAlign.left,
            style: GoogleFonts.crimsonText(textStyle: TextStyle(color: Colors.grey[700], fontSize: 17.0)) 
          ),
        ),
      ],
    );
  }
}