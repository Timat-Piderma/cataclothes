import 'item_card_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_manager.dart';
import 'item_horizontal_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double computeHeight() {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).viewPadding;
    double safeHeight = height - padding.top - kToolbarHeight;
    return safeHeight;
  }

  double computeWidth() {
    double width = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).viewPadding;
    double safeWidth = width - padding.left - padding.right;
    return safeWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return ListView(children: [
          SizedBox(
            height: computeWidth() / 2,
            child: ItemCardHome(
              item: DataManager.getFeaturedItem(),
            ),
          ),

          //Start of items Row
          SizedBox(
            height: computeHeight() / 6.7,
            child: Column(
              children: [
                const Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Non lo metti più? Mettilo su Vinted",
                        textAlign: TextAlign.left,
                      ),
                    )),
                Expanded(
                    flex: 9,
                    child: ItemHorizontalList(
                        items: DataManager.getAllArticles(), type: 1))
              ],
            ),
          ),

          //Start of items Row
          SizedBox(
            height: computeHeight() / 6.7,
            child: Column(
              children: [
                const Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Non lo metti più? Mettilo su Vinted",
                        textAlign: TextAlign.left,
                      ),
                    )),
                Expanded(
                    flex: 9,
                    child: ItemHorizontalList(
                        items: DataManager.getAllArticles(), type: 1))
              ],
            ),
          ),
        ]);
      },
    );
  }
}
