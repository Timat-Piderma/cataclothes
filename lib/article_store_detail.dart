import 'package:flutter/material.dart';
import 'package:cataclothes/data_manager.dart';
import 'article.dart';
import 'category.dart';

class ArticleStoreDetail extends StatefulWidget {
  final Article article;

  const ArticleStoreDetail({required this.article});

  @override
  State<ArticleStoreDetail> createState() {
    return _ArticleStoreDetailState();
  }
}

// SingleTickerProviderStateMixin serve per permettere di inizializzare vsync a this nel TabController
class _ArticleStoreDetailState extends State<ArticleStoreDetail>
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
        label: Text(
          "Aggiungi alla wishlist",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        onPressed: () => {},
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: ListView(
        children: <Widget>[
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                      ),
                      child: Container(
                        height: computeWidth() / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 4),
                          image: DecorationImage(
                            image: AssetImage(widget.article.image),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: computeWidth() / 2,
                      child: Column(
                        children: [
                          Expanded(
                            child: Text(
                              widget.article.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Text(
                                "Descrizione dell'articolo selezionatodal negozio dell'applicazione Catà-Clothes XDD",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    widget.article.cost,
                    textAlign: TextAlign.right,
                  )),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: FilledButton(
                      onPressed: () => {},
                      child: Text(
                        "Visita il Negozio",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              )
            ],
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
                          readOnly: true,
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
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
