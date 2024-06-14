import 'package:cataclothes/article_store_detail.dart';
import 'package:cataclothes/item_grid.dart';
import 'package:cataclothes/sample_data.dart';
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
  List<Article> storeArticle = [];

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
            storeArticle.isEmpty
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                      ),
                    ),
                  )
                : Expanded(
                    child: ItemGrid(
                      items: storeArticle,
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

  Future<void> getStoreArticles() async {
    List<Article> res = await DataManager.getStoreArticles();

    setState(() {
      storeArticle = res;
    });
    return;
  }
}
