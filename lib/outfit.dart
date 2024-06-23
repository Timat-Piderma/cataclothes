import 'package:flutter/material.dart';
import 'article.dart';
import 'category_outfit.dart';
import 'item.dart';
import 'item_card_small.dart';

class Outfit extends Item {
  String cost = "";
  bool isFavourite = false;
  OutfitCategory? outfitCategory;
  List<Article>? articles;
  String stagione = "";
  String occasione = "";

  Outfit({
    super.image = "",
    this.cost = "",
    this.stagione = "",
    this.occasione = "",
    super.name = "",
    this.isFavourite = false,
    this.outfitCategory,
    this.articles,
  });

  @override
  GestureDetector itemCardSmall(BuildContext context, Function func) {
    return GestureDetector(
      child: ItemCardSmall(item: this, func: func),
    );
  }

  @override
  GestureDetector itemCardStore(BuildContext context, Function func) {
    return GestureDetector();
  }
}
