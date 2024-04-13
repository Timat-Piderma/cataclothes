import 'package:flutter/material.dart';
import 'article.dart';
import 'sample_data.dart';
import 'outfit.dart';

class DataManager extends ChangeNotifier {

  final List<Article> _allArticles = SampleData.allArticles;
  final List<Outfit> _allOutfits = SampleData.allOutfits;
  final List<Article> _favouriteArticles = SampleData.favouriteArticles;
  final List<Outfit> _favouriteOutfits = SampleData.favouriteOutfits;

  List<Article> get allArticles => List.unmodifiable(_allArticles);
  List<Outfit> get allOutfits => List.unmodifiable(_allOutfits);
  List<Article> get favouriteArticles => List.unmodifiable(_favouriteArticles);
  List<Outfit> get favouriteOutfits => List.unmodifiable(_favouriteOutfits);

 void _deleteFavouriteArticle(int index){
    _favouriteArticles.removeAt(index);
    notifyListeners();
  }

  void _addFavouriteArticle(Article item){
    _favouriteArticles.add(item);
    notifyListeners();
  }

  void updateFavouriteArticlesList(Article item, bool newValue){
    if (newValue) {
      _addFavouriteArticle(item);
    } else {
      final int _favouriteArticleIndex = _favouriteArticles.indexWhere((element) => element.name==item.name);
      _deleteFavouriteArticle(_favouriteArticleIndex);
    }
  }

  void updateFavouriteArticleValue(Article item, bool newValue){
    final int _allArticlesIndex = _allArticles.indexWhere((element) => element.name==item.name);

    if (_allArticlesIndex!=-1){
      _allArticles[_allArticlesIndex].isFavourite = newValue;
    }
    notifyListeners();
  }

  static List<Article> getAllArticles() {
    // Simulate api request wait time
    // await Future.delayed(const Duration(milliseconds: 5000));

    return List.unmodifiable(SampleData.allArticles);

  }

  void _deleteFavouriteOutfit(int index){
    _favouriteOutfits.removeAt(index);
    notifyListeners();
  }

  void _addFavouriteOutfit(Outfit item){
    _favouriteOutfits.add(item);
    notifyListeners();
  }

  void updateFavouriteOutfitList(Outfit item, bool newValue){
    if (newValue) {
      _addFavouriteOutfit(item);
    } else {
      final int _favouriteOutfitIndex = _favouriteOutfits.indexWhere((element) => element.name==item.name);
      _deleteFavouriteOutfit(_favouriteOutfitIndex);
    }
  }

  void updateFavouriteOutfitValue(Outfit item, bool newValue){
    final int _allOutfitsIndex = _allOutfits.indexWhere((element) => element.name==item.name);

    if (_allOutfitsIndex!=-1){
      _allOutfits[_allOutfitsIndex].isFavourite = newValue;
    }
    notifyListeners();
  }

  static List<Outfit> getAllOutfits() {
    // Simulate api request wait time
    // await Future.delayed(const Duration(milliseconds: 5000));

    return List.unmodifiable(SampleData.allOutfits);

  }

}
