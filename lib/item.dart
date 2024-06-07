import 'package:flutter/material.dart';

import 'category.dart';

abstract class Item {

  String image = "";
  Category? category;

  Item({

    this.image = "",
    this.category,
  });

  GestureDetector itemCardSmall(BuildContext context);
  GestureDetector itemCardStore(BuildContext context);

}