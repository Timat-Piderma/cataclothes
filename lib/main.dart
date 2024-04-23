import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cataclothes/data_manager.dart';
import 'package:cataclothes/settings_manager.dart';
import 'package:cataclothes/settings_screen.dart';
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
  final SettingsManager _settingsManager = SettingsManager();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _dataManager,
        ),


        ChangeNotifierProvider(
          create: (context) => _settingsManager,
        ),
      ],
      child: Consumer<SettingsManager>(
        builder: (context, settingsManager, child) {
          ThemeData maintheme;
          if (settingsManager.darkMode){
            maintheme = CataClothesTheme.dark();
          } else {
            maintheme = CataClothesTheme.light();
          }

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
      //extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          //backgroundColor: Colors.black12,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/logo_alpha.png',
                fit: BoxFit.cover,
                height: 35.0,
              ),
              Text(
                widget.title,
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                child: const Icon(Icons.settings),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SettingsScreen();
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),

      body: IndexedStack(
        index: _selectedTabIndex,
        children: _pages,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTabIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: "Shop",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: "Planner",
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.warehouse),
            label: "Armadio",
          ),
          NavigationDestination(
            icon: Icon(Icons.hail),
            label: "Outfits",
          ),
        ],
      ),
    );
  }
}