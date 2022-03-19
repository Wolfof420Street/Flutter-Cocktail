import 'package:cocktails/models/cocktail.dart';
import 'package:cocktails/models/glass.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/category.dart';


class CocktailProvider {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://thecocktaildb.com/api/json/v1/1/';

  Future<Cocktail> fetchAlcoholicCocktails() async {
    try {
      Response response = await _dio.get(_baseUrl + 'filter.php?a=Alcoholic');
      if (kDebugMode) {}
      return Cocktail.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      return Cocktail.withError("Data not found / Connection issue");
    }
  }

  Future<Cocktail> fetchNonAlcoholicCocktails() async {
    try {
      Response response =
          await _dio.get(_baseUrl + 'filter.php?a=Non_Alcoholic');
      if (kDebugMode) {}
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

  Future<Categories> fetchCategories() async {
    try {
      Response response = await _dio.get(_baseUrl + 'list.php?c=list');
      return Categories.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      return Categories.withError("Data not found / Connection issue");
    }
  }

  Future<Glass> fetchGlasses() async {
    try {
      Response response = await _dio.get(_baseUrl + 'list.php?g=list');
      return Glass.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      return Glass.withError("Data not found / Connection issue");
    }
  }

  Future<Cocktail> fetchCocktailDetails(String id) async {
    try {
      Response response =
          await _dio.get(_baseUrl + 'lookup.php?i=' + id.toString());
      return Cocktail.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      return Cocktail.withError("Data not found / Connection issue");
    }
  }

  Future<Cocktail> fetchCocktailByGlass(String glass) async {
    try {
      Response response =
      await _dio.get(_baseUrl + 'filter.php?g=' + glass);
      return Cocktail.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      return Cocktail.withError("Data not found / Connection issue");
    }
  }

  Future<Cocktail> fetchCocktailByCategory(String category) async {
    try {
      Response response =
      await _dio.get(_baseUrl + 'filter.php?c=' + category);
      return Cocktail.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      return Cocktail.withError("Data not found / Connection issue");
    }
  }
}
