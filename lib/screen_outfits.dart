import 'package:cataclothes/category_outfit.dart';
import 'package:cataclothes/custom_searchbar.dart';
import 'package:cataclothes/item_horizontal_list.dart';
import 'package:cataclothes/screen_outfit_article_select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_manager.dart';
import 'item_bubble.dart';
import 'item_grid.dart';
import 'outfit.dart';
import 'outfit_detail.dart';

class OutfitsScreen extends StatefulWidget {
  const OutfitsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OutfitsScreen> createState() => _OutfitScreenState();
}

class _OutfitScreenState extends State<OutfitsScreen> {
  OutfitCategory? filter;
  OutfitCategory favouriteFilter = OutfitCategory(name: "fav");
  List<Outfit> filteredOutfits = DataManager().allOutfits;

  @override
  void initState() {
    setState(() {});
  }

  double computeHeight() {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).viewPadding;
    double safeHeight = height - padding.top - kToolbarHeight;
    return safeHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return Stack(
          children: [
            Column(children: [
              Expanded(
                  flex: 1, child: CustomSearchBar(func: updateSearchResult)),
              Expanded(
                flex: 1,
                child: ItemHorizontalList(
                  items: buildWidgets(getFilterItems()),
                  type: 0,
                ),
              ),
              const Divider(),
              Expanded(
                flex: 8,
                child: ItemGrid(
                  selectable: false,
                  items: filteredOutfits,
                  type: 0,
                  func: (Outfit out) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return OutfitDetail(outfit: out);
                        },
                      ),
                    ).then((value) => setState(() {
                          updateSearchResult("");
                        }));
                  },
                ),
              ),
            ]),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ScreenOutfitArticleSelect();
                        },
                      ),
                    ).then((value) => {
                          setState(() {
                            filter = null;
                            filteredOutfits = DataManager().allOutfits;
                          })
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.all(15),
                    backgroundColor: Colors.amberAccent, // <-- Button color
                    foregroundColor: Colors.grey, // <-- Splash color
                  ),
                  child: const Icon(Icons.add, color: Colors.black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> buildWidgets(List<Outfit> items) {
    List<Widget> res = [];

    for (Outfit o in items) {
      res.add(AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: () {
            setFilter(o.outfitCategory!);
          },
          child: Container(
            width: double.infinity,
            child: ItemBubble(item: o),
          ),
        ),
      ));
    }

    res.add(AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          setFilter(favouriteFilter);
        },
        child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return ClipRRect(
                      child: Container(
                        width: constraints.maxHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.blueGrey, width: 3),
                        ),
                        child: const Icon(Icons.favorite),
                      ),
                    );
                  }),
                ),
                const Text("Preferiti",
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            )),
      ),
    ));

    return res;
  }

  List<Outfit> getFilterItems() {
    List<Outfit> res = [];
    for (var cat in DataManager.getAllOutfitsCategories()) {
      if (DataManager.getFilterOutfit(cat) != null) {
        res.add(DataManager.getFilterOutfit(cat)!);
      }
    }
    return res;
  }

  void setFilter(OutfitCategory cat) {
    if (filter != cat) {
      filter = cat;

      List<Outfit> res = [];
      if (filter != null) {
        if (filter!.name != "fav") {
          res.addAll(DataManager()
              .allOutfits
              .where((element) => element.outfitCategory == filter));
        } else {
          res.addAll(
              DataManager().allOutfits.where((element) => element.isFavourite));
        }
        setState(() {
          filteredOutfits = res;
        });
      }
    } else {
      setState(() {
        filter = null;
        filteredOutfits = DataManager().allOutfits;
      });
    }
  }

  void updateSearchResult(String query) {
    List<Outfit> result = query.isEmpty
        ? DataManager().allOutfits
        : DataManager()
            .allOutfits
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    setState(() {
      filteredOutfits = result;
    });
  }
}
