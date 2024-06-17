import 'dart:io';

import 'package:flutter/material.dart';

class ManageCategoriesScreen extends StatefulWidget {
  @override
  State<ManageCategoriesScreen> createState() {
    return _ManageCategoriesScreenState();
  }
}

class _ManageCategoriesScreenState extends State<ManageCategoriesScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Text("Gestisci Categorie"),
          backgroundColor: Colors.tealAccent,
        ),
      ),

      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(eccentricity: 1),
        backgroundColor: Colors.amberAccent,
        child: const Icon(Icons.add, color: Colors.black, size: 40),
        onPressed: () => {},
      ),

      body: ListView(),
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
