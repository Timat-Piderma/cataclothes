import 'package:cataclothes/item_card_store.dart';
import 'package:flutter/material.dart';
import 'item.dart';
import 'item_card_small.dart';
import 'outfit_detail.dart';

class Outfit extends Item {
  String cost = "";
  String name = "";
  bool isFavourite = false;

  Outfit({
    super.image = "",
    this.cost = "",
    this.name = "",
    this.isFavourite = false,
  });

  @override
  GestureDetector itemCardSmall(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OutfitDetail(outfit: this);
            },
          ),
        );
      },
      child: ItemCardSmall(item: this),
    );
  }

  @override
  GestureDetector itemCardStore(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OutfitDetail(outfit: this);
            },
          ),
        );
      },
      child: ItemCardStore(item: this),
    );
  }
}
