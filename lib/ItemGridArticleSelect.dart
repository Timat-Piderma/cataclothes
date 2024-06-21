import 'dart:io';

import 'package:flutter/material.dart';
import 'item.dart';

class ItemGridArticleSelect extends StatefulWidget {
  final List<Item> allItems;
  final List<Item> selectedItems;
  final Function func;

  const ItemGridArticleSelect({
    required this.allItems,
    Key? key,
    required this.func,
    required this.selectedItems,
  }) : super(key: key);

  @override
  State<ItemGridArticleSelect> createState() => _ItemGridArticleSelectState();
}

class _ItemGridArticleSelectState extends State<ItemGridArticleSelect> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: widget.allItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        return SelectArticleCard(
            func: widget.func,
            alreadySelected:
                widget.selectedItems.contains(widget.allItems[index]),
            item: widget.allItems[index]);
      },
    );
  }
}

class SelectArticleCard extends StatefulWidget {
  final Item item;
  final Function func;
  final bool alreadySelected;

  const SelectArticleCard({
    Key? key,
    required this.func,
    required this.alreadySelected,
    required this.item,
  }) : super(key: key);

  @override
  State<SelectArticleCard> createState() => _SelectArticleCardState();
}

class _SelectArticleCardState extends State<SelectArticleCard> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      isSelected = widget.alreadySelected;
    });

    return GestureDetector(
      onTap: () {
        widget.func(widget.item);

        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Stack(children: [
        Card(
            //color: cardColor,
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
