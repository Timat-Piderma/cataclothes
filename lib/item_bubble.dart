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
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            return ClipRRect(
              child: Container(
                width: constraints.maxHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.blueAccent, width: 4),
                  image: DecorationImage(
                    image: AssetImage(widget.item.image),
                  ),
                ),
              ),
            );
          }),
        ),
        Text(widget.item.category!.name,
        maxLines: 1,
        overflow:TextOverflow.ellipsis),
      ],
    );
  }
}
