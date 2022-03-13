import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/cocktail.dart';
import '../providers/api-repository.dart';

part 'random-cocktail-event.dart';
part 'random-cocktail-state.dart';

class RandomCocktailBloc extends Bloc<RandomCocktailEvent, RandomCockTailsState> {
  RandomCocktailBloc() : super(RandomCocktailInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetRandomCocktailEvent>((event, emit) async {
      try {
        emit(RandomCocktailsLoading());
        final mList = await _apiRepository.getRandomCocktail();
        if (kDebugMode) {
          print("Alcoholic List " + mList.drinks.length.toString());
        }
        emit(RandomCockTailsLoaded(mList));
        if (mList.error != null) {
          emit(RandomCocktailError(mList.error));
        }
      } on NetworkError {
        emit(const RandomCocktailError("Failed to fetch data. is your device online?"));
      }
    });
  }
}