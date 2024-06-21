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
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(eccentricity: 1),
              backgroundColor: Colors.amberAccent,
              child: const Icon(Icons.add, color: Colors.black, size: 40),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ScreenOutfitArticleSelect();
                    },
                  ),
                ).then((value) => {
                      setState(() {
                        filter = null;
                        filteredOutfits = DataManager().allOutfits;
                      })
                    })
              },
            ),
            body: SingleChildScrollView(
              child: Container(
                height: computeHeight(),
                child: Column(children: [
                  Expanded(
                      flex: 2,
                      child: CustomSearchBar(func: updateSearchResult)),
                  Expanded(
                    flex: 3,
                    child: ItemHorizontalList(
                        items: buildWidgets(getFilterItems()),
                        type: 0,
                        ),
                  ),
                  const Divider(),
                  Expanded(
                    flex: 28,
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
              ),
            ));
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
