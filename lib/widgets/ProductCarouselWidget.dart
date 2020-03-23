import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductCarouselWidget extends StatefulWidget {
  final List<String> imgList;
  ProductCarouselWidget({this.imgList});

  @override
  ProductCarouselWidgetState createState() => ProductCarouselWidgetState();
}

class ProductCarouselWidgetState extends State<ProductCarouselWidget> {
  int current = 0;

  List<Widget> getImageWidgets(List<String> imgList) {
    return imgList.map((uri) => Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget> [
            Image.network(uri, fit: BoxFit.cover, width: 1000.0),
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
      ),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: getImageWidgets(widget.imgList),
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
          children: widget.imgList.asMap().keys.map((index) => Container(
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