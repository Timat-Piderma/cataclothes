import 'dart:io';

import 'package:flutter/material.dart';
import 'article.dart';

class ArticleCardStore extends StatefulWidget {
  final Article article;

  const ArticleCardStore({required this.article});

  @override
  State<ArticleCardStore> createState() {
    return _ArticleCardStore();
  }
}

class _ArticleCardStore extends State<ArticleCardStore> {
  Color cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(
                  color: Colors.blueGrey,
                  width: 3.0,
                ),
              ),
              child: ClipRect(
                child: Image(
                  image: getImage(widget.article.image),
                ),
              )),
        ),
        Text(
          widget.article.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          widget.article.cost,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }

  ImageProvider getImage(String path) {
    if (File(path).existsSync()) {
      return FileImage(File(path));
    } else {
      return AssetImage(path);
    }
  }
}
