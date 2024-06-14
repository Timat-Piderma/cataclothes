import 'package:cataclothes/screen_add_photo_outfit_preview.dart';
import 'package:cataclothes/searchbar.dart';
import 'package:flutter/material.dart';

import 'article.dart';
import 'category_article.dart';
import 'category_outfit.dart';
import 'data_manager.dart';
import 'item_grid.dart';
import 'item_horizontal_list.dart';

class ScreenOutfitArticleSelect extends StatefulWidget {
  const ScreenOutfitArticleSelect();

  @override
  State<ScreenOutfitArticleSelect> createState() {
    return ScreenOutfitArticleSelectState();
  }
}

class ScreenOutfitArticleSelectState extends State<ScreenOutfitArticleSelect>
    with SingleTickerProviderStateMixin {
  ArticleCategory? filter;
  List<Article> filteredArticles = DataManager().allArticles;
  List<Article> selectedArticles = [];

  @override
  void initState() {}

  double computeWidth() {
    double width = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).viewPadding;
    double safeWidth = width - padding.left - padding.right;
    return safeWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: Text("Seleziona Vestiti"),
            backgroundColor: Colors.tealAccent,
          ),
        ),
        floatingActionButton: Visibility(
          visible: selectedArticles.isNotEmpty &&
              MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.amber,
            label: Text(
              "Aggiungi ${selectedArticles.length} articoli",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ScreenAddPhotoOutfitPreview(
                      articles: selectedArticles,
                    );
                  },
                ),
              );
            },
          ),
        ),
        body: Column(children: [
          const Expanded(
            flex: 1,
            child: SearchBarComponent(),
          ),
          Expanded(
            flex: 2,
            child: ItemHorizontalList(
                items: getFilterItems(),
                type: 0,
                func: (Article art) {
                  setFilter(art);
                }),
          ),
          const Divider(),
          Expanded(
            flex: 12,
            child: ItemGrid(
                items: filteredArticles,
                type: 0,
                func: (Article art) {
                  select(art);
                }),
          ),
        ]));
  }

  List<Article> getFilterItems() {
    List<Article> res = [];
    for (var cat in DataManager.getAllArticlesCategories()) {
      if (DataManager.getFilterArticle(cat) != null) {
        res.add(DataManager.getFilterArticle(cat)!);
      }
    }
    return res;
  }

  void setFilter(Article art) {
    if (filter != art.category) {
      filter = art.articleCategory;

      List<Article> res = [];
      if (filter != null) {
        res.addAll(DataManager()
            .allArticles
            .where((element) => element.category == filter));
        setState(() {
          filteredArticles = res;
        });
      }
    } else
      setState(() {
        filter = null;
        filteredArticles = DataManager().allArticles;
      });
  }

  void select(Article art) {
    if (selectedArticles.contains(art)) {
      setState(() {
        selectedArticles.remove(art);
      });
    } else {
      setState(() {
        selectedArticles.add(art);
      });
    }
  }
}
