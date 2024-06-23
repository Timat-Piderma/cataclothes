import 'dart:io';

import 'package:cataclothes/screen_add_photo_article_preview.dart';
import 'package:cataclothes/custom_searchbar.dart';
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
  ArticleCategory favouriteFilter = ArticleCategory(name: "fav");
  ArticleCategory wishlistFilter = ArticleCategory(name: "wish");
  List<Article> filteredArticles =
      DataManager().wishlistArticles + DataManager().allArticles;

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
        return Stack(children: [
          Column(children: [
            Expanded(
                flex: 1,
                child: CustomSearchBar(
                  func: updateSearchResult,
                )),
            Expanded(
              flex: 1,
              child: ItemHorizontalList(
                items: buildWidgets(getFilterItems()),
                type: 0,
              ),
            ),
            const Divider(),
            Expanded(
              flex: 8,
              child: ItemGrid(
                selectable: false,
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
                  ).then((value) => setState(() {
                        updateSearchResult("");
                      }));
                },
              ),
            ),
          ]),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: ElevatedButton(
                  onPressed: () {
                    _pickImageFromGallery().then((value) => {
                          setState(() {
                            filter = null;
                            filteredArticles = DataManager().allArticles +
                                DataManager().wishlistArticles;
                          })
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.all(15),
                    backgroundColor: Colors.amberAccent, // <-- Button color
                    foregroundColor: Colors.grey, // <-- Splash color
                  ),
                  child: const Icon(Icons.add, color: Colors.black),
                )),
          ),
        ]);
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
            setFilter(a.articleCategory!);
          },
          child: SizedBox(
            width: double.infinity,
            child: ItemBubble(item: a),
          ),
        ),
      ));
    }

    res.add(AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          setFilter(favouriteFilter);
        },
        child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return ClipRRect(
                      child: Container(
                        width: constraints.maxHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.blueGrey, width: 3),
                        ),
                        child: const Icon(Icons.favorite),
                      ),
                    );
                  }),
                ),
                const Text("Preferiti",
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            )),
      ),
    ));
    res.add(AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          setFilter(wishlistFilter);
        },
        child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return ClipRRect(
                      child: Container(
                        width: constraints.maxHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.blueGrey, width: 3),
                        ),
                        child: const Icon(Icons.star),
                      ),
                    );
                  }),
                ),
                const Text("Wishlist",
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            )),
      ),
    ));

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

  void setFilter(ArticleCategory cat) {
    if (filter != cat) {
      filter = cat;

      List<Article> res = [];
      if (filter != null) {
        if (filter!.name == "fav") {
          res.addAll(DataManager()
              .allArticles
              .where((element) => element.isFavourite));
        } else {
          if (filter!.name == "wish") {
            res.addAll(DataManager().wishlistArticles);
          } else {
            res.addAll(
                (DataManager().allArticles + DataManager().wishlistArticles)
                    .where((element) => element.articleCategory == filter));
          }
        }
        setState(() {
          filteredArticles = res;
        });
      }
    } else {
      setState(() {
        filter = null;
        filteredArticles =
            DataManager().allArticles + DataManager().wishlistArticles;
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
        ? DataManager().allArticles + DataManager().wishlistArticles
        : (DataManager().allArticles + DataManager().wishlistArticles)
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    setState(() {
      filteredArticles = result;
    });
  }
}
