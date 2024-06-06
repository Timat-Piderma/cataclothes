import 'dart:io';

import 'package:cataclothes/category.dart';
import 'package:cataclothes/screen_add_photo_article_preview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'article.dart';
import 'article_detail.dart';
import 'data_manager.dart';
import 'item_grid.dart';
import 'item_horizontal_list.dart';
import 'searchbar.dart';

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

  Category? filter;
  List<Article> filteredArticles = DataManager().allArticles;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return Scaffold(
            floatingActionButton: FloatingActionButton.large(
              shape: const CircleBorder(eccentricity: 1),
              backgroundColor: Colors.amberAccent,
              child: const Icon(Icons.add, color: Colors.black, size: 60),
              onPressed: () => {_pickImageFromGallery()},
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
                    func: (Article art) {
                      setFilter(art);
                    }),
              ),
              const Divider(),
              Expanded(
                flex: 11,
                child: ItemGrid(
                  items: filteredArticles,
                  type: 0,
                  func: (Article art) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ArticleDetail(article: art);
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

  List<Article> getFilterItems() {
    List<Article> res = [];
    for (var cat in DataManager.getAllCategories()) {
      if (DataManager.getFilterArticle(cat) != null) {
        res.add(DataManager.getFilterArticle(cat)!);
      }
    }
    return res;
  }

  void setFilter(Article art) {
    if (filter != art.category) {
      filter = art.category;

      List<Article> res = [];
      if (filter != null) {
        res.addAll(DataManager()
            .allArticles
            .where((element) => element.category == filter));
        setState(() {
          filteredArticles = res;
        });
      }
    } else
      setState(() {
        filter = null;
        filteredArticles = DataManager().allArticles;
      });
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ScreenAddPhotoArticlePreview(photo: File(returnedImage!.path));
        },
      ),
    );
  }
}
