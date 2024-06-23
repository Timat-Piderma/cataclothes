import 'article_card_store.dart';
import 'package:flutter/material.dart';
import 'article_color.dart';
import 'item_card_small.dart';
import 'item.dart';
import 'category_article.dart';

class Article extends Item {
  String cost = "";
  bool isFavourite = false;
  ArticleColor? color;
  ArticleCategory? articleCategory;
  String brand = "";
  String taglia = "";

  Article({
    super.image = "",
    super.name = "",
    this.cost = "",
    this.taglia = "",
    this.brand = "",
    this.isFavourite = false,
    this.color,
    this.articleCategory,
  });

  @override
  GestureDetector itemCardSmall(BuildContext context, Function func) {
    return GestureDetector(
      child: ItemCardSmall(
        item: this,
        func: func,
      ),
    );
  }

  @override
  GestureDetector itemCardStore(BuildContext context, Function func) {
    return GestureDetector(
      child: ArticleCardStore(
        article: this,
        func: func,
      ),
    );
  }
}
