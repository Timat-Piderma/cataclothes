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

  List<OutfitCategory> categoryItems = DataManager.getAllOutfitsCategories();
  OutfitCategory? dropdownCategoryValue;

  bool _isFavourited = false;
  late TabController _tabController;

  @override
  void initState() {
    isEditable = false;
    _isFavourited = widget.outfit.isFavourite;

    controllerName.text = widget.outfit.name;
    controllerCost.text = widget.outfit.cost;

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
          title: Text("Dettagli Outfit"),
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
              if (isEditable) {
                widget.outfit.name = controllerName.text;
                widget.outfit.cost = controllerCost.text;
                widget.outfit.outfitCategory = dropdownCategoryValue;
              }

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
                  image: getImage(widget.outfit.image),
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
                          child: TextField(
                            style: TextStyle(fontSize: 18),
                            controller: controllerCost,
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
                          child: DropdownButton<OutfitCategory>(
                            value: dropdownCategoryValue,
                            items: categoryItems
                                .map(
                                  (map) => DropdownMenuItem<OutfitCategory>(
                                    child: Text(
                                      map.name.length > 30
                                          ? map.name.substring(0, 30) + "..."
                                          : map.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    value: map,
                                  ),
                                )
                                .toList(),
                            onChanged: (OutfitCategory? value) {
                              setState(() {
                                dropdownCategoryValue = value;
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

  ImageProvider getImage(String path) {
    if (File(path).existsSync()) {
      return FileImage(File(path));
    } else {
      return AssetImage(path);
    }
  }
}
