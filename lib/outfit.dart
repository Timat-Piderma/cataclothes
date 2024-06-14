import 'package:flutter/material.dart';
import 'article.dart';
import 'category_outfit.dart';
import 'item.dart';
import 'item_card_small.dart';

class Outfit extends Item {
  String cost = "";
  String name = "";
  bool isFavourite = false;
  OutfitCategory? outfitCategory;
  List<Article>? articles;

  Outfit({
    super.image = "",
    this.cost = "",
    this.name = "",
    this.isFavourite = false,
    this.outfitCategory,
    this.articles,
  });

  @override
  GestureDetector itemCardSmall(BuildContext context) {
    return GestureDetector(
      child: ItemCardSmall(item: this),
    );
  }

  @override
  GestureDetector itemCardStore(BuildContext context) {
    return GestureDetector();
  }
}
