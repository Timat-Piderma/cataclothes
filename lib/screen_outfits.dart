import 'package:cataclothes/item_horizontal_list.dart';
import 'package:cataclothes/screen_outfit_article_select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'category.dart';
import 'data_manager.dart';
import 'item_grid.dart';
import 'outfit.dart';
import 'outfit_detail.dart';
import 'searchbar.dart';

class OutfitsScreen extends StatefulWidget {
  const OutfitsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OutfitsScreen> createState() => _OutfitScreenState();
}

class _OutfitScreenState extends State<OutfitsScreen> {
  // double computeHeight() {
  //   double height = MediaQuery.of(context).size.height;
  //   var padding = MediaQuery.of(context).viewPadding;
  //   double safeHeight = height - padding.top - kToolbarHeight;
  //   return safeHeight;
  // }

  Category? filter;
  List<Outfit> filteredOutfits = DataManager().allOutfits;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return Scaffold(
            floatingActionButton: FloatingActionButton.large(
              shape: const CircleBorder(eccentricity: 1),
              backgroundColor: Colors.amberAccent,
              child: const Icon(Icons.add, color: Colors.black, size: 60),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ScreenOutfitArticleSelect();
                    },
                  ),
                )
              },
            ),
            body: Column(children: [
              const Expanded(
                flex: 1,
                child: SearchBarComponent(),
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
                    );
                  },
                ),
              ),
            ]));
      },
    );
  }

  List<Outfit> getFilterItems() {
    List<Outfit> res = [];
    for (var cat in DataManager.getAllCategories()) {
      if (DataManager.getFilterOutfit(cat) != null) {
        res.add(DataManager.getFilterOutfit(cat)!);
      }
    }
    return res;
  }

  void setFilter(Outfit out) {
    if (filter != out.category) {
      filter = out.category;

      List<Outfit> res = [];
      if (filter != null) {
        res.addAll(DataManager()
            .allOutfits
            .where((element) => element.category == filter));
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
}
