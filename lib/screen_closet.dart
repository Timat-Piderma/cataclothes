import 'dart:io';

import 'package:cataclothes/add_photo_preview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
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
                    items: DataManager.getAllArticles(), type: 0),
              ),
              const Divider(),
              Expanded(
                flex: 11,
                child: ItemGrid(
                  items: DataManager.getAllArticles(),
                  type: 0,
                ),
              ),
            ]));
      },
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddPhotoPreview(photo: File(returnedImage!.path));
        },
      ),
    );
  }
}
