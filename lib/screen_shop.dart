import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cataclothes/data_manager.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

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
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Shop Screen",
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}