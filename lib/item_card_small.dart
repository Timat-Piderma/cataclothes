import 'dart:io';

import 'package:flutter/material.dart';
import 'item.dart';

class ItemCardSmall extends StatefulWidget {
  final Item item;
  final Function func;
  final bool selectable;

  const ItemCardSmall({super.key, required this.item, required this.func, required this.selectable});

  @override
  State<ItemCardSmall> createState() {
    return _ItemCardSmallState();
  }
}

class _ItemCardSmallState extends State<ItemCardSmall> {
  Color cardColor = Colors.white;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.func(widget.item);
        if(widget.selectable) isSelected = !isSelected;
      },
      child: Stack(children: [
        Card(
            color: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(
                color: Colors.blueGrey,
                width: 3.0,
              ),
            ),
            child: ClipRect(
              child: Image(
                image: getImage(widget.item.image),
              ),
            )),
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