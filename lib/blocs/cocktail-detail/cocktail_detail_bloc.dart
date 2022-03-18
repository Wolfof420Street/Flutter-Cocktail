import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/cocktail.dart';
import '../../providers/api-repository.dart';

part 'cocktail-detail-event.dart';
part 'cocktail-detail-state.dart';

class CocktailDetailBloc extends Bloc<CocktailDetailEvent, CockTailDetailState> {

  final String id;

  CocktailDetailBloc(this.id) : super(CocktailDetailInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetCocktailDetailEvent>((event, emit) async {
      try {
        emit(CocktailDetailsLoading());
        final mList = await _apiRepository.getCocktailDetails(id);
        if (kDebugMode) {
          print("Alcoholic List " + mList.drinks.length.toString());
        }
        emit(CockTailDetailsLoaded(mList));
        if (mList.error != null) {
          emit(CocktailDetailsError(mList.error));
        }
      } on NetworkError {
        emit(const CocktailDetailsError("Failed to fetch data. is your device online?"));
      }
    });
  }
}