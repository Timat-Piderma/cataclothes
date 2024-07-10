import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cataclothes/data_manager.dart';
import 'article.dart';
import 'article_color.dart';
import 'category_article.dart';

class ArticleDetailHome extends StatefulWidget {
  final Article article;

  const ArticleDetailHome({super.key, required this.article});

  @override
  State<ArticleDetailHome> createState() {
    return _ArticleDetailHomeState();
  }
}

class _ArticleDetailHomeState extends State<ArticleDetailHome>
    with SingleTickerProviderStateMixin {
  bool isEditable = false;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCost = TextEditingController();
  TextEditingController controllerBrand = TextEditingController();
  TextEditingController controllerTaglia = TextEditingController();

  List<ArticleColor> colorItems = DataManager.getAllColors();
  ArticleColor? dropdownColorValue;

  List<ArticleCategory> categoryItems = DataManager.getAllArticlesCategories();
  ArticleCategory? dropdownCategoryValue;

  @override
  void initState() {
    isEditable = false;

    controllerName.text = widget.article.name;
    controllerCost.text = widget.article.cost;
    controllerBrand.text = widget.article.brand;
    controllerTaglia.text = widget.article.taglia;

    dropdownColorValue = widget.article.color;
    dropdownCategoryValue = widget.article.articleCategory;
  }

  double computeWidth() {
    double width = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).viewPadding;
    double safeWidth = width - padding.left - padding.right;
    return safeWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text("Dettagli"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: 10,
                  top: 8,
                  left: computeWidth() / 4,
                  right: computeWidth() / 4),
              child: Container(
                height: computeWidth() / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 4),
                  image: DecorationImage(
                    image: getImage(widget.article.image),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                ListView(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nome",
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.grey[600]),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: computeWidth() / 1.1,
                                child: IgnorePointer(
                                  ignoring: !isEditable,
                                  child: TextField(
                                    style: const TextStyle(fontSize: 18),
                                    controller: controllerName,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              "Categoria",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[600]),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: computeWidth() / 1.1,
                                child: IgnorePointer(
                                  ignoring: !isEditable,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<
                                                  ArticleCategory>(
                                                menuMaxHeight: 200,
                                                value: dropdownCategoryValue,
                                                items: categoryItems
                                                    .map(
                                                      (map) => DropdownMenuItem<
                                                          ArticleCategory>(
                                                        value: map,
                                                        child: Text(map.name),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged:
                                                    (ArticleCategory? value) {
                                                  setState(() {
                                                    dropdownCategoryValue =
                                                        value;
                                                  });
                                                },
                                                isExpanded: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                          color: Colors.black, height: 1.0),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              "Brand",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[600]),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: computeWidth() / 1.1,
                                child: IgnorePointer(
                                  ignoring: !isEditable,
                                  child: TextField(
                                    controller: controllerBrand,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              "Colore",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[600]),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: computeWidth() / 1.1,
                                child: IgnorePointer(
                                  ignoring: !isEditable,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButtonHideUnderline(
                                              child:
                                                  DropdownButton<ArticleColor>(
                                                menuMaxHeight: 200,
                                                value: dropdownColorValue,
                                                items: colorItems
                                                    .map(
                                                      (map) => DropdownMenuItem<
                                                          ArticleColor>(
                                                        value: map,
                                                        child: Text(map.name),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged:
                                                    (ArticleColor? value) {
                                                  setState(() {
                                                    dropdownColorValue = value;
                                                  });
                                                },
                                                isExpanded: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                          color: Colors.black, height: 1.0),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              "Costo",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[600]),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: computeWidth() / 1.1,
                                child: IgnorePointer(
                                  ignoring: !isEditable,
                                  child: TextField(
                                    controller: controllerCost,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              "Taglia",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[600]),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: computeWidth() / 1.1,
                                child: IgnorePointer(
                                  ignoring: !isEditable,
                                  child: TextField(
                                    controller: controllerTaglia,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ImageProvider getImage(String path) {
    if (File(path).existsSync()) {
      return FileImage(File(path));
    } else {
      return AssetImage(path);
    }
  }

  Future openDeleteDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Sicuro di voler eliminare questo articolo?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Annulla")),
              TextButton(
                  onPressed: () {
                    deleteArticle(widget.article);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Conferma"))
            ],
          ));

  void deleteArticle(Article a) {
    DataManager.getAllArticles().contains(a)
        ? DataManager().deleteArticle(DataManager.getAllArticles().indexOf(a))
        : DataManager().updateWishlistArticlesList(a, false);
  }
}
