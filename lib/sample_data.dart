import 'article.dart';
import 'article_color.dart';
import 'category_article.dart';
import 'category_outfit.dart';
import 'outfit.dart';

class SampleData {
  static Article black_jeans = Article(
    name: 'Black Jeans',
    image: 'assets/articles/closet/black_jeans.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    articleCategory: ca_jeans,
  );

  static Article cyan_shirt = Article(
    name: 'Cyan Shirt',
    image: 'assets/articles/closet/cyan_shirt.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_camice,
  );

  static Article gray_pants = Article(
    name: 'Gray Pants',
    image: 'assets/articles/closet/gray_pants.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: gray,
    articleCategory: ca_pantaloni,
  );

  static Article jeans = Article(
    name: 'Jeans',
    image: 'assets/articles/closet/jeans.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_jeans,
  );

  static Article yellow_tshirt = Article(
    name: 'Black Jeans',
    image: 'assets/articles/closet/yellow_tshirt.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: yellow,
    articleCategory: ca_tshirt,
  );

  static List<Article> allArticles = [
    black_jeans,
    cyan_shirt,
    gray_pants,
    jeans,
    yellow_tshirt
  ];

  static List<Article> favouriteArticles = [];

  static Article cappello1 = Article(
    name: 'Berretto',
    image: 'assets/articles/store/berretto.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    articleCategory: ca_cappelli,
  );

  static Article cappello2 = Article(
    name: 'Cappello2',
    image: 'assets/articles/store/cappello2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    articleCategory: ca_cappelli,
  );

  static Article cappello3 = Article(
    name: 'Cappello3',
    image: 'assets/articles/store/cappello3.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: gray,
    articleCategory: ca_cappelli,
  );

  static Article gonna1 = Article(
    name: 'Gonna1',
    image: 'assets/articles/store/gonna1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: teal,
    articleCategory: ca_gonne,
  );

  static Article gonna2 = Article(
    name: 'Gonna2',
    image: 'assets/articles/store/gonna2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: red,
    articleCategory: ca_gonne,
  );

  static Article maglietta4 = Article(
    name: 'Maglietta4',
    image: 'assets/articles/store/hawaii.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_tshirt,
  );

  static Article jeans1 = Article(
    name: 'Jeans1',
    image: 'assets/articles/store/jeans1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: gray,
    articleCategory: ca_jeans,
  );

  static Article jeans2 = Article(
    name: 'Jeans2',
    image: 'assets/articles/store/jeans2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_jeans,
  );

  static Article jeans3 = Article(
    name: 'Jeans3',
    image: 'assets/articles/store/jeans3.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_jeans,
  );

  static Article maglietta1 = Article(
    name: 'Maglietta1',
    image: 'assets/articles/store/maglietta1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: red,
    articleCategory: ca_tshirt,
  );

  static Article maglietta2 = Article(
    name: 'Maglietta2',
    image: 'assets/articles/store/maglietta2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    articleCategory: ca_tshirt,
  );

  static Article maglietta3 = Article(
    name: 'Maglietta3',
    image: 'assets/articles/store/maglietta3.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    articleCategory: ca_tshirt,
  );

  static Article scarpe1 = Article(
    name: 'Scarpe1',
    image: 'assets/articles/store/scarpe1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: gray,
    articleCategory: ca_scarpe,
  );

  static Article scarpe2 = Article(
    name: 'Scarpe2',
    image: 'assets/articles/store/scarpe2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: red,
    articleCategory: ca_scarpe,
  );

  static Article scarpe3 = Article(
    name: 'Scarpe3',
    image: 'assets/articles/store/scarpe3.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_scarpe,
  );

  static Article shorts1 = Article(
    name: 'Shorts1',
    image: 'assets/articles/store/shorts1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_pantaloni,
  );

  static Article shorts2 = Article(
    name: 'Shorts2',
    image: 'assets/articles/store/shorts2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_pantaloni,
  );

  static Outfit outfit1 = Outfit(
    name: 'Outfit1',
    image: 'assets/outfits/outfit1.jpg',
    cost: "999.00 €",
    outfitCategory: co_casual,
    isFavourite: false,
  );
  static Outfit outfit2 = Outfit(
    name: 'Outfit1',
    image: 'assets/outfits/outfit2.jpg',
    cost: "999.00 €",
    outfitCategory: co_casual,
    isFavourite: false,
  );

  static List<Outfit> allOutfits = [outfit1, outfit2];

  static List<Outfit> favouriteOutfits = [];

  static List<Article> storeArticle = [
    cappello1,
    cappello2,
    cappello3,
    gonna1,
    gonna2,
    maglietta1,
    maglietta2,
    maglietta3,
    maglietta4,
    scarpe1,
    scarpe2,
    scarpe3,
    shorts1,
    shorts2,
    jeans1,
    jeans2,
    jeans3
  ];

  static List<Article> featuredItems = [
    maglietta3,
  ];

  static ArticleCategory ca_camice = ArticleCategory(name: 'Camice', id: 1);
  static ArticleCategory ca_scarpe = ArticleCategory(name: 'Scarpe', id: 2);
  static ArticleCategory ca_tshirt = ArticleCategory(name: 'T-Shirt', id: 3);
  static ArticleCategory ca_jeans = ArticleCategory(name: 'Jeans', id: 4);
  static ArticleCategory ca_pantaloni =
      ArticleCategory(name: 'Pantaloni', id: 5);
  static ArticleCategory ca_cappelli = ArticleCategory(name: 'Cappelli', id: 6);
  static ArticleCategory ca_gonne = ArticleCategory(name: 'Gonne', id: 7);

  static List<ArticleCategory> allArticlesCategories = [
    ca_camice,
    ca_scarpe,
    ca_tshirt,
    ca_jeans,
    ca_pantaloni,
    ca_cappelli,
    ca_gonne
  ];

  static OutfitCategory co_casual = OutfitCategory(name: 'Casual', id: 1);
  static OutfitCategory co_sera = OutfitCategory(name: 'Sera', id: 2);
  static OutfitCategory co_elegante = OutfitCategory(name: 'Elegante', id: 3);

  static List<OutfitCategory> allOutfitsCategories = [
    co_casual,
    co_elegante,
    co_sera,
  ];

  static ArticleColor red = ArticleColor(name: 'red', id: 1);
  static ArticleColor blue = ArticleColor(name: 'blue', id: 2);
  static ArticleColor yellow = ArticleColor(name: 'yellow', id: 3);
  static ArticleColor black = ArticleColor(name: 'black', id: 4);
  static ArticleColor gray = ArticleColor(name: 'gray', id: 5);
  static ArticleColor teal = ArticleColor(name: 'teal', id: 6);

  static List<ArticleColor> allColors = [
    red,
    blue,
    yellow,
    black,
    gray,
    teal,
  ];
}
