import 'package:PropertyFinder/models/ListItemModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../pages/ProductPage.dart';

class ProductCarouselWidget extends StatefulWidget {
  final List<ListItemModel> listItems;

  ProductCarouselWidget({this.listItems});

  @override
  ProductCarouselWidgetState createState() => ProductCarouselWidgetState();
}

class ProductCarouselWidgetState extends State<ProductCarouselWidget> {
  int current = 0;

  List<Widget> getImageWidgets() {
    return widget.listItems.map((listItem) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute( 
              builder: (context) => ProductPage(listItem: listItem, similarListItems: widget.listItems)
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget> [
                Image.network(listItem.imageUrl, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                ),
              ]
            ),
          )
        )
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: getImageWidgets(),
          autoPlay: true,
          aspectRatio: 2.0,
          onPageChanged: (index) {
            setState(() {
              current = index;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.listItems.asMap().keys.map((index) => Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4)
              ),
            )
          ).toList()
        )
      ]
    );
  }
}