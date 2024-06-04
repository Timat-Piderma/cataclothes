import 'package:cataclothes/category.dart';

import 'article.dart';
import 'article_color.dart';
import 'outfit.dart';

class SampleData {
  static Article cappello1 = Article(
    name: 'Berretto',
    image: 'assets/articles/berretto.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    category: cat1,
  );

  static Article cappello2 = Article(
    name: 'Cappello2',
    image: 'assets/articles/cappello2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    category: cat1,
  );

  static Article cappello3 = Article(
    name: 'Cappello3',
    image: 'assets/articles/cappello3.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: gray,
    category: cat1,
  );

  static Article gonna1 = Article(
    name: 'Gonna1',
    image: 'assets/articles/gonna1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: teal,
    category: cat1,
  );

  static Article gonna2 = Article(
    name: 'Gonna2',
    image: 'assets/articles/gonna2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: red,
    category: cat1,
  );

  static Article maglietta4 = Article(
    name: 'Maglietta4',
    image: 'assets/articles/hawaii.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    category: cat1,
  );

  static Article jeans1 = Article(
    name: 'Jeans1',
    image: 'assets/articles/jeans1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: gray,
    category: cat1,
  );

  static Article jeans2 = Article(
    name: 'Jeans2',
    image: 'assets/articles/jeans2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    category: cat3,
  );

  static Article jeans3 = Article(
    name: 'Jeans3',
    image: 'assets/articles/jeans3.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    category: cat1,
  );

  static Article maglietta1 = Article(
    name: 'Maglietta1',
    image: 'assets/articles/maglietta1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: red,
    category: cat1,
  );

  static Article maglietta2 = Article(
    name: 'Maglietta2',
    image: 'assets/articles/maglietta2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    category: cat1,
  );

  static Article maglietta3 = Article(
    name: 'Maglietta3',
    image: 'assets/articles/maglietta3.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    category: cat1,
  );

  static Article scarpe1 = Article(
    name: 'Scarpe1',
    image: 'assets/articles/scarpe1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: gray,
    category: cat1,
  );

  static Article scarpe2 = Article(
    name: 'Scarpe2',
    image: 'assets/articles/scarpe2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: red,
    category: cat2,
  );

  static Article scarpe3 = Article(
    name: 'Scarpe3',
    image: 'assets/articles/scarpe3.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    category: cat1,
  );

  static Article shorts1 = Article(
    name: 'Shorts1',
    image: 'assets/articles/shorts1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    category: cat1,
  );

  static Article shorts2 = Article(
    name: 'Shorts2',
    image: 'assets/articles/shorts2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    category: cat1,
  );

  static List<Article> allArticles = [
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

  static List<Article> favouriteArticles = [];

  static Outfit outfit1 = Outfit(
    name: 'Outfit1',
    image: 'assets/outfits/placeholder_outfit.jpg',
    cost: "999.00 €",
    category: cat1,
    isFavourite: false,
  );
  static Outfit outfit2 = Outfit(
    name: 'Outfit1',
    image: 'assets/outfits/placeholder_outfit.jpg',
    cost: "999.00 €",
    category: cat2,
    isFavourite: false,
  );
  static Outfit outfit3 = Outfit(
    name: 'Outfit1',
    image: 'assets/outfits/placeholder_outfit.jpg',
    cost: "99.00 €",
    category: cat2,
    isFavourite: false,
  );
  static Outfit outfit4 = Outfit(
    name: 'Outfit1',
    image: 'assets/outfits/placeholder_outfit.jpg',
    cost: "999.00 €",
    category: cat3,
    isFavourite: false,
  );

  static List<Outfit> allOutfits = [outfit1, outfit2, outfit3, outfit4];

  static List<Outfit> favouriteOutfits = [];

  static List<Article> featuredItems = [
    maglietta3,
  ];

  static Category cat1 = Category(name: 'cat1', id: 1);
  static Category cat2 = Category(name: 'cat2', id: 2);
  static Category cat3 = Category(name: 'cat3', id: 3);

  static List<Category> allCategories = [
    cat1,
    cat2,
    cat3,
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
