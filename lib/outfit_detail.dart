import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cataclothes/data_manager.dart';
import 'category_outfit.dart';
import 'outfit.dart';

class OutfitDetail extends StatefulWidget {
  final Outfit outfit;

  const OutfitDetail({required this.outfit});

  @override
  State<OutfitDetail> createState() {
    return _OutfitDetailState();
  }
}

// SingleTickerProviderStateMixin serve per permettere di inizializzare vsync a this nel TabController
class _OutfitDetailState extends State<OutfitDetail>
    with SingleTickerProviderStateMixin {
  bool isEditable = false;

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCost = TextEditingController();
  TextEditingController controllerOccasion = TextEditingController();

  List<OutfitCategory> categoryItems = DataManager.getAllOutfitsCategories();
  OutfitCategory? dropdownCategoryValue;

  List<String> seasonItems = ["Estate", "Autunno", "Inverno", "Primavera"];
  String? dropdownSeasonValue;

  bool _isFavourited = false;
  late TabController _tabController;

  @override
  void initState() {
    isEditable = false;
    _isFavourited = widget.outfit.isFavourite;

    controllerName.text = widget.outfit.name;
    controllerCost.text = widget.outfit.cost;
    controllerOccasion.text = widget.outfit.occasion;

    dropdownSeasonValue = widget.outfit.season;
    dropdownCategoryValue = widget.outfit.outfitCategory;
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
          title: const Text("Dettagli Outfit"),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Positioned(
                  bottom: 8,
                  right: 8,
                  child: IconButton(
                      icon: Icon(_isFavourited
                          ? Icons.favorite
                          : Icons.favorite_border),
                      color: Colors.blueGrey,
                      onPressed: () {
                        setState(() {
                          _isFavourited = !_isFavourited;
                          DataManager().updateFavouriteOutfitValue(
                              widget.outfit, _isFavourited);
                        });
                      })),
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
                    border: Border.all(color: Colors.blueGrey, width: 4),
                    image: DecorationImage(
                      image: getImage(widget.outfit.image),
                    ),
                  ),
                ),
              ),
            ]),
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
                                        borderSide: BorderSide(
                                          color: Colors.blueGrey,
                                        ),
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
                                                  OutfitCategory>(
                                                menuMaxHeight: 200,
                                                value: dropdownCategoryValue,
                                                items: categoryItems
                                                    .map(
                                                      (map) => DropdownMenuItem<
                                                          OutfitCategory>(
                                                        value: map,
                                                        child: Text(map.name),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged:
                                                    (OutfitCategory? value) {
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
                          Text(
                            "Costo",
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
                                    controller: controllerCost,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blueGrey,
                                        ),
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
                              "Stagione",
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
                                              child: DropdownButton<String>(
                                                menuMaxHeight: 200,
                                                value: dropdownSeasonValue,
                                                items: seasonItems
                                                    .map(
                                                      (map) => DropdownMenuItem<
                                                          String>(
                                                        value: map,
                                                        child: Text(map),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    dropdownSeasonValue = value;
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
                          Text(
                            "Occasione",
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
                                    controller: controllerOccasion,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blueGrey,
                                        ),
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
                      padding: EdgeInsets.only(top: 12, bottom: 20),
                      child: Row(children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
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
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: FilledButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => isEditable
                                        ? Colors.blueGrey
                                        : Color.fromARGB(255, 116, 167, 163)),
                              ),
                              child: Text(
                                isEditable ? "Salva" : "Modifica",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              onPressed: () => {
                                setState(() {
                                  if (isEditable) {
                                    widget.outfit.name = controllerName.text;
                                    widget.outfit.cost = controllerCost.text;
                                    widget.outfit.season = dropdownSeasonValue;
                                    widget.outfit.occasion =
                                        controllerOccasion.text;
                                    widget.outfit.outfitCategory =
                                        dropdownCategoryValue;
                                  }

                                  isEditable = !isEditable;
                                })
                              },
                            ),
                          ),
                        )
                      ]),
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
            title: const Text("Sicuro di voler eliminare questo outfit?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Annulla")),
              TextButton(
                  onPressed: () {
                    deleteOutfit(widget.outfit);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Conferma"))
            ],
          ));

  void deleteOutfit(Outfit o) {
    DataManager().deleteOutfit(DataManager.getAllOutfits().indexOf(o));
  }
}
