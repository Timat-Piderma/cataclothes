import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_manager.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({
    super.key,
  });

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          title: Text("Settings"),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: buildMenu(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenu() {
    return ListView(
      children: [
        buildDarkModeRow(),
      ],
    );
  }

  Widget buildDarkModeRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Dark Mode'),
          Consumer<SettingsManager>(
            builder: (context, settingsManager, child) {
              return Switch(
                value: settingsManager.darkMode,
                onChanged: (value) {
                  settingsManager.darkMode = value;
                },
              );
            },
          )
        ],
      ),
    );
  }
}