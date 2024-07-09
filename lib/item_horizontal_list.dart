import 'package:flutter/material.dart';

class ItemHorizontalList extends StatefulWidget {
  final List<Widget> items;

  const ItemHorizontalList(
      {required this.items, Key? key})
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
