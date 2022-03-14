import 'package:cocktails/models/cocktail.dart';
import 'package:cocktails/providers/cocktail-provider.dart';

class ApiRepository {
  final _provider = CocktailProvider();

  Future<Cocktail> fetchAlcoholicCocktailList() {
    return _provider.fetchAlcoholicCocktails();
  }
  
  Future<Cocktail> getRandomCocktail() {
    return _provider.fetchRandomCocktail();
  }

  Future<Cocktail> getCocktailDetails(String id) {
    return _provider.fetchCocktailDetails(id);
  }
}

class NetworkError extends Error {}