import 'package:cataclothes/article_color.dart';
import 'package:cataclothes/category_article.dart';
import 'package:flutter/material.dart';
import 'article.dart';
import 'article_store.dart';
import 'category_outfit.dart';
import 'sample_data.dart';
import 'outfit.dart';

class DataManager extends ChangeNotifier {
  final List<Article> _allArticles = SampleData.allArticles;
  final List<Outfit> _allOutfits = SampleData.allOutfits;
  final List<Article> _favouriteArticles = SampleData.favouriteArticles;
  final List<Outfit> _favouriteOutfits = SampleData.favouriteOutfits;
  final List<ArticleCategory> _allArticlesCategories =
      SampleData.allArticlesCategories;
  final List<OutfitCategory> _allOutfitsCategories =
      SampleData.allOutfitsCategories;
  final List<ArticleColor> _allColors = SampleData.allColors;
  final List<ArticleStore> _allStoreArticles = SampleData.allStoreArticles;

  List<Article> get allArticles => List.unmodifiable(_allArticles);

  List<Outfit> get allOutfits => List.unmodifiable(_allOutfits);

  List<Article> get favouriteArticles => List.unmodifiable(_favouriteArticles);

  List<Outfit> get favouriteOutfits => List.unmodifiable(_favouriteOutfits);

  List<ArticleCategory> get allArticlesCategories =>
      List.unmodifiable(_allArticlesCategories);

  List<OutfitCategory> get allOutfitsCategories =>
      List.unmodifiable(_allOutfitsCategories);

  List<ArticleColor> get allColors => List.unmodifiable(_allColors);

  List<Article> get allStoreArticles => List.unmodifiable(_allStoreArticles);

  void _deleteFavouriteArticle(int index) {
    _favouriteArticles.removeAt(index);
    notifyListeners();
  }

  void _addFavouriteArticle(Article item) {
    _favouriteArticles.add(item);
    notifyListeners();
  }

  void _deleteArticle(int index) {
    _allArticles.removeAt(index);
    notifyListeners();
  }

  void addArticle(Article item) {
    _allArticles.add(item);
    notifyListeners();
  }

  void addOutfit(Outfit item) {
    _allOutfits.add(item);
    notifyListeners();
  }

  void updateFavouriteArticlesList(Article item, bool newValue) {
    if (newValue) {
      _addFavouriteArticle(item);
    } else {
      final int _favouriteArticleIndex =
          _favouriteArticles.indexWhere((element) => element.name == item.name);
      _deleteFavouriteArticle(_favouriteArticleIndex);
    }
  }

  void updateFavouriteArticleValue(Article item, bool newValue) {
    final int _allArticlesIndex =
        _allArticles.indexWhere((element) => element.name == item.name);

    if (_allArticlesIndex != -1) {
      _allArticles[_allArticlesIndex].isFavourite = newValue;
    }
    notifyListeners();
  }

  static List<Article> getAllArticles() {
    return List.unmodifiable(SampleData.allArticles);
  }

  void _deleteFavouriteOutfit(int index) {
    _favouriteOutfits.removeAt(index);
    notifyListeners();
  }

  void _addFavouriteOutfit(Outfit item) {
    _favouriteOutfits.add(item);
    notifyListeners();
  }

  void updateFavouriteOutfitList(Outfit item, bool newValue) {
    if (newValue) {
      _addFavouriteOutfit(item);
    } else {
      final int _favouriteOutfitIndex =
          _favouriteOutfits.indexWhere((element) => element.name == item.name);
      _deleteFavouriteOutfit(_favouriteOutfitIndex);
    }
  }

  void updateFavouriteOutfitValue(Outfit item, bool newValue) {
    final int _allOutfitsIndex =
        _allOutfits.indexWhere((element) => element.name == item.name);

    if (_allOutfitsIndex != -1) {
      _allOutfits[_allOutfitsIndex].isFavourite = newValue;
    }
    notifyListeners();
  }

  static List<Outfit> getAllOutfits() {
    return List.unmodifiable(SampleData.allOutfits);
  }

  static Article getFeaturedItem() {
    // Simulate api request wait time
    // await Future.delayed(const Duration(milliseconds: 5000));

    return SampleData.featuredItems[0];
  }

  static List<ArticleCategory> getAllArticlesCategories() {
    return List.unmodifiable(SampleData.allArticlesCategories);
  }

  static List<OutfitCategory> getAllOutfitsCategories() {
    return List.unmodifiable(SampleData.allOutfitsCategories);
  }

  static List<ArticleColor> getAllColors() {
    return List.unmodifiable(SampleData.allColors);
  }

  static Article? getFilterArticle(ArticleCategory cat) {
    for (var element in SampleData.allArticles) {
      if (element.articleCategory == cat) {
        return element;
      }
    }
    return null;
  }

  static Outfit? getFilterOutfit(OutfitCategory cat) {
    for (var element in SampleData.allOutfits) {
      if (element.outfitCategory == cat) {
        return element;
      }
    }
    return null;
  }

  static List<ArticleStore> getStoreArticles() {
    return List.unmodifiable(SampleData.allStoreArticles);
  }
}
