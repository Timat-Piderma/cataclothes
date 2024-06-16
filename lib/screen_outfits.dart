import 'package:cataclothes/category_outfit.dart';
import 'package:cataclothes/item_horizontal_list.dart';
import 'package:cataclothes/screen_outfit_article_select.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';
import 'data_manager.dart';
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
                    flex: 1,
                    child: buildFloatingSearchBar(),
                  ),
                  Expanded(
                    flex: 2,
                    child: ItemHorizontalList(
                        items: getFilterItems(),
                        type: 0,
                        func: (Outfit out) {
                          setFilter(out);
                        }),
                  ),
                  const Divider(),
                  Expanded(
                    flex: 11,
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

  Widget buildFloatingSearchBar() {
    return FloatingSearchBar(
      hint: 'Cerca...',
      openAxisAlignment: 0.0,
      height: 40.0,
      width: 600,
      margins: EdgeInsets.fromLTRB(16, 5, 16, 0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      backdropColor: Colors.transparent,
      physics: BouncingScrollPhysics(),
      axisAlignment: 0.0,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 56),
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      debounceDelay: Duration(milliseconds: 500),
      onQueryChanged: (query) {},
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Azione di ricerca
            },
          ),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
