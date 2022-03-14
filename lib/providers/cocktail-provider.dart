import 'package:cocktails/models/cocktail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CocktailProvider {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://thecocktaildb.com/api/json/v1/1/';

  Future<Cocktail> fetchAlcoholicCocktails() async {
    try {

      Response response = await _dio.get(_baseUrl + 'filter.php?a=Alcoholic');
      if (kDebugMode) {


      }
      return Cocktail.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      return Cocktail.withError("Data not found / Connection issue");
    }
  }


  Future<Cocktail> fetchRandomCocktail() async {
    try {
      Response response = await _dio.get(_baseUrl + 'random.php');
      return Cocktail.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      return Cocktail.withError("Data not found / Connection issue");
    }
  }


  Future<Cocktail> fetchCocktailDetails(String id) async {
    try {
      Response response = await _dio.get(_baseUrl + 'lookup.php?i=' + id.toString());
      return Cocktail.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      return Cocktail.withError("Data not found / Connection issue");
    }
  }




}
