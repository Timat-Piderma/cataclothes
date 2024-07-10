import 'dart:io';

import 'package:flutter/material.dart';
import 'article.dart';

class ArticleCardHome extends StatefulWidget {
  final Article article;

  const ArticleCardHome({required this.article});

  @override
  State<ArticleCardHome> createState() {
    return _ArticleCardHomeState();
  }
}

class _ArticleCardHomeState extends State<ArticleCardHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          //width: MediaQuery.of(context).size.width/2,
          //height: 200,
          constraints: BoxConstraints.expand(
              width: (MediaQuery.of(context).size.width/1.5),
              height: 160
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(File(widget.article.image)),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    widget.article.name,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
