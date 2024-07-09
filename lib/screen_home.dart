import 'article.dart';
import 'article_detail.dart';
import 'item_card_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_manager.dart';
import 'item_card_small.dart';
import 'item_horizontal_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double computeHeight() {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).viewPadding;
    double safeHeight = height - padding.top - kToolbarHeight;
    return safeHeight;
  }

  double computeWidth() {
    double width = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).viewPadding;
    double safeWidth = width - padding.left - padding.right;
    return safeWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return ListView(children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: SizedBox(
              height: computeWidth() / 2,
              child: ItemCardHome(
                item: DataManager.getFeaturedItem(),
              ),
            ),
          ),

          //Start of items Row
          SizedBox(
            height: computeHeight() / 6,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Jeans per oggi",
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                    flex: 9,
                    child: ItemHorizontalList(
                        items: buildWidgets(DataManager.getAllArticles().where((element) => element.articleCategory != null && element.articleCategory!.name == "Jeans").toList()),
                        type: 1,
                        ))
              ],
            ),
          ),

          //Start of items Row
          SizedBox(
            height: computeHeight() / 6,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Caldo? Vai Leggero",
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                    flex: 9,
                    child: ItemHorizontalList(
                      items: buildWidgets(DataManager.getAllArticles().where((element) => element.articleCategory != null && element.articleCategory!.name == "Camicia").toList()),
                      type: 1,
                        ))
              ],
            ),
          ),

          //Start of items Row
          SizedBox(
            height: computeHeight() / 6,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Colore del Giorno: Giallo",
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                    flex: 9,
                    child: ItemHorizontalList(
                      items: buildWidgets(DataManager.getAllArticles().where((element) => element.color != null && element.color!.name == "Giallo").toList()),
                      type: 1,
                    ))
              ],
            ),
          ),
        ]);
      },
    );
  }

  List<Widget> buildWidgets(List<Article> items) {
    List<Widget> res = [];

    for (Article a in items) {
      res.add(AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: double.infinity,
          child: ItemCardSmall(item: a, func: () {}),
        ),
      ));
    }

    return res;
  }

  void loadDetailPage(Article art) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ArticleDetail(article: art);
        },
      ),
    );
  }
}
