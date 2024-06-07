import 'dart:io';
import 'dart:typed_data';

import 'package:cataclothes/screen_add_outfit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import 'article.dart';

import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';

class ScreenAddPhotoOutfitPreview extends StatefulWidget {
  final List<Article> articles;

  const ScreenAddPhotoOutfitPreview({required this.articles});

  @override
  State<ScreenAddPhotoOutfitPreview> createState() {
    return ScreenAddPhotoOutfitPreviewState();
  }
}

class ScreenAddPhotoOutfitPreviewState
    extends State<ScreenAddPhotoOutfitPreview>
    with SingleTickerProviderStateMixin {
  late LindiController lindiController;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    lindiController =
        LindiController(borderColor: Colors.white, iconColor: Colors.black);

    for (Article art in widget.articles) {
      lindiController.addWidget(
        SizedBox(
            height: 100,
            width: 100,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: getImage(art.image))),
            )),
      );
    }
  }

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
            title: Text("Crea Outfit"),
            backgroundColor: Colors.tealAccent,
          ),
        ),
        body: ListView(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 10, top: 20),
                child: FilledButton(
                  child: Text(
                    "Conferma",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onPressed: () => {takeScreenShot()},
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 10,
                top: 20,
              ),
              child: Center(
                child: Screenshot(
                  controller: screenshotController,
                  child: LindiStickerWidget(
                    controller: lindiController,
                    child: Container(
                      height: computeWidth() - (computeWidth() / 10),
                      width: computeWidth() - (computeWidth() / 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  ImageProvider getImage(String path) {
    if (File(path).existsSync()) {
      return FileImage(File(path));
    } else {
      return AssetImage(path);
    }
  }

  void takeScreenShot() async {
    Uint8List? i = await screenshotController.capture();

    final Directory temp = await getTemporaryDirectory();

    if (i != null) {
      String path =
          temp.path + DateTime.now().microsecondsSinceEpoch.toString() + ".png";

      XFile x = XFile.fromData(i!);
      x.saveTo(path);

      File img = File(path);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ScreenAddOutfit(photo: img);
          },
        ),
      );
    }
  }
}
