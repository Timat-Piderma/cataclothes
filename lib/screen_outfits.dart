import 'package:cataclothes/category_outfit.dart';
import 'package:cataclothes/custom_searchbar.dart';
import 'package:cataclothes/item_horizontal_list.dart';
import 'package:cataclothes/screen_manage_outfit_categories.dart';
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
                        func: (Outfit out) {
                          setFilter(out);
                        }),
                  ),
                  const Divider(),
                  Expanded(
                    flex: 28,
                    child: ItemGrid(
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
                        ).then((value) => setState(() {}));
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
            setFilter(o);
          },
          child: Container(
            width: double.infinity,
            child: ItemBubble(item: o),
          ),
        ),
      ));
    }

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

  void setFilter(Outfit out) {
    if (filter != out.outfitCategory) {
      filter = out.outfitCategory;

      List<Outfit> res = [];
      if (filter != null) {
        res.addAll(DataManager()
            .allOutfits
            .where((element) => element.outfitCategory == filter));
        setState(() {
          filteredOutfits = res;
        });
      }
    } else
      setState(() {
        filter = null;
        filteredOutfits = DataManager().allOutfits;
      });
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
