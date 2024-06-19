import 'package:cataclothes/category_article.dart';
import 'package:cataclothes/data_manager.dart';
import 'package:flutter/material.dart';

import 'article.dart';
import 'custom_searchbar.dart';

class ManageArticleCategoriesScreen extends StatefulWidget {
  @override
  State<ManageArticleCategoriesScreen> createState() {
    return _ManageArticleCategoriesScreenState();
  }
}

class _ManageArticleCategoriesScreenState
    extends State<ManageArticleCategoriesScreen>
    with SingleTickerProviderStateMixin {
  List<ArticleCategory> filteredCategories = [];
  late TextEditingController _controller;

  @override
  void initState() {
    filteredCategories = DataManager.getAllArticlesCategories();
    _controller = TextEditingController();
  }

  double computeHeight() {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).viewPadding;
    double safeHeight = height - padding.top - kToolbarHeight;
    return safeHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: const Text("Gestisci Categorie Vestiti"),
            backgroundColor: Colors.tealAccent,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(eccentricity: 1),
          backgroundColor: Colors.amberAccent,
          child: const Icon(Icons.add, color: Colors.black, size: 40),
          onPressed: () => {openDialog()},
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: computeHeight(),
            child: Column(children: [
              Expanded(
                  flex: 2,
                  child: CustomSearchBar(
                    func: updateSearchResult,
                  )),
              Expanded(
                flex: 18,
                child: ListView(
                  children: buildElements(),
                ),
              ),
            ]),
          ),
        ));
  }

  List<Widget> buildElements() {
    List<Widget> res = [];
    List<ArticleCategory> categories = [];

    for (ArticleCategory a in filteredCategories) {
      categories.add(a);
    }

    categories.sort((a, b) => a.name.compareTo(b.name));

    String prec = '';

    for (ArticleCategory c in categories) {
      if (res.isEmpty || c.name[0] != prec) {
        res.add(const Divider());
        res.add(Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            c.name[0].toUpperCase(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ));
        res.add(const Divider());
      }
      res.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(c.name, style: Theme.of(context).textTheme.bodyLarge),
              Expanded(
                child: Container(),
              ),
              GestureDetector(
                onTap: () => deleteCategory(c),
                child: const Icon(Icons.close, color: Colors.red),
              ),
            ],
          )));
      prec = c.name[0];
    }

    return res;
  }

  void updateSearchResult(String query) {
    List<ArticleCategory> result = query.isEmpty
        ? DataManager.getAllArticlesCategories()
        : DataManager.getAllArticlesCategories()
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    setState(() {
      filteredCategories = result;
    });
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Aggiungi Categoria"),
            content: TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: "Nome Categoria"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Annulla")),
              TextButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      addCategory(_controller.text);
                      Navigator.pop(context);
                      setState(() {
                        filteredCategories =
                            DataManager.getAllArticlesCategories();
                      });
                    }
                  },
                  child: const Text("Conferma"))
            ],
          ));

  void addCategory(String name) {
    DataManager().addArticleCategory(ArticleCategory(name: name));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Categoria aggiunta con successo'),
      ),
    );
  }

  void deleteCategory(ArticleCategory toDelete) {
    List<ArticleCategory> allCategories =
        DataManager.getAllArticlesCategories();

    for (Article a in DataManager.getAllArticles()) {
      if (a.articleCategory == toDelete) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                const Text('Impossibile eliminare una categoria non vuota'),
          ),
        );
        return;
      }
    }

    DataManager().deleteArticleCategory(allCategories.indexOf(toDelete));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Categoria ${toDelete.name} rimossa'),
      ),
    );

    setState(() {
      filteredCategories = DataManager.getAllArticlesCategories();
    });
  }
}
