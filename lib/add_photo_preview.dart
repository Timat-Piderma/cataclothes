import 'dart:io';

import 'package:flutter/material.dart';

class AddPhotoPreview extends StatefulWidget {
  final File photo;

  const AddPhotoPreview({required this.photo});

  @override
  State<AddPhotoPreview> createState() {
    return AddPhotoPreviewState();
  }
}

class AddPhotoPreviewState extends State<AddPhotoPreview>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {}

  double computeWidth() {
    double width = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).viewPadding;
    double safeWidth = width - padding.left - padding.right;
    return safeWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: Text("Ritaglia Foto"),
            backgroundColor: Colors.tealAccent,
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 10,
                top: 8,
              ),
              child: Container(
                height: computeWidth(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 4),
                  image: DecorationImage(
                    image: FileImage(widget.photo),
                  ),
                ),

                /*     child: Stack(
                    children: [
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: IconButton(
                            icon: Icon(_isFavourited
                                ? Icons.favorite
                                : Icons.favorite_border),
                            iconSize: 28,
                            color: Colors.orange,
                            onPressed: () {
                              setState(() {
                                _isFavourited = !_isFavourited;
                                final dataManager =
                                    Provider.of<DataManager>(context, listen: false);
                                dataManager.updateFavouriteArticleValue(
                                    widget.article, _isFavourited);
                                dataManager.updateFavouriteArticlesList(
                                    widget.article, _isFavourited);
                              });
                            }),
                      )
                    ],
                  ),*/
              ),
            ),
          ],
        ));
  }
}
