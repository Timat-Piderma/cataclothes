import 'article.dart';

class ArticleStore extends Article {
  String description = "";
  bool isWishlist = false;

  ArticleStore({
    super.image = "",
    super.name = "",
    super.cost = "",
    super.brand = "",
    super.taglia = "",
    super.isFavourite = false,
    super.color,
    super.articleCategory,
    this.description = "",
    this.isWishlist = false,
  });
}
