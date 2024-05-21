import 'dart:io';

import 'package:flutter/material.dart';
import 'item.dart';

class ItemCardSmall extends StatefulWidget {
  final Item item;

  const ItemCardSmall({required this.item});

  @override
  State<ItemCardSmall> createState() {
    return _ItemCardSmallState();
  }
}

class _ItemCardSmallState extends State<ItemCardSmall> {
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
              fit: BoxFit.fill,
              image: getImage(widget.item.image),
            ),
          ),
        ),
      ),
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
