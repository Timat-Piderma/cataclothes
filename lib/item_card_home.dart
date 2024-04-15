import 'package:flutter/material.dart';
import 'item.dart';
import 'item_card_small.dart';
import 'item_bubble.dart';

class ItemCardHome extends StatefulWidget {
  final Item item;

  const ItemCardHome({required this.item, Key? key}) : super(key: key);

  @override
  State<ItemCardHome> createState() => _ItemCardHomeState();
}

class _ItemCardHomeState extends State<ItemCardHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blueAccent, width: 4),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(widget.item.image),
            ),
          ),
        )),
        Expanded(
            child: Container(
          color: Colors.blue,
        )),
      ],
    );
  }
}
