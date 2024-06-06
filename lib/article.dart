import 'article_card_store.dart';
import 'package:flutter/material.dart';
import 'article_color.dart';
import 'article_detail.dart';
import 'item_card_small.dart';
import 'item.dart';
import 'article_store_detail.dart';
import 'category.dart';

class Article extends Item {
  String name = "";
  String cost = "";
  bool isFavourite = false;
  ArticleColor? color;
  Category? category;

  Article({
    super.image = "",
    this.name = "",
    this.cost = "",
    this.isFavourite = false,
    this.color,
    this.category,
  });

  @override
  GestureDetector itemCardSmall(BuildContext context) {
    return GestureDetector(
      child: ItemCardSmall(item: this),
    );
  }

  @override
  GestureDetector itemCardStore(BuildContext context) {
    return GestureDetector(
      child: ArticleCardStore(article: this),
    );
  }
}
