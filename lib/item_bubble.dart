import 'package:flutter/material.dart';
import 'item.dart';

class ItemBubble extends StatefulWidget {
  final Item item;

  const ItemBubble({required this.item});

  @override
  State<ItemBubble> createState() {
    return _ItemBubbleState();
  }
}

class _ItemBubbleState extends State<ItemBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blueAccent, width: 4),
            image: DecorationImage(
              image: AssetImage(widget.item.image),
            ),
          ),
        ),
      ),
    );
  }
}
