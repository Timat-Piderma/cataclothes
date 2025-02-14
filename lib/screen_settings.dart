import 'dart:io';

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen>
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
          title: const Text("Impostazioni"),
        ),
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
