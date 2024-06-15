import 'article.dart';

class ArticleStore extends Article {
  String description = "";

  ArticleStore({
    super.image = "",
    super.name = "",
    super.cost = "",
    super.isFavourite = false,
    super.color,
    super.articleCategory,
    this.description = "",
  });
}
