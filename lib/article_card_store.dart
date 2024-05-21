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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blueAccent, width: 4),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: getImage(widget.article.image),
                  ),
                ),
              ),
            ),
          ),
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
