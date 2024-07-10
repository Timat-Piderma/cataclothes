import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

import 'package:cataclothes/screen_add_article.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ScreenAddPhotoArticlePreview extends StatefulWidget {
  final File photo;

  const ScreenAddPhotoArticlePreview({super.key, required this.photo});

  @override
  State<ScreenAddPhotoArticlePreview> createState() {
    return ScreenAddPhotoArticlePreviewState();
  }
}

class ScreenAddPhotoArticlePreviewState
    extends State<ScreenAddPhotoArticlePreview>
    with SingleTickerProviderStateMixin {
  List<List<Offset?>> _lines = [];

  File? maskedImage;

  @override
  void initState() {
    maskedImage = widget.photo;
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
            title: const Text("Ritaglia Foto"),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: FilledButton(
                    onPressed: _undo,
                    child: const Icon(Icons.undo, color: Colors.black),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, top: 20),
                      child: FilledButton(
                        child: Text(
                          "Conferma",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onPressed: () async => {
                          await _createMask(),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ScreenAddArticle(photo: maskedImage!);
                              },
                            ),
                          )
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                top: 20,
              ),
              child: Center(
                child: Container(
                  height: computeWidth() - (computeWidth() / 10),
                  width: computeWidth() - (computeWidth() / 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.file(widget.photo!, fit: BoxFit.cover),
                      ),
                      GestureDetector(
                        onPanStart: (details) {
                          setState(() {
                            RenderBox renderBox =
                                context.findRenderObject() as RenderBox;
                            Offset localPosition =
                                renderBox.globalToLocal(details.localPosition);

                            if (_isWithinBounds(localPosition)) {
                              _lines.add([localPosition]);
                            }
                          });
                        },
                        onPanUpdate: (details) {
                          setState(() {
                            RenderBox renderBox =
                                context.findRenderObject() as RenderBox;
                            Offset localPosition =
                                renderBox.globalToLocal(details.localPosition);

                            if (_isWithinBounds(localPosition)) {
                              _lines.last.add(localPosition);
                            }
                          });
                        },
                        onPanEnd: (details) {
                          _lines.last.add(null);
                        },
                        child: CustomPaint(
                          painter: DrawingPainter(_lines),
                          size: Size.infinite,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> _createMask() async {
    await _saveMaskedImage();
  }

  void _undo() {
    setState(() {
      if (_lines.isNotEmpty) {
        _lines.removeLast();
      }
    });
  }

  Future<void> _saveMaskedImage() async {
    try {
      // Ridimensiona immagine
      Uint8List imageBytes = await widget.photo.readAsBytes();

      img.Image? originalImage = img.decodeImage(imageBytes);

      // Ridimensiona l'immagine
      img.Image resizedImage = img.copyResize(
        originalImage!,
        width: (computeWidth() - (computeWidth() / 10)).toInt(),
        height: (computeWidth() - (computeWidth() / 10)).toInt(),
      );

      List<int> resizedBytes = img.encodePng(resizedImage);

      File resizedFile =
          await File(widget.photo.path).writeAsBytes(resizedBytes);

      // Carica l'immagine di base
      final ByteData imageData =
          ByteData.view(resizedFile.readAsBytesSync().buffer);
      final Uint8List bytes = imageData.buffer.asUint8List();
      final img.Image? baseImage = img.decodeImage(bytes);

      // Verifica che l'immagine sia stata caricata
      if (baseImage == null) {
        throw Exception("Impossibile caricare l'immagine di base.");
      }

      // Crea un recorder per catturare il disegno sul canvas
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(
          recorder,
          Rect.fromPoints(
              const Offset(0, 0),
              Offset(computeWidth() - (computeWidth() / 10),
                  computeWidth() - (computeWidth() / 10))));

      // Disegna l'immagine di base
      final ui.Image baseUiImage = await _loadImage(bytes);
      final paint = Paint();
      canvas.drawImage(baseUiImage, Offset.zero, paint);

      // Crea la maschera come path
      final path = _createClipPath();

      // Applica la maschera cancellando l'area fuori dalla maschera
      paint.blendMode = BlendMode.clear;
      canvas.drawRect(
          Rect.fromLTWH(0, 0, computeWidth() - (computeWidth() / 10),
              computeWidth() - (computeWidth() / 10)),
          paint); // Cancella tutto
      paint.blendMode = BlendMode.srcOver;
      canvas.clipPath(path, doAntiAlias: true);
      canvas.drawImage(baseUiImage, Offset.zero, paint);

      // Converti il canvas in ui.Image
      final ui.Image maskedUiImage = await recorder.endRecording().toImage(
          (computeWidth() - (computeWidth() / 10)).toInt(),
          (computeWidth() - (computeWidth() / 10)).toInt());

      // Converti ui.Image in PNG
      final ByteData? byteData =
          await maskedUiImage.toByteData(format: ui.ImageByteFormat.png);

      // Verifica che i dati byte siano stati ottenuti
      if (byteData == null) {
        throw Exception(
            "Impossibile ottenere i dati byte dall'immagine mascherata.");
      }

      final Uint8List maskedBytes = byteData.buffer.asUint8List();

      // Ottieni il percorso temporaneo per salvare l'immagine
      final Directory tempDir = await getTemporaryDirectory();
      String maskedPath =
          '${tempDir.path}/masked_image_${DateTime.now().microsecondsSinceEpoch}.png';

      // Salva l'immagine mascherata come file
      final File maskedFile = File(maskedPath);
      await maskedFile.writeAsBytes(maskedBytes);

      await _saveMask((computeWidth() - (computeWidth() / 10)).toInt(),
          (computeWidth() - (computeWidth() / 10)).toInt(), path, tempDir);

      setState(() {
        maskedImage = maskedFile;
      });

      print("Immagine salvata: $maskedPath");
    } catch (e) {
      print('Errore nel salvataggio dell\'immagine: $e');
    }
  }

  Future<void> _saveMask(
      int width, int height, Path maskPath, Directory tempDir) async {
    try {
      // Crea un recorder per la maschera
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(
          recorder,
          Rect.fromPoints(
              const Offset(0, 0), Offset(width.toDouble(), height.toDouble())));

      // Disegna la maschera su un canvas bianco
      final paint = Paint();
      paint.color = Colors.black;
      canvas.drawRect(Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
          Paint()..color = Colors.white);
      canvas.drawPath(maskPath, paint);

      // Converti il canvas della maschera in ui.Image
      final ui.Image maskUiImage =
          await recorder.endRecording().toImage(width, height);

      // Converti ui.Image in PNG
      final ByteData? byteData =
          await maskUiImage.toByteData(format: ui.ImageByteFormat.png);

      // Verifica che i dati byte siano stati ottenuti
      if (byteData == null) {
        throw Exception("Impossibile ottenere i dati byte dalla maschera.");
      }

      final Uint8List maskBytes = byteData.buffer.asUint8List();

      // Salva la maschera come file
      String path =
          '${tempDir.path}/mask_${DateTime.now().microsecondsSinceEpoch}.png';
      final File maskFile = File(path);
      await maskFile.writeAsBytes(maskBytes);

      print("Maschera salvata: $path");
    } catch (e) {
      print('Errore nel salvataggio della maschera: $e');
    }
  }

  Future<ui.Image> _loadImage(Uint8List bytes) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(bytes, completer.complete);
    return completer.future;
  }

  Path _createClipPath() {
    final path = Path();
    for (var line in _lines) {
      bool started = false;
      for (int i = 0; i < line.length - 1; i++) {
        if (line[i] != null) {
          if (!started) {
            path.moveTo(line[i]!.dx, line[i]!.dy);
            started = true;
          } else {
            path.lineTo(line[i]!.dx, line[i]!.dy);
          }
        }
      }
    }
    return path;
  }

  bool _isWithinBounds(Offset localPosition) {
    double width = computeWidth() - (computeWidth() / 10);
    double height = computeWidth() - (computeWidth() / 10);
    return localPosition.dx >= 0 &&
        localPosition.dy >= 0 &&
        localPosition.dx <= width &&
        localPosition.dy <= height;
  }
}

class DrawingPainter extends CustomPainter {
  final List<List<Offset?>> lines;

  DrawingPainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (var line in lines) {
      for (int i = 0; i < line.length - 1; i++) {
        if (line[i] != null && line[i + 1] != null) {
          canvas.drawLine(line[i]!, line[i + 1]!, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class MaskedImage extends StatelessWidget {
  final List<List<Offset?>> lines;
  final File image;

  MaskedImage(this.lines, this.image);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DrawingClipper(lines),
      child: Image.file(image, fit: BoxFit.cover),
    );
  }
}

class DrawingClipper extends CustomClipper<Path> {
  final List<List<Offset?>> lines;

  DrawingClipper(this.lines);

  @override
  Path getClip(Size size) {
    final path = Path();
    for (var line in lines) {
      bool started = false;
      for (int i = 0; i < line.length - 1; i++) {
        if (line[i] != null) {
          if (!started) {
            path.moveTo(line[i]!.dx, line[i]!.dy);
            started = true;
          } else {
            path.lineTo(line[i]!.dx, line[i]!.dy);
          }
        }
      }
    }
    return path;
  }

  @override
  bool shouldReclip(DrawingClipper oldClipper) => true;
}
