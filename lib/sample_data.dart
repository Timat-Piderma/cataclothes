import 'article.dart';
import 'article_color.dart';
import 'article_store.dart';
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
    color: grey,
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
    name: 'Yellow T-Shirt',
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

  static List<Article> wishlistArticles = [];

  static ArticleStore cappello1 = ArticleStore(
    name: 'Berretto',
    image: 'assets/articles/store/berretto.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    articleCategory: ca_cappelli,
    description: "Desrizione base",
  );

  static ArticleStore cappello2 = ArticleStore(
    name: 'Cappello2',
    image: 'assets/articles/store/cappello2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    articleCategory: ca_cappelli,
    description: "Desrizione base",
  );

  static ArticleStore cappello3 = ArticleStore(
    name: 'Cappello3',
    image: 'assets/articles/store/cappello3.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: grey,
    articleCategory: ca_cappelli,
    description: "Desrizione base",
  );

  static ArticleStore gonna1 = ArticleStore(
    name: 'Gonna1',
    image: 'assets/articles/store/gonna1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: teal,
    articleCategory: ca_gonne,
    description: "Desrizione base",
  );

  static ArticleStore gonna2 = ArticleStore(
    name: 'Gonna2',
    image: 'assets/articles/store/gonna2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: red,
    articleCategory: ca_gonne,
    description: "Desrizione base",
  );

  static ArticleStore maglietta4 = ArticleStore(
    name: 'Maglietta4',
    image: 'assets/articles/store/hawaii.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_tshirt,
    description: "Desrizione base",
  );

  static ArticleStore jeans1 = ArticleStore(
    name: 'Jeans1',
    image: 'assets/articles/store/jeans1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: grey,
    articleCategory: ca_jeans,
    description: "Desrizione base",
  );

  static ArticleStore jeans2 = ArticleStore(
    name: 'Jeans2',
    image: 'assets/articles/store/jeans2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_jeans,
    description: "Desrizione base",
  );

  static ArticleStore jeans3 = ArticleStore(
    name: 'Jeans3',
    image: 'assets/articles/store/jeans3.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_jeans,
    description: "Desrizione base",
  );

  static ArticleStore maglietta1 = ArticleStore(
    name: 'Maglietta1',
    image: 'assets/articles/store/maglietta1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: red,
    articleCategory: ca_tshirt,
    description: "Desrizione base",
  );

  static ArticleStore maglietta2 = ArticleStore(
    name: 'Maglietta2',
    image: 'assets/articles/store/maglietta2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    articleCategory: ca_tshirt,
    description: "Desrizione base",
  );

  static ArticleStore maglietta3 = ArticleStore(
    name: 'Maglietta3',
    image: 'assets/articles/store/maglietta3.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: black,
    articleCategory: ca_tshirt,
    description: "Desrizione base",
  );

  static ArticleStore scarpe1 = ArticleStore(
    name: 'Scarpe1',
    image: 'assets/articles/store/scarpe1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: grey,
    articleCategory: ca_scarpe,
    description: "Desrizione base",
  );

  static ArticleStore scarpe2 = ArticleStore(
    name: 'Scarpe2',
    image: 'assets/articles/store/scarpe2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: red,
    articleCategory: ca_scarpe,
    description: "Desrizione base",
  );

  static ArticleStore scarpe3 = ArticleStore(
    name: 'Scarpe3',
    image: 'assets/articles/store/scarpe3.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_scarpe,
    description: "Desrizione base",
  );

  static ArticleStore shorts1 = ArticleStore(
    name: 'Shorts1',
    image: 'assets/articles/store/shorts1.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_pantaloni,
    description: "Desrizione base",
  );

  static ArticleStore shorts2 = ArticleStore(
    name: 'Shorts2',
    image: 'assets/articles/store/shorts2.jpg',
    cost: "10.00 €",
    isFavourite: false,
    color: blue,
    articleCategory: ca_pantaloni,
    description: "Desrizione base",
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

  static List<ArticleStore> allStoreArticles = [
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

  static ArticleCategory ca_camice = ArticleCategory(name: 'Camicia');
  static ArticleCategory ca_scarpe = ArticleCategory(name: 'Scarpe');
  static ArticleCategory ca_tshirt = ArticleCategory(name: 'T-Shirt');
  static ArticleCategory ca_jeans = ArticleCategory(name: 'Jeans');
  static ArticleCategory ca_pantaloni = ArticleCategory(name: 'Pantaloni');
  static ArticleCategory ca_cappelli = ArticleCategory(name: 'Cappello');
  static ArticleCategory ca_gonne = ArticleCategory(name: 'Gonna');

  static List<ArticleCategory> allArticlesCategories = [
    ca_camice,
    ca_scarpe,
    ca_tshirt,
    ca_jeans,
    ca_pantaloni,
    ca_cappelli,
    ca_gonne
  ];

  static OutfitCategory co_casual = OutfitCategory(name: 'Casual');
  static OutfitCategory co_sera = OutfitCategory(name: 'Sera');
  static OutfitCategory co_elegante = OutfitCategory(name: 'Elegante');

  static List<OutfitCategory> allOutfitsCategories = [
    co_casual,
    co_elegante,
    co_sera,
  ];

  static ArticleColor red = ArticleColor(name: 'Rosso', id: 1);
  static ArticleColor blue = ArticleColor(name: 'Blu', id: 2);
  static ArticleColor yellow = ArticleColor(name: 'Giallo', id: 3);
  static ArticleColor black = ArticleColor(name: 'Nero', id: 4);
  static ArticleColor grey = ArticleColor(name: 'Grigio', id: 5);
  static ArticleColor teal = ArticleColor(name: 'Turchese', id: 7);
  static ArticleColor green = ArticleColor(name: 'Verde', id: 8);
  static ArticleColor orange = ArticleColor(name: 'Arancione', id: 9);
  static ArticleColor beige = ArticleColor(name: 'Beige', id: 10);
  static ArticleColor purple = ArticleColor(name: 'Viola', id: 11);
  static ArticleColor brown = ArticleColor(name: 'Marrone', id: 12);
  static ArticleColor white = ArticleColor(name: 'Bianco', id: 13);
  static ArticleColor lightBlue = ArticleColor(name: 'Azzurro', id: 14);
  static ArticleColor gold = ArticleColor(name: 'Oro', id: 15);
  static ArticleColor silver = ArticleColor(name: 'Argento', id: 16);

  static List<ArticleColor> allColors = [
    orange,
    silver,
    lightBlue,
    beige,
    white,
    blue,
    yellow,
    grey,
    brown,
    black,
    gold,
    red,
    teal,
    green,
    purple
  ];
}
