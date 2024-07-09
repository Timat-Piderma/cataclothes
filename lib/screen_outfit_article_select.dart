import 'package:cataclothes/screen_add_photo_outfit_preview.dart';
import 'package:flutter/material.dart';

import 'filter_horizontal_list.dart';
import 'item_grid_article_select.dart';
import 'article.dart';
import 'category_article.dart';
import 'custom_searchbar.dart';
import 'data_manager.dart';

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
  ArticleCategory favouriteFilter = ArticleCategory(name: "fav");
  List<Article> filteredArticles = DataManager().allArticles;
  List<Article> selectedArticles = [];

  @override
  void initState() {}

  double computeHeight() {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).viewPadding;
    double safeHeight = height - padding.top - kToolbarHeight;
    return safeHeight;
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
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: computeHeight(),
            child: Column(children: [
              Expanded(
                  flex: 1,
                  child: CustomSearchBar(
                    func: updateSearchResult,
                  )),
              Expanded(
                flex: 1,
                child: FilterHorizontalList(
                  items: buildWidgets(getFilterItems()),
                  type: 0,
                ),
              ),
              const Divider(),
              Expanded(
                flex: 8,
                child: ItemGridArticleSelect(
                    selectedItems: selectedArticles,
                    allItems: filteredArticles,
                    func: (Article art) {
                      select(art);
                    }),
              ),
            ]),
          ),
        ));
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

  List<ItemBubble> buildWidgets(List<Article> items) {
    List<ItemBubble> res = [];

    for (Article a in items) {
      res.add(ItemBubble(item: a, func: setFilter));
    }

    res.add(ItemBubble(
        item: Article(
            articleCategory: favouriteFilter,
            image: "assets/icons/favourite_icon.png"),
        func: setFilter));

    return res;
  }

  void setFilter(ArticleCategory cat) {
    if (filter != cat) {
      filter = cat;

      List<Article> res = [];
      if (filter != null) {
        if (filter!.name != "fav") {
          res.addAll(DataManager()
              .allArticles
              .where((element) => element.articleCategory == filter));
        } else {
          res.addAll(DataManager()
              .allArticles
              .where((element) => element.isFavourite));
        }
        setState(() {
          filteredArticles = res;
        });
      }
    } else {
      setState(() {
        filter = null;
        filteredArticles = DataManager().allArticles;
      });
    }
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

  void updateSearchResult(String query) {
    List<Article> result = query.isEmpty
        ? DataManager().allArticles
        : DataManager()
            .allArticles
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    setState(() {
      filteredArticles = result;
    });
  }
}
