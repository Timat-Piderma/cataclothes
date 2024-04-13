import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cataclothes/data_manager.dart';
import 'article.dart';

class ArticleDetail extends StatefulWidget {
  final Article article;

  const ArticleDetail({required this.article});

  @override
  State<ArticleDetail> createState() {
    return _ArticleDetailState();
  }
}

// SingleTickerProviderStateMixin serve per permettere di inizializzare vsync a this nel TabController
class _ArticleDetailState extends State<ArticleDetail>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isFavourited = false;
  late TabController _tabController;

  @override
  void initState() {
    _isFavourited = widget.article.isFavourite;
    _tabController =
        TabController(initialIndex: _selectedIndex, length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          title: Text(widget.article.name),
        ),
      ),

      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(widget.article.image),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: IconButton(
                      icon: Icon(_isFavourited ? Icons.favorite : Icons.favorite_border),
                      iconSize: 28,
                      color: Colors.orange,
                      onPressed: () {
                        setState(() {
                          _isFavourited = !_isFavourited;
                          final dataManager = Provider.of<DataManager>(context, listen: false);
                          dataManager.updateFavouriteArticleValue(widget.article, _isFavourited);
                          dataManager.updateFavouriteArticlesList(widget.article, _isFavourited);
                        });
                      }),
                )
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: "Description",
              ),
              Tab(
                text: "Ingredients",
              ),
              Tab(
                text: "Method",
              ),
            ],
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
                _tabController.animateTo(index);
              });
            },
          ),
          IndexedStack(
            index: _selectedIndex,
            children: <Widget>[
              Visibility(
                child: buildDescriptionPanel(),
                maintainState: true,
                visible: _selectedIndex == 0,
              ),
              Visibility(
                child: buildIngredientsPanel(),
                maintainState: true,
                visible: _selectedIndex == 1,
              ),
              Visibility(
                child: buildMethodPanel(),
                maintainState: true,
                visible: _selectedIndex == 2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDescriptionPanel() {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        ListView(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Course",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  " TESTOOOOOO ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cuisine",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  " TESTOOO ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Difficulty",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  " testo ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cost",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "${widget.article.cost}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Preparation time",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "ALTRO TESTO",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildIngredientsPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            "For 999 serving(s)",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  Widget buildMethodPanel() {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
