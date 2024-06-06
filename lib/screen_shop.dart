import 'package:cataclothes/article_store_detail.dart';
import 'package:cataclothes/item_grid.dart';
import 'package:cataclothes/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cataclothes/data_manager.dart';

import 'article.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  // double computeHeight() {
  //   double height = MediaQuery.of(context).size.height;
  //   var padding = MediaQuery.of(context).viewPadding;
  //   double safeHeight = height - padding.top - kToolbarHeight;
  //   return safeHeight;
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return Column(
          children: [
            SearchBarComponent(),
            Expanded(
              child: ItemGrid(
                items: DataManager.getAllArticles(),
                type: 1,
                func: (Article art) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ArticleStoreDetail(article: art);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
