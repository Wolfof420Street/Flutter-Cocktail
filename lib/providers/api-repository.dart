import 'package:cocktails/models/cocktail.dart';
import 'package:cocktails/providers/cocktail-provider.dart';

import '../models/category.dart';
import '../models/glass.dart';

class ApiRepository {

  final _provider = CocktailProvider();

  Future<Cocktail> fetchAlcoholicCocktailList() {
    return _provider.fetchAlcoholicCocktails();
  }

  Future<Cocktail> fetchNonAlcoholicCocktailList() {
    return _provider.fetchNonAlcoholicCocktails();
  }
  
  Future<Cocktail> getRandomCocktail() {
    return _provider.fetchRandomCocktail();
  }


  Future<Cocktail> getCocktailDetails(String id) {
    return _provider.fetchCocktailDetails(id);
  }

  Future<Cocktail> getCocktailsByGlass(String glass) {
    return _provider.fetchCocktailByGlass(glass);
  }

  Future<Cocktail> getCocktailsByCategory(String glass) {
    return _provider.fetchCocktailByCategory(glass);
  }

  Future<Glass> getGlasses() {
    return _provider.fetchGlasses();
  }

  Future<Categories> getCategories() {
    return _provider.fetchCategories();
  }


}

class NetworkError extends Error {}