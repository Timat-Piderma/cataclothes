import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_manager.dart';
import 'item_grid.dart';
import 'item_horizontal_list.dart';

class ClosetScreen extends StatefulWidget {
  const ClosetScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ClosetScreen> createState() => _ClosetScreenState();
}

class _ClosetScreenState extends State<ClosetScreen> {
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
              Expanded(
                flex: 1,
                child: ItemHorizontalList(items: DataManager.getAllArticles()),
              ),
              Expanded(
                flex: 6,
                child: ItemGrid(items: DataManager.getAllArticles()),
              ),
            ]));
      },
    );
  }
}
