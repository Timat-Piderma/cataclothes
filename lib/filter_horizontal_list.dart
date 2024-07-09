import 'dart:io';

import 'package:flutter/material.dart';
import 'article.dart';
import 'item.dart';
import 'outfit.dart';

class FilterHorizontalList extends StatefulWidget {
  final List<ItemBubble> items;
  final int type;

  const FilterHorizontalList(
      {required this.items, required this.type, Key? key})
      : super(key: key);

  @override
  State<FilterHorizontalList> createState() => _FilterHorizontalListState();
}

class _FilterHorizontalListState extends State<FilterHorizontalList> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final isSelected = selectedIndex == index;
        return SizedBox(
          width: 65,
          child: GestureDetector(
            onTap: () {
              widget.items[index].func(widget.items[index].item is Article
                  ? (widget.items[index].item as Article).articleCategory!
                  : (widget.items[index].item as Outfit).outfitCategory!);
              if (selectedIndex == index) {
                setState(() {
                  selectedIndex = -1;
                });
              } else {
                setState(() {
                  selectedIndex = index;
                });
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Stack(
                children: [
                  widget.items[index],
                  if (isSelected)
                    Positioned.fill(
                      child: ColoredBox(color: Colors.black.withOpacity(0.4)),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ItemBubble extends StatefulWidget {
  final Item item;
  final Function func;

  ItemBubble({super.key, required this.item, required this.func});

  @override
  State<ItemBubble> createState() {
    return _ItemBubbleState();
  }
}

class _ItemBubbleState extends State<ItemBubble> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
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
                    image: DecorationImage(image: getImage(widget.item.image)),
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
