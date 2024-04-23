import 'package:flutter/material.dart';
import 'item.dart';

class ItemCardStore extends StatefulWidget {
  final Item item;

  const ItemCardStore({required this.item});

  @override
  State<ItemCardStore> createState() {
    return _ItemCardStore();
  }
}

class _ItemCardStore extends State<ItemCardStore> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blueAccent, width: 4),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(widget.item.image),
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          "Nome Articolo",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          "99.99 €",
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
