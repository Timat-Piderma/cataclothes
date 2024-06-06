import 'package:flutter/material.dart';
import 'item.dart';

class ItemGrid extends StatefulWidget {
  final List<Item> items;
  final int type;
  final Function func;

  const ItemGrid(
      {required this.items, required this.type, Key? key, required this.func})
      : super(key: key);

  @override
  State<ItemGrid> createState() => _ItemGridState();
}

class _ItemGridState extends State<ItemGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 0) {
      return GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {

          return GestureDetector(
            onTap: () {
              widget.func(widget.items[index]);
            },
            child: widget.items[index].itemCardSmall(context),
          );
        },
      );
    } else {
      return GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 180,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              widget.func(widget.items[index]);
            },
            child: widget.items[index].itemCardStore(context),
          );
        },
      );
    }
  }
}
