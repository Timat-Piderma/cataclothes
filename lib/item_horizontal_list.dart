import 'package:flutter/material.dart';

class ItemHorizontalList extends StatefulWidget {
  final List<Widget> items;
  final int type;

  const ItemHorizontalList(
      {required this.items, required this.type, Key? key})
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
    return ListView(
      scrollDirection: Axis.horizontal,
      children: widget.items,
    );
  }
}
