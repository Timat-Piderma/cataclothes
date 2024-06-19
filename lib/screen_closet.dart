import 'dart:io';

import 'package:cataclothes/screen_add_photo_article_preview.dart';
import 'package:cataclothes/custom_searchbar.dart';
import 'package:cataclothes/screen_manage_article_categories.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'article.dart';
import 'article_detail.dart';
import 'category_article.dart';
import 'data_manager.dart';
import 'item_bubble.dart';
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
  ArticleCategory? filter;
  List<Article> filteredArticles = DataManager().allArticles;
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  void initState() {
    setState(() {});
  }

  double computeHeight() {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).viewPadding;
    double safeHeight = height - padding.top - kToolbarHeight;
    return safeHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(eccentricity: 1),
              backgroundColor: Colors.amberAccent,
              child: const Icon(Icons.add, color: Colors.black, size: 40),
              onPressed: () => {
                _pickImageFromGallery().then((value) => {
                      setState(() {
                        filter = null;
                        filteredArticles = DataManager().allArticles;
                      })
                    })
              },
            ),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: computeHeight(),
                child: Column(children: [
                  Expanded(
                      flex: 2,
                      child: CustomSearchBar(
                        func: updateSearchResult,
                      )),
                  Expanded(
                    flex: 3,
                    child: ItemHorizontalList(
                        items: buildWidgets(getFilterItems()),
                        type: 0,
                        func: (Article art) {
                          setFilter(art);
                        }),
                  ),
                  const Divider(),
                  Expanded(
                    flex: 28,
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
                        ).then((value) => setState(() {}));
                      },
                    ),
                  ),
                ]),
              ),
            ));
      },
    );
  }

  List<Widget> buildWidgets(List<Article> items) {
    List<Widget> res = [];

    for (Article a in items) {
      res.add(AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: () {
            setFilter(a);
          },
          child: Container(
            width: double.infinity,
            child: ItemBubble(item: a),
          ),
        ),
      ));
    }
    return res;
  }

  List<Article> getFilterItems() {
    List<Article> res = [];
    for (var cat in DataManager.getAllArticlesCategories()) {
      if (DataManager.getFilterArticle(cat) != null) {
        res.add(DataManager.getFilterArticle(cat)!);
      }
    }
    return res;
  }

  void setFilter(Article art) {
    if (filter != art.articleCategory) {
      filter = art.articleCategory;

      List<Article> res = [];
      if (filter != null) {
        res.addAll(DataManager()
            .allArticles
            .where((element) => element.articleCategory == filter));
        setState(() {
          filteredArticles = res;
        });
      }
    } else {
      setState(() {
        filter = null;
        filteredArticles = DataManager().allArticles;
      });
    }
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      _pickedFile = returnedImage;
    });

    await _cropImage();

    if (_croppedFile != null) {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ScreenAddPhotoArticlePreview(
                photo: File(_croppedFile!.path));
          },
        ),
      );
    }
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      } else {
        _croppedFile = null;
      }
    }
  }

  void updateSearchResult(String query) {
    List<Article> result = query.isEmpty
        ? DataManager().allArticles
        : DataManager()
            .allArticles
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    setState(() {
      filteredArticles = result;
    });
  }
}
