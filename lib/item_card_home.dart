import 'package:flutter/material.dart';

import 'article_store.dart';

class ItemCardHome extends StatefulWidget {
  final ArticleStore item;

  const ItemCardHome({required this.item, Key? key}) : super(key: key);

  @override
  State<ItemCardHome> createState() => _ItemCardHomeState();
}

class _ItemCardHomeState extends State<ItemCardHome> {
  Color cardColor = Colors.white;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Card(
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: const BorderSide(
                    color: Colors.blueGrey,
                    width: 4.0,
                  ),
                ),
                child: ClipRect(
                  child: Image(
                    image: AssetImage(widget.item.image),
                  ),
                ))),
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
                    widget.item.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Center(
                        child: Text(
                      widget.item.cost,
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
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
