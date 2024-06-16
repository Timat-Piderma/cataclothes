import 'package:cataclothes/article_store_detail.dart';
import 'package:cataclothes/custom_searchbar.dart';
import 'package:cataclothes/item_grid.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';
import 'package:cataclothes/data_manager.dart';

import 'article_store.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<ArticleStore> storeArticles = DataManager.getStoreArticles();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return Column(
          children: [
            Expanded(
              child: CustomSearchBar(func: updateSearchResult),
            ),
            storeArticles.isEmpty
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                      ),
                    ),
                  )
                : Expanded(
                    flex: 9,
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

  void updateSearchResult(String query) {
    List<ArticleStore> result = query.isEmpty
        ? DataManager.getStoreArticles()
        : DataManager.getStoreArticles()
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    setState(() {
      storeArticles = result;
    });
  }
}
