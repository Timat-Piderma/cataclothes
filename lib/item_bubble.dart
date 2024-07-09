import 'dart:io';

import 'package:flutter/material.dart';
import 'article.dart';
import 'item.dart';
import 'outfit.dart';

class ItemBubble extends StatefulWidget {
  final Item item;
  final Function func;

  const ItemBubble({super.key, required this.item, required this.func});

  @override
  State<ItemBubble> createState() {
    return _ItemBubbleState();
  }
}

class _ItemBubbleState extends State<ItemBubble> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        widget.func(widget.item is Article
            ? (widget.item as Article).articleCategory!
            : (widget.item as Outfit).outfitCategory!);

        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Stack(children: [
        Center(
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(builder: (context, constraints) {
                  return ClipRRect(
                    child: Container(
                      width: constraints.maxHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.blueGrey, width: 3),
                        image:
                            DecorationImage(image: getImage(widget.item.image)),
                      ),
                    ),
                  );
                }),
              ),
              Text(
                  widget.item is Article
                      ? (widget.item as Article).articleCategory!.name
                      : (widget.item as Outfit).outfitCategory!.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        Visibility(
          visible: isSelected,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: ColoredBox(color: Colors.black.withOpacity(0.4)));
            },
          ),
        ),
      ]),
    );
  }

  ImageProvider getImage(String path) {
    if (File(path).existsSync()) {
      return FileImage(File(path));
    } else {
      return AssetImage(path);
    }
  }
}
