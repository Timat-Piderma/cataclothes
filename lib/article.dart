import 'package:cataclothes/item_card_store.dart';
import 'package:flutter/material.dart';
import 'article_detail.dart';
import 'item_card_small.dart';
import 'item.dart';

class Article extends Item {
  String name = "";
  String cost = "";
  bool isFavourite = false;

  Article({
    super.image = "",
    this.name = "",
    this.cost = "",
    this.isFavourite = false,
  });

  @override
  GestureDetector itemCardSmall(BuildContext context) {
    return GestureDetector(
      child: ItemCardSmall(item: this),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ArticleDetail(article: this);
            },
          ),
        );
      },
    );
  }

  @override
  GestureDetector itemCardStore(BuildContext context) {
    return GestureDetector(
      child: ItemCardStore(item: this),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ArticleDetail(article: this);
            },
          ),
        );
      },
    );
  }
}
