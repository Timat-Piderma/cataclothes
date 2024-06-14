import 'package:flutter/material.dart';

import 'category_item.dart';

abstract class Item {
  String image = "";
  ItemCategory? category;

  Item({
    this.image = "",
    this.category,
  });

  GestureDetector itemCardSmall(BuildContext context);

  GestureDetector itemCardStore(BuildContext context);
}
