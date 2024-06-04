import 'package:flutter/material.dart';
import 'item.dart';
import 'item_card_small.dart';
import 'item_bubble.dart';

class ItemHorizontalList extends StatefulWidget {
  final List<Item> items;
  final int type;
  final Function func;

  const ItemHorizontalList(
      {required this.items, required this.type, Key? key, required this.func})
      : super(key: key);

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
        if (widget.type == 0) {
          return AspectRatio(
              aspectRatio: 1,
              child: GestureDetector(
                onTap: () {
                  widget.func(widget.items[index]);
                },
                child: Container(
                  width: double.infinity,
                  child: ItemBubble(item: widget.items[index]),
                ),
              ));
        } else {
          return AspectRatio(
              aspectRatio: 1,
              child: GestureDetector(
                onTap: () {
                  widget.func(widget.items[index]);
                },
                child: Container(
                  width: double.infinity,
                  child: ItemCardSmall(item: widget.items[index]),
                ),
              ));
        }
      },
    );
  }
}
