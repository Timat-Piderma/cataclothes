import 'package:cataclothes/screen_manage_article_categories.dart';
import 'package:cataclothes/screen_manage_outfit_categories.dart';
import 'package:cataclothes/screen_profile.dart';
import 'package:cataclothes/screen_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cataclothes/data_manager.dart';
import 'package:cataclothes/app_theme.dart';
import 'package:cataclothes/screen_home.dart';
import 'package:cataclothes/screen_closet.dart';
import 'package:cataclothes/screen_outfits.dart';
import 'package:cataclothes/screen_planner.dart';
import 'package:cataclothes/screen_shop.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CataClothes());
}

class CataClothes extends StatefulWidget {
  @override
  State<CataClothes> createState() => _CataClothesAppState();
}

class _CataClothesAppState extends State<CataClothes> {
  final DataManager _dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _dataManager,
        ),
      ],
      child: Consumer(
        builder: (context, settingsManager, child) {
          ThemeData maintheme;

          maintheme = CataClothesTheme.light();

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Catà-Clothes",
            theme: maintheme,
            home: const CataClothesAppHome(title: "Catà-Clothes"),
          );
        },
      ),
    );
  }
}

class CataClothesAppHome extends StatefulWidget {
  const CataClothesAppHome({required this.title});

  final String title;

  @override
  State<CataClothesAppHome> createState() => _CataClothesAppHomeState();
}

class _CataClothesAppHomeState extends State<CataClothesAppHome> {
  int _selectedTabIndex = 2;
  final List<Widget> _pages = <Widget>[
    ShopScreen(),
    PlannerScreen(),
    HomeScreen(),
    ClosetScreen(),
    OutfitsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: PopupMenuButton(
                  child: const Icon(Icons.more_vert),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    if (_selectedTabIndex == 3)
                      PopupMenuItem(
                        height: 40,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ManageArticleCategoriesScreen();
                              },
                            ),
                          );
                        },
                        child: Text("Gestisci Categorie",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    if (_selectedTabIndex == 4)
                      PopupMenuItem(
                        height: 40,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ManageOutfitCategoriesScreen();
                              },
                            ),
                          );
                        },
                        child: Text("Gestisci Categorie",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    PopupMenuItem(
                      height: 40,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SettingsScreen();
                            },
                          ),
                        );
                      },
                      child: Text('Impostazioni',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    PopupMenuItem(
                      height: 40,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProfileScreen();
                            },
                          ),
                        );
                      },
                      child: Text('Profilo',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ))
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedTabIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border(top: BorderSide(color: Colors.black, width: 1.0))),
        child: NavigationBar(
          selectedIndex: _selectedTabIndex,
          onDestinationSelected: _onItemTapped,
          destinations: [
            NavigationDestination(
              icon: _selectedTabIndex == 0
                  ? _buildSelectedIcon(Icons.shopping_cart)
                  : Icon(Icons.shopping_cart),
              label: 'Shop',
            ),
            NavigationDestination(
              icon: _selectedTabIndex == 1
                  ? _buildSelectedIcon(Icons.calendar_month)
                  : Icon(Icons.calendar_month),
              label: "Planner",
            ),
            NavigationDestination(
              icon: _selectedTabIndex == 2
                  ? _buildSelectedIcon(Icons.home)
                  : Icon(Icons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: _selectedTabIndex == 3
                  ? _buildSelectedIconImage("assets/icons/tshirt_icon.png")
                  : ImageIcon(AssetImage("assets/icons/tshirt_icon.png")),
              label: "Armadio",
            ),
            NavigationDestination(
              icon: _selectedTabIndex == 4
                  ? _buildSelectedIconImage("assets/icons/coathanger_icon.png")
                  : ImageIcon(AssetImage("assets/icons/coathanger_icon.png")),
              label: "Outfits",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedIcon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 116, 167, 163),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8),
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget _buildSelectedIconImage(String icon) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 116, 167, 163),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8),
      child: ImageIcon(AssetImage(icon), color: Colors.white),
    );
  }
}
