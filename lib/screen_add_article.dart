import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'article.dart';
import 'article_color.dart';
import 'category_article.dart';
import 'data_manager.dart';

class ScreenAddArticle extends StatefulWidget {
  final File photo;

  const ScreenAddArticle({required this.photo});

  @override
  State<ScreenAddArticle> createState() {
    return ScreenAddArticleState();
  }
}

class ScreenAddArticleState extends State<ScreenAddArticle>
    with SingleTickerProviderStateMixin {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerBrand = TextEditingController();
  TextEditingController controllerCost = TextEditingController();
  TextEditingController controllerTaglia = TextEditingController();

  List<ArticleColor> colorItems = DataManager.getAllColors();
  ArticleColor? dropdownColorValue;

  List<ArticleCategory> categoryItems = DataManager.getAllArticlesCategories();
  ArticleCategory? dropdownCategoryValue;

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
      //extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text("Dettagli"),
        ),
      ),

      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FloatingActionButton.extended(
          backgroundColor:
               dropdownCategoryValue == null
                  ? Colors.grey
                  : Color.fromARGB(255, 116, 167, 163),
          label: const Text(
            "Salva",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed:
                  dropdownCategoryValue == null
              ? () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ok")),
                            ],
                            content: Text(
                              "Per continuare i seguenti campi devono essere compilati:\n${dropdownCategoryValue == null
                                      ? "  - Categoria\n"
                                      : " "}",
                            ),
                          ));
                }
              : () => {
                    setState(() async {
                      Directory directory =
                          await getApplicationDocumentsDirectory();

                      String path = directory.path;

                      final String filePath =
                          '$path/${DateTime.now().microsecondsSinceEpoch.toString()}.png';

                      final File itemImage = await widget.photo.copy(filePath);
                      debugPrint(itemImage.path);

                      final dataManager =
                          Provider.of<DataManager>(context, listen: false);
                      dataManager.addArticle(Article(
                        name: controllerName.text,
                        articleCategory: dropdownCategoryValue,
                        color: dropdownColorValue,
                        cost: controllerCost.text,
                        image: itemImage.path,
                        brand: controllerBrand.text,
                        taglia: controllerTaglia.text,
                      ));

                      Navigator.pop(context);
                      Navigator.pop(context);
                    })
                  },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: ListView(
        children: <Widget>[
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
                  image: FileImage(widget.photo),
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
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
                              child: TextField(
                                style: const TextStyle(fontSize: 18),
                                controller: controllerName,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child:
                                              DropdownButton<ArticleCategory>(
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
                                                dropdownCategoryValue = value;
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
                        Text(
                          "Brand",
                          style: TextStyle(
                              fontSize: 14.0, color: Colors.grey[600]),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: computeWidth() / 1.1,
                              child: TextField(
                                style: const TextStyle(fontSize: 18),
                                controller: controllerBrand,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<ArticleColor>(
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
                                            onChanged: (ArticleColor? value) {
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
                        Text(
                          "Costo",
                          style: TextStyle(
                              fontSize: 14.0, color: Colors.grey[600]),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: computeWidth() / 1.1,
                              child: TextField(
                                style: const TextStyle(fontSize: 18),
                                controller: controllerCost,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
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
                        Text(
                          "Taglia",
                          style: TextStyle(
                              fontSize: 14.0, color: Colors.grey[600]),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: computeWidth() / 1.1,
                              child: TextField(
                                style: const TextStyle(fontSize: 18),
                                controller: controllerTaglia,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
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
              SizedBox(
                height: 70,
              ),
            ],
          )
        ],
      ),
    );
  }
}
