import 'package:flutter/material.dart';
import 'item.dart';
import 'item_card_small.dart';
import 'item_bubble.dart';

class ItemCardStore extends StatefulWidget {
  final Item item;

  const ItemCardStore({required this.item, Key? key}) : super(key: key);

  @override
  State<ItemCardStore> createState() => _ItemCardStoreState();
}

class _ItemCardStoreState extends State<ItemCardStore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueAccent, width: 4),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(widget.item.image),
                ),
              ),
            )),
        Expanded(
            child: Container(
              child: Column(
                children: [
                  Text(
                    "Articolo del Giorno",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.blue,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(child: Text("9.99 €",
                          style: Theme.of(context).textTheme.bodySmall,)),
                      ),
                      Expanded(
                          child: FilledButton(
                            onPressed: () => {},
                            child: Text(
                              "Shop Now",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            )),
      ],
    );
  }
}
