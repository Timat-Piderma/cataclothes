import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'article.dart';
import 'article_color.dart';
import 'category.dart';
import 'data_manager.dart';
import 'outfit.dart';

class ScreenAddOutfit extends StatefulWidget {
  final File photo;

  const ScreenAddOutfit({required this.photo});

  @override
  State<ScreenAddOutfit> createState() {
    return ScreenAddOutfitState();
  }
}

class ScreenAddOutfitState extends State<ScreenAddOutfit>
    with SingleTickerProviderStateMixin {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCost = TextEditingController();

  List<ArticleColor> colorItems = DataManager.getAllColors();
  ArticleColor? dropdownColorValue;

  List<Category> categoryItems = DataManager.getAllCategories();
  Category? dropdownCategoryValue;

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
          title: Text("Dettagli"),
          backgroundColor: Colors.tealAccent,
        ),
      ),

      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.tealAccent,
          label: Text(
            "Salva",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () => {
            setState(() async {
              Directory directory = await getApplicationDocumentsDirectory();

              String path = directory.path;

              final String filePath =
                  '$path/${DateTime.now().microsecondsSinceEpoch.toString()}.png';

              final File itemImage = await widget.photo.copy(filePath);
              debugPrint(itemImage.path);

              final dataManager =
                  Provider.of<DataManager>(context, listen: false);
              dataManager.addOutfit(new Outfit(
                name: controllerName.text,
                category: dropdownCategoryValue,
                cost: controllerCost.text,
                image: itemImage.path,
              ));

              Navigator.pop(context);
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
                  Row(
                    children: [
                      SizedBox(
                        width: computeWidth() / 1.1,
                        child: TextField(
                          style: TextStyle(fontSize: 18),
                          controller: controllerName,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: computeWidth() / 1.1,
                        child: TextField(
                          controller: controllerCost,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Costo',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: computeWidth() / 1.1,
                        child: DropdownButton<Category>(
                          value: dropdownCategoryValue,
                          items: categoryItems
                              .map(
                                (map) => DropdownMenuItem<Category>(
                                  child: Text(map.name),
                                  value: map,
                                ),
                              )
                              .toList(),
                          onChanged: (Category? value) {
                            setState(() {
                              dropdownCategoryValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
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
}
