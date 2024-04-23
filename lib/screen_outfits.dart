import 'package:cataclothes/item_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_manager.dart';
import 'item_grid.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return Scaffold(
            floatingActionButton: FloatingActionButton.large(
              shape: const CircleBorder(eccentricity: 1),
              backgroundColor: Colors.amberAccent,
              child: const Icon(Icons.add, color: Colors.black, size: 60),
              onPressed: () => {},
            ),
            body: Column(children: [
              const Expanded(
                flex: 1,
                child: SearchBarComponent(),
              ),
              Expanded(
                flex: 2,
                child: ItemHorizontalList(items: DataManager.getAllOutfits(), type: 0),
              ),
              const Divider(),
              Expanded(
                flex: 11,
                child: ItemGrid(items: DataManager.getAllOutfits(), type: 0,),
              ),
            ]));
      },
    );
  }
}
