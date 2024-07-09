import 'package:cataclothes/category_article.dart';
import 'package:cataclothes/data_manager.dart';
import 'package:flutter/material.dart';

import 'article.dart';
import 'category_outfit.dart';
import 'custom_searchbar.dart';
import 'outfit.dart';

class ManageOutfitCategoriesScreen extends StatefulWidget {
  @override
  State<ManageOutfitCategoriesScreen> createState() {
    return _ManageOutfitCategoriesScreenState();
  }
}

class _ManageOutfitCategoriesScreenState
    extends State<ManageOutfitCategoriesScreen>
    with SingleTickerProviderStateMixin {
  List<OutfitCategory> filteredCategories = [];
  late TextEditingController _controller;

  @override
  void initState() {
    filteredCategories = DataManager.getAllOutfitsCategories();
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
            title: const Text("Gestisci Categorie Outfit"),
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
          physics: NeverScrollableScrollPhysics(),
          child: SizedBox(
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
    List<OutfitCategory> categories = [];

    for (OutfitCategory o in filteredCategories) {
      categories.add(o);
    }

    categories
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    String prec = '';

    for (OutfitCategory c in categories) {
      if (res.isEmpty || c.name[0].toLowerCase() != prec) {
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
              Text(
                  c.name.length > 30 ? "${c.name.substring(0, 30)}..." : c.name,
                  style: Theme.of(context).textTheme.bodyLarge),
              Expanded(
                child: Container(),
              ),
              GestureDetector(
                onTap: () => deleteCategory(c),
                child: const Icon(Icons.close, color: Colors.red),
              ),
            ],
          )));
      prec = c.name[0].toLowerCase();
    }

    res.add(const SizedBox(
      height: 100,
    ));

    return res;
  }

  void updateSearchResult(String query) {
    List<OutfitCategory> result = query.isEmpty
        ? DataManager.getAllOutfitsCategories()
        : DataManager.getAllOutfitsCategories()
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
                            DataManager.getAllOutfitsCategories();
                      });
                    }
                  },
                  child: const Text("Conferma"))
            ],
          ));

  void addCategory(String name) {
    DataManager().addOutfitCategory(OutfitCategory(name: name));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Categoria aggiunta con successo'),
      ),
    );
  }

  void deleteCategory(OutfitCategory toDelete) {
    List<OutfitCategory> allCategories = DataManager.getAllOutfitsCategories();

    for (Outfit o in DataManager.getAllOutfits()) {
      if (o.outfitCategory == toDelete) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Impossibile eliminare una categoria non vuota'),
          ),
        );
        return;
      }
    }

    DataManager().deleteOutfitCategory(allCategories.indexOf(toDelete));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Categoria ${toDelete.name} rimossa'),
      ),
    );

    setState(() {
      filteredCategories = DataManager.getAllOutfitsCategories();
    });
  }
}
