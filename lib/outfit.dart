import 'package:cataclothes/article_card_store.dart';
import 'package:flutter/material.dart';
import 'article.dart';
import 'item.dart';
import 'item_card_small.dart';
import 'category.dart';

class Outfit extends Item {
  String cost = "";
  String name = "";
  bool isFavourite = false;
  Category? category;
  List<Article>? articles;

  Outfit({
    super.image = "",
    this.cost = "",
    this.name = "",
    this.isFavourite = false,
    this.category,
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
