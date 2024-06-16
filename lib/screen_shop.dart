import 'package:cataclothes/article_store_detail.dart';
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
            Expanded(
              child: buildFloatingSearchBar(),
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

  Future<void> getStoreArticles() async {
    List<ArticleStore> res = await DataManager.getStoreArticles();

    setState(() {
      storeArticles = res;
    });
    return;
  }

  Widget buildFloatingSearchBar() {
    return FloatingSearchBar(
      hint: 'Cerca...',
      openAxisAlignment: 0.0,
      height: 40.0,
      width: 600,
      margins: EdgeInsets.fromLTRB(16, 5, 16, 0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      backdropColor: Colors.transparent,
      physics: BouncingScrollPhysics(),
      axisAlignment: 0.0,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 56),
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      debounceDelay: Duration(milliseconds: 500),
      onQueryChanged: (query) {},
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Azione di ricerca
            },
          ),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
