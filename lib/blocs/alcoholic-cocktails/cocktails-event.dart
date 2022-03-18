part of 'cocktail_bloc.dart';

abstract class CocktailEvent extends Equatable {
  const CocktailEvent();

  @override
  List<Object> get props => [];
}

class GetCocktailEvent extends CocktailEvent {}