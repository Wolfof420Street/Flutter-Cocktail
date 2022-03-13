import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/cocktail.dart';
import '../providers/api-repository.dart';

part 'cocktails-event.dart';
part 'cocktail_state.dart';

class CocktailBloc extends Bloc<CocktailEvent, CockTailsState> {
  CocktailBloc() : super(CocktailInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetCocktailEvent>((event, emit) async {
      try {
        emit(CocktailsLoading());
        final mList = await _apiRepository.fetchAlcoholicCocktailList();
        if (kDebugMode) {
          print("Alcoholic List " + mList.drinks.length.toString());
        }
        emit(CockTailsLoaded(mList));
        if (mList.error != null) {
          emit(CocktailError(mList.error));
        }
      } on NetworkError {
        emit(const CocktailError("Failed to fetch data. is your device online?"));
      }
    });
  }
}