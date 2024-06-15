import 'package:cataclothes/article_store_detail.dart';
import 'package:cataclothes/item_grid.dart';
import 'package:cataclothes/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cataclothes/data_manager.dart';

import 'article.dart';
import 'article_store.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<ArticleStore> storeArticles = [];

  @override
  void initState() {
    getStoreArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return Column(
          children: [
            SearchBarComponent(),
            storeArticles.isEmpty
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                      ),
                    ),
                  )
                : Expanded(
                    child: ItemGrid(
                      items: storeArticles,
                      type: 1,
                      func: (ArticleStore art) {
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

  Future<void> getStoreArticles() async {
    List<ArticleStore> res = await DataManager.getStoreArticles();

    setState(() {
      storeArticles = res;
    });
    return;
  }
}
