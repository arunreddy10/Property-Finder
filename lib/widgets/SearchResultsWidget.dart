import 'package:PropertyFinder/models/ListItemModel.dart';
import 'package:flutter/material.dart';
import 'package:PropertyFinder/widgets/ListItemWidget.dart';

class SearchResultsWidget extends StatelessWidget {
  final List<ListItemModel> listings;
  final void Function(ListItemModel listItem, int index) onTap;

  SearchResultsWidget({this.listings, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: listings.length,
      itemBuilder: ((context, index) => ListItemWidget(listItem: listings[index], index: index, onTap: onTap)),
      separatorBuilder: ((context, index) => Divider(color: Colors.grey, thickness: 1)),
      shrinkWrap: true,
    );
  }
}