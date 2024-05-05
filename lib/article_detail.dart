import 'package:flutter/material.dart';
import 'package:cataclothes/data_manager.dart';
import 'article.dart';
import 'article_color.dart';
import 'category.dart';

class ArticleDetail extends StatefulWidget {
  final Article article;

  const ArticleDetail({required this.article});

  @override
  State<ArticleDetail> createState() {
    return _ArticleDetailState();
  }
}

// SingleTickerProviderStateMixin serve per permettere di inizializzare vsync a this nel TabController
class _ArticleDetailState extends State<ArticleDetail>
    with SingleTickerProviderStateMixin {
  bool isEditable = false;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCost = TextEditingController();

  List<ArticleColor> colorItems = DataManager.getAllColors();
  String dropdownColorValue = "";

  List<Category> categoryItems = DataManager.getAllCategories();
  String dropdownCategoryValue = "";

  bool _isFavourited = false;
  late TabController _tabController;

  @override
  void initState() {
    isEditable = false;
    _isFavourited = widget.article.isFavourite;
    controllerName.text = widget.article.name;
    controllerCost.text = widget.article.cost;

    dropdownColorValue = widget.article.color!.name;
    dropdownCategoryValue = widget.article.category!.name;
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
          backgroundColor: isEditable ? Colors.red : Colors.tealAccent,
          label: Text(
            isEditable ? "Salva" : "Modifica",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () => {
            setState(() {
              isEditable = !isEditable;
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
                  image: AssetImage(widget.article.image),
                ),
              ),

              /*     child: Stack(
                children: [
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: IconButton(
                        icon: Icon(_isFavourited
                            ? Icons.favorite
                            : Icons.favorite_border),
                        iconSize: 28,
                        color: Colors.orange,
                        onPressed: () {
                          setState(() {
                            _isFavourited = !_isFavourited;
                            final dataManager =
                                Provider.of<DataManager>(context, listen: false);
                            dataManager.updateFavouriteArticleValue(
                                widget.article, _isFavourited);
                            dataManager.updateFavouriteArticlesList(
                                widget.article, _isFavourited);
                          });
                        }),
                  )
                ],
              ),*/
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
                        child: IgnorePointer(
                          ignoring: !isEditable,
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            controller: controllerName,
                            decoration: InputDecoration(
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
                          child: DropdownButton<String>(
                            value: dropdownColorValue,
                            //label: const Text("Colore"),
                            //textStyle: TextStyle(fontSize: 18),
                            //width: computeWidth() / 1.1,
                            items: colorItems
                                .map(
                                  (map) => DropdownMenuItem<String>(
                                    child: Text(map.name),
                                    value: map.name,
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownColorValue = value.toString();
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
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
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
                          child: DropdownButton<String>(
                            value: dropdownCategoryValue,
                            //label: const Text("Colore"),
                            //textStyle: TextStyle(fontSize: 18),
                            //width: computeWidth() / 1.1,
                            items: categoryItems
                                .map(
                                  (map) => DropdownMenuItem<String>(
                                child: Text(map.name),
                                value: map.name,
                              ),
                            )
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownCategoryValue = value.toString();
                              });
                            },
                          ),
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
}
