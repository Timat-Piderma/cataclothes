import 'package:flutter/material.dart';
import 'item.dart';
import 'article.dart';
import 'item_bubble.dart';

class ItemHorizontalList extends StatefulWidget {
  final List<Item> items;

  const ItemHorizontalList({required this.items, Key? key}) : super(key: key);

  @override
  State<ItemHorizontalList> createState() => _ItemHorizontalListState();
}

class _ItemHorizontalListState extends State<ItemHorizontalList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: double.infinity,
            child: ItemBubble(item: widget.items[index]),
          ),
        );
      },
    );
  }
}
