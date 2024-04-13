import 'package:flutter/material.dart';
import 'item.dart';
import 'article.dart';

class ItemGrid extends StatefulWidget {
  final List<Item> items;

  const ItemGrid({required this.items, Key? key}) : super(key: key);

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

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: widget.items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        return widget.items[index].itemCardSmall(context);
      },
    );
  }
}
