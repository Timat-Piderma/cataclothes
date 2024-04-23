import 'package:flutter/material.dart';

abstract class Item {

  String image = "";

  Item({

    this.image = "",
  });

  GestureDetector itemCardSmall(BuildContext context);
  GestureDetector itemCardStore(BuildContext context);

}