import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cataclothes/data_manager.dart';
import 'article.dart';
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

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerCosto = TextEditingController();


  bool _isFavourited = false;
  late TabController _tabController;

  @override
  void initState() {
    _isFavourited = widget.article.isFavourite;
    controllerNome.text = widget.article.name;
    controllerCosto.text = widget.article.cost;
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

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.tealAccent,
        label: Text("Modifica",style: TextStyle(color: Colors.black,fontSize: 20),),
        onPressed: () => {},
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
                        child: TextField(
                          style: TextStyle(fontSize: 18),
                          controller: controllerNome,
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
                          controller: controllerCosto,
                          style: TextStyle(fontSize: 18),
                          readOnly: true,
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
                        child: DropdownMenu<String>(
                          inputDecorationTheme: InputDecorationTheme(),
                          label: const Text("Categoria"),
                          textStyle: TextStyle(fontSize: 18),
                          width: computeWidth() / 1.1,
                          dropdownMenuEntries: DataManager.getAllCategories()
                              .map<DropdownMenuEntry<String>>((Category value) {
                            return DropdownMenuEntry<String>(
                              value: value.name,
                              label: value.name,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: computeWidth() / 1.1,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Gaming',
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
