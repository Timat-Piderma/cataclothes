import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cataclothes/data_manager.dart';
import 'article.dart';
import 'article_color.dart';
import 'category_article.dart';

class ArticleDetail extends StatefulWidget {
  final Article article;

  const ArticleDetail({super.key, required this.article});

  @override
  State<ArticleDetail> createState() {
    return _ArticleDetailState();
  }
}

class _ArticleDetailState extends State<ArticleDetail>
    with SingleTickerProviderStateMixin {
  bool isEditable = false;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCost = TextEditingController();

  List<ArticleColor> colorItems = DataManager.getAllColors();
  ArticleColor? dropdownColorValue;

  List<ArticleCategory> categoryItems = DataManager.getAllArticlesCategories();
  ArticleCategory? dropdownCategoryValue;

  bool _isFavourited = false;
  late TabController _tabController;

  @override
  void initState() {
    isEditable = false;
    _isFavourited = widget.article.isFavourite;

    controllerName.text = widget.article.name;
    controllerCost.text = widget.article.cost;

    dropdownColorValue = widget.article.color;
    dropdownCategoryValue = widget.article.articleCategory;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          backgroundColor: Colors.tealAccent,
        ),
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FloatingActionButton.extended(
          backgroundColor: isEditable ? Colors.red : Colors.tealAccent,
          label: Text(
            isEditable ? "Salva" : "Modifica",
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () => {
            setState(() {
              if (isEditable) {
                widget.article.name = controllerName.text;
                widget.article.cost = controllerCost.text;
                widget.article.color = dropdownColorValue;
                widget.article.articleCategory = dropdownCategoryValue;
              }

              isEditable = !isEditable;
            })
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                                labelText: 'Nome',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: computeWidth() / 1.1,
                          child: IgnorePointer(
                            ignoring: !isEditable,
                            child: DropdownButton<ArticleColor>(
                              value: dropdownColorValue,
                              items: colorItems
                                  .map(
                                    (map) => DropdownMenuItem<ArticleColor>(
                                      value: map,
                                      child: Text(map.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (ArticleColor? value) {
                                setState(() {
                                  dropdownColorValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
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
                                labelText: 'Costo',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: computeWidth() / 1.1,
                          child: IgnorePointer(
                            ignoring: !isEditable,
                            child: DropdownButton<ArticleCategory>(
                              value: dropdownCategoryValue,
                              items: categoryItems
                                  .map(
                                    (map) => DropdownMenuItem<ArticleCategory>(
                                      value: map,
                                      child: Text(
                                        map.name.length > 30
                                            ? "${map.name.substring(0, 30)}..."
                                            : map.name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (ArticleCategory? value) {
                                setState(() {
                                  dropdownCategoryValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.red),
                          ),
                          onPressed: () {
                            openDeleteDialog();
                          },
                          child: Text(
                            "Elimina",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    )
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
    DataManager().deleteArticle(DataManager.getAllArticles().indexOf(a));
  }
}
