import 'dart:io';

import 'package:cataclothes/category_article.dart';
import 'package:cataclothes/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'category_outfit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  bool isEditing = true;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerBackup = TextEditingController();

  Map<String, double> articleData = {};
  Map<String, double> outfitData = {};

  @override
  void initState() {
    for (ArticleCategory ac in DataManager.getAllArticlesCategories()) {
      if (DataManager().countArticleOfCategory(ac).toDouble() > 0) {
        articleData.putIfAbsent(
            ac.name, () => DataManager().countArticleOfCategory(ac).toDouble());
      }
    }

    for (OutfitCategory oc in DataManager.getAllOutfitsCategories()) {
      if (DataManager().countOutfitOfCategory(oc).toDouble() > 0) {
        outfitData.putIfAbsent(
            oc.name, () => DataManager().countOutfitOfCategory(oc).toDouble());
      }
    }

    controllerName.text = "John Doe";
    controllerBackup.text = "18/06/2024 15:30";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text("Profilo"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, left: 15),
                    child: CircleAvatar(
                      backgroundColor: Colors.lightBlueAccent,
                      foregroundImage: AssetImage("assets/icons/pfp.png"),
                      radius: 80,
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, right: 15, bottom: 8, left: 15),
                      child: Column(
                        children: [
                          TextField(
                            readOnly: isEditing,
                            style: const TextStyle(fontSize: 18),
                            controller: controllerName,
                            decoration: InputDecoration(
                              suffixIcon: isEditing
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditing = false;
                                        });
                                      },
                                      icon: const Icon(Icons.mode),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditing = true;
                                        });
                                      },
                                      icon: const Icon(Icons.check),
                                    ),
                              labelText: 'Nome',
                            ),
                          ),
                          IgnorePointer(
                            child: TextField(
                              style: const TextStyle(fontSize: 18),
                              controller: controllerBackup,
                              decoration: const InputDecoration(
                                labelText: 'Ultimo Backup',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            const Divider(),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 8, right: 8, bottom: 8),
                child: Text(
                  "Dettagli Armadio",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              )
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
              child: articleData.isEmpty
                  ? Text("Nessun articolo nell'armadio")
                  : PieChart(
                      dataMap: articleData,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 30,
                      centerWidget: Text(
                        "${DataManager.getAllArticles().length} Vestiti",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.bottom,
                      ),
                      chartValuesOptions:
                          const ChartValuesOptions(showChartValues: false),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
              child: outfitData.isEmpty
                  ? Text("Nessun outfit nell'armadio")
                  : PieChart(
                      dataMap: outfitData,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 30,
                      centerWidget: Text(
                        "${DataManager.getAllOutfits().length} Outfit",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.bottom,
                      ),
                      chartValuesOptions:
                          const ChartValuesOptions(showChartValues: false),
                    ),
            ),
          ],
        ),
      ),
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
