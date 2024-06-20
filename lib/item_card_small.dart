import 'dart:io';

import 'package:flutter/material.dart';
import 'item.dart';

class ItemCardSmall extends StatefulWidget {
  final Item item;

  const ItemCardSmall({super.key, required this.item});

  @override
  State<ItemCardSmall> createState() {
    return _ItemCardSmallState();
  }
}

class _ItemCardSmallState extends State<ItemCardSmall> {
  Color cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Card(
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
        ));
  }

  ImageProvider getImage(String path) {
    if (File(path).existsSync()) {
      return FileImage(File(path));
    } else {
      return AssetImage(path);
    }
  }
}
