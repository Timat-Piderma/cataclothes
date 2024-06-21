import 'package:flutter/material.dart';

import 'category_item.dart';

abstract class Item {
  String image = "";
  ItemCategory? category;
  String name = "";

  Item({
    this.image = "",
    this.category,
    this.name = "",
  });

  GestureDetector itemCardSmall(BuildContext context, Function func);

  GestureDetector itemCardStore(BuildContext context, Function func);
}
